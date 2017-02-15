package com.jshpsoft.controller.operationMng;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TransportCostApply;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.service.OilPriceService;
import com.jshpsoft.service.ScheduleMngService;
import com.jshpsoft.service.TrackService;
import com.jshpsoft.service.TransportCostMngService;
import com.jshpsoft.service.TransportPrepayMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 装运费用核算(驾驶员报销)管理Controller
* @author  fengql 
* @date 2016年10月21日 上午11:26:33
 */
@Controller
@RequestMapping("/operationMng/transportCostMng")
public class TransportCostMngController {
	
	@Autowired  
	private ScheduleMngService scheduleMngService;
	
	@Autowired  
	private TrackService trackService;
	
	@Autowired  
	private TransportPrepayMngService transportPrepayMngService;
	
	@Autowired  
	private TransportCostMngService transportCostMngService;
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private OilPriceService oilPriceService;
	
	/**
	 * 驾驶员报销管理页面(日常办公)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/officeIndex",method=RequestMethod.GET)		
	public ModelAndView officeIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportCostMng/officeIndex");		
		return mv;		
	}
	
	/**
	 * 驾驶员报销新增页面(日常办公)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/addIndex",method=RequestMethod.GET)		
	public ModelAndView addIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportCostMng/addIndex");		
		return mv;		
	}
	
	/**
	 * 驾驶员报销编辑页面(日常办公)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/editIndex/{id}",method=RequestMethod.GET)		
	public ModelAndView editIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable Integer id ) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportCostMng/editIndex");
		mv.addObject("id",id);
		return mv;		
	}
	
	/**
	 * 驾驶员报销查看页面(日常办公)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/queryIndex/{id}",method=RequestMethod.GET)		
	public ModelAndView queryIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable Integer id ) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportCostMng/queryIndex");	
		mv.addObject("id",id);
		
		String type = request.getParameter("type");
		mv.addObject("type", type);
		
		return mv;		
	}
	
	/**
	 * 驾驶员报销待审核页面
	* @author  gll 
	* @date 2016年12月1日 上午
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/reviewIndex/{id}",method=RequestMethod.GET)		
	public ModelAndView reviewIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable Integer id ) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportCostMng/reviewIndex");	
		mv.addObject("id",id);
		return mv;		
	}
	/**
	 * 获取装运费用核算申请列表数据(日常办公)
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ carNumber-车牌号(String)、driverName-主副驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String)  
	* 						scheduleBillNo-调度单号        没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、applyTime-报账日期、carNumber-车牌号、driverId-驾驶员id、scheduleBillNo-调度单号、
	 * 								status-状态、mark-备注、insertTime-插入时间、updateTime更新时间  
	 * 								distance-公里数(int)、standardOilWear-核定油耗(double)、oilPrice-核定油价 (double)
	 * 								oilAmount-油费、amount-现金、driverName-主驾驶员、codriverName-副驾驶员、oilAndAmountSum-运费总成
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getOfficeListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getOfficeListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String loginId = CommonUtil.getOperId(request);//当前登录者id
			params.put("insertUser", loginId);
			String stockId = CommonUtil.getStockIdFromSession(request);
			params.put("stockId", stockId);
			Pager<TransportCostApply> pager = transportCostMngService.getPageData(params);
			pager.setFrontParams(params.get("sEcho"));
				
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取调度单号及相关信息--用于申请(根据车牌号查询)
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter  params{ carNumber-车牌号 }
	* @return	list [ scheduleBillNo-调度单号、carNumber-车牌号、driverId-驾驶员id 、driverName-驾驶员名称、 sendTime-发车时间、receiveTime-交车时间 、
	* 					startAddress-起运地、endAddress-目的地、amount-数量 ]
	 */
	@RequestMapping(value = "/getScheduleList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getScheduleList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("statusLest", Constants.ScheduleBillStatus.ONWAY);//至少在途状态
			List<ScheduleBill> list = scheduleMngService.getByConditions(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 获取驾驶员可以报销的调度单号
	 * @author  army.liu 
	 * @parameter  
	 * 
	 * @return
	 * {
	 * 		scheduleBillNo-调度单号、
	 * 		carNumber-车牌号、
	 * 		driverId-驾驶员id 、 
	 * 		driverName-驾驶员名称
	 * 		codriverId-副驾驶员id 、 
	 * 		codriverName-副驾驶员名称
	 * 		sendTime-发车时间、
	 * 		receiveTime-交车时间 、
	 * 		startAddress-起运地、
	 * 		endAddress-目的地、
	 * 		amount-数量 
	 * 		brand-品牌 
	 * 		preList --装运预付的信息
	 * 			[ prepayCash-预付现金(double)、bankName-开户行名称(String)、bankAccount-账号(String)、oilCardNo-油卡卡号(String)、
	 * 							   oilAmount-预付油费(double)、mark-备注(String)、status-状态：0-新建，1-待审核，2-待付款，3-已完成，4-已结算
	 * 			]
	 * }
	 * 
	 */
	@RequestMapping(value = "/getEnabledScheduleBill",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getEnabledScheduleBill(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("driverId", CommonUtil.getOperId(request));//司机名称
			params.put("status", Constants.ScheduleBillStatus.FINISH);//已完成状态
			params.put("delFlag", Constants.DelFlag.N);
			ScheduleBill bean = scheduleMngService.getEnabledScheduleBillInfo(params);//获取未报销的最早一条调度单信息
			
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 根据车牌号获取核定油耗--用于申请
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter   params [ carNumber-车牌号(String) ] 必传
	* @return	list[standardOilWear--核定油耗]
	 */
	@RequestMapping(value = "/getOilWear",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getOilWear(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("no", params.get("carNumber"));
			List<Track> list = trackService.getByConditions(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
//	/**
//	 * 获取油价--用于申请
//	* @author  fengql 
//	* @date 2016年10月9日 下午2:36:12 
//	* @parameter   
//	* @return	list[ type-油种、price-单价、insertTime-插入时间  ]
//	 */
//	@RequestMapping(value = "/getOilPrice",method=RequestMethod.POST,headers={"Content-Type=application/json"})
//	@ResponseBody
//	public Map<String, Object> getOilPrice(HttpServletRequest request, 
//			HttpServletResponse response,
//			HttpSession session
//			) throws Exception {
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("code", "300");
//		result.put("msg", "获取失败");
//		
//		try{
//			List<OilPrice> list = oilPriceService.getOilPriceList();
//			
//			result.put("data", list);
//			result.put("code", "200");
//			result.put("msg", "成功");
//			
//		}catch(Exception e){
//			e.printStackTrace();
//			result.put("msg", "获取失败："+e.getMessage());		
//		}		
//		return result;
//	}
	
	/**
	 * 根据车牌号获取预付信息--用于申请
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter  params [ carNumber-车牌号(String) ] 必传
	* @return	list [ id-id号、applyTime-申请时间、prepayCash-预付现金、oilAmount-预付油费、mark-备注  ]
	 */
	@RequestMapping(value = "/getPrepayApplyList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getPrepayApplyList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("orderDesc", "Y");
			params.put("status", Constants.PrepayApplyStatus.FINISH);//已完成
			List<TransportPrepayApply> list = transportPrepayMngService.getByConditions(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取品牌列表信息--用于申请
	* @author  fengql 
	* @date 2016年10月8日 下午2:29:34 
	* @parameter  
	* @return	List [ id-id号、brandName-名称 ]
	 */
	@RequestMapping(value = "/getBrandList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getBrandList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<CarBrand> list = commonService.getCarBrandList(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存装运费用核算申请
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:17:01 
	 * @parameter  { 
	 * 						applyTime-报账日期(date)、
	 * 						carNumber-车牌号(String)、
	 * 						driverId-驾驶员id、
	 * 						codriverId-副驾驶员id、
	 * 						scheduleBillNo-调度单号(String)、
	 * 						mark-备注(String)、
	 * 					  	prepayApplyIds-预付信息id,多个以,分隔(String)
	 * 						discountFlag-是否折现：Y-折现，N-不折现、
	 * 					  	costList 
	 * 								[ 
	 * 									brandName-品牌(String)、 
	 * 									sendTime-发车时间(date)、
	 * 									receiveTime-交车时间 (date)、
	 * 									count-台数(int)、
	 * 									startAddress-起运地(String)、
	 * 								  	endAddress-目的地(String)、 
	 * 								  	cashList 
	 * 											[ 
	 * 												name-内容名称(String)、amount-金额(double)、filePath-上传地址(String)、mark-备注
	 * 											]
	 * 							   	]
	 * 				 }
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TransportCostApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			transportCostMngService.save(bean, oper,request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 修改装运费用核算申请
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:17:01 
	 * @parameter  { 
	 * 						id-id号、
	 * 						applyTime-报账日期(date)、
	 * 						carNumber-车牌号(String)、
	 * 						driverId-驾驶员id、
	 * 						codriverId-副驾驶员id、
	 * 						scheduleBillNo-调度单号(String)、
	 * 						mark-备注(String)、
	 * 					  	prepayApplyIds-预付信息id,多个以,分隔(String)
	 * 						discountFlag-是否折现：Y-折现，N-不折现、
	 * 					  	costList 
	 * 								[ 
	 * 									brandName-品牌(String)、 
	 * 									sendTime-发车时间(date)、
	 * 									receiveTime-交车时间 (date)、
	 * 									count-台数(int)、
	 * 									startAddress-起运地(String)、
	 * 								  	endAddress-目的地(String)、 
	 * 								  	cashList 
	 * 											[ 
	 * 												id-id、name-内容名称(String)、amount-金额(double)、filePath-上传地址(String)、mark-备注
	 * 											]
	 * 							   	]
	 * 				 }
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TransportCostApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			transportCostMngService.update(bean, oper,request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取装运费用核算申请详细信息-用于修改、查看、打印明细
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	   {
	* 						id-id号、applyTime-报账日期、carNumber-车牌号、driverId-驾驶员id、driverName-驾驶员名称、scheduleBillNo-调度单号、
	* 						status-状态、mark-备注、prepayApplyIds-预付信息id、
	* 						distance-公里数(int)、standardOilWear-核定油耗(double)、oilPrice-核定油价 (double)、
	* 						amount-报账现金、oilAmount-报账油费、
	* 						discountFlag-是否折现：Y-折现，N-不折现、
	* 							oilDiscountLimit-折现上限(元)、oilDiscountPoint-折现扣点(%)、
	* 							discountTotalAmount-折现后总现金，如果折现的话(double)、discountTotalOilAmount-折现后总油费，如果折现的话(double)、discountAmount-折现油费对应的现金
	* 						balanceCash-实付总现金(double)、balanceCashNextMonth-下月实付现金(double)、balanceOil-实付油费(double)
	* 					  prepayList
	* 							 [ 
	* 								id-id号、applyTime-申请时间、prepayCash-预付现金、oilAmount-预付油费、mark-备注  
	* 							 ]
	 * 					  costList 
	 * 							 [ 
	 * 								id-id号、brandName-品牌、 sendTime-发车时间、receiveTime-交车时间 、count-台数、startAddress-起运地、endAddress-目的地、
	 * 								  distance-公里数、standardOilWear-核定油耗、oilPrice-核定油价  
	 * 								  cashList [ id-id号、type-类型、name-内容名称、amount-金额 、filePath-上传地址]
	 * 							 ]
	 * 					  taskList 
	 * 							 [ 
	 * 								id-id号、operateUserName-操作人、operateTime-操作时间、mark-备注  
	 * 							 ]
	 * 					  cashChangeLogList [ transportCostCashDetailId-费用明细id、oldAmount-修改前值、newAmount-修改后值、insertTime-操作时间、mark-修改原因 ]
	 * 				}
	 */
	@RequestMapping(value = "/getDetail/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			TransportCostApply bean = transportCostMngService.getById(id);
			
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 删除装运费用核算申请信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月21日 上午10:35:01
	* @parameter  id-id号(int)
	* @return
	 */
	@RequestMapping(value = "/delete/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "删除失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			transportCostMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 提交装运费用核算申请
	* @author  fengql 
	* @date 2016年10月14日 下午1:30:45 
	* @parameter  id-id号(int)
	* @return
	 */
	@RequestMapping(value = "/submit/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			transportCostMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 装运费用核算申请管理页面(财务部)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/financeIndex",method=RequestMethod.GET)		
	public ModelAndView financeIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportCostMng/financeIndex");		
		return mv;		
	}
	
	/**
	 * 获取装运费用核算申请列表数据(财务部)
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ carNumber-车牌号(String)、driverName-主副驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String) 
	* 						scheduleBillNo-调度单号                没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、applyTime-报账日期、carNumber-车牌号、driver-驾驶员、scheduleBillNo-调度单号、amount-现金、oilAndAmountSum-运费总成
	 * 								oilAmount-油费、status-状态、mark-备注、insertTime-插入时间、updateTime更新时间、driverName-主驾驶员、codriverName-副驾驶员
	 * 					 ]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getFinanceListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getFinanceListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);
			if( !"0".equals(stockId) ){
				params.put("stockId", stockId);
			}
			//状态:1,2,3,4,5,6,7
			params.put( "statusIn", Constants.CostApplyStatus.COSTAUDIT + "," + Constants.CostApplyStatus.DIRVERVERIFY + "," + 
					Constants.CostApplyStatus.OPERVERIFY + "," + Constants.CostApplyStatus.CASHAUDIT + "," + Constants.CostApplyStatus.CASHLEADERAUDIT + "," + Constants.CostApplyStatus.PAYVEFIRY + "," + Constants.CostApplyStatus.FINISH);
			Pager<TransportCostApply> pager = transportCostMngService.getPageData(params);
			pager.setFrontParams(params.get("sEcho"));
				
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 财务部的打印数据查询
	* @author  fengql 
	* @date 2016年10月21日 下午3:46:36 
	* @parameter  params [ carNumber-车牌号(String)、driverName-主副驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String)  ]  没有值的传''
	* 
	* @return	list [ id-id号、applyTime-报账日期、carNumber-车牌号、driverId-驾驶员id、dirverName-驾驶员名称、scheduleBillNo-调度单号、amount-现金、
	 * 					oilAmount-油费、status-状态、mark-备注、insertTime-插入时间、updateTime更新时间   ]
	 */
	@RequestMapping(value = "/getFinancePrint",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getFinancePrint(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);
			if( !"0".equals(stockId) ){
				params.put("stockId", stockId);
			}
			//状态:1,2,3,4,5,6,7
			params.put( "statusIn", Constants.CostApplyStatus.COSTAUDIT + "," + Constants.CostApplyStatus.DIRVERVERIFY + "," + 
					Constants.CostApplyStatus.OPERVERIFY + "," + Constants.CostApplyStatus.CASHAUDIT + "," + Constants.CostApplyStatus.CASHLEADERAUDIT + "," + Constants.CostApplyStatus.PAYVEFIRY + "," + Constants.CostApplyStatus.FINISH);
			List<TransportCostApply> list = transportCostMngService.getFinancePrint(params);
				
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 导出数据-财务部
	* @author  fengql 
	* @date 2016年10月19日 下午1:12:25 
	* @parameter  params [ carNumber-车牌号(String)、driverName-主副驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String)  ]   
	* 					   scheduleBillNo-调度单号     没有值的传''
	* 					 
	* @return	list [ applyTime-报账日期、carNumber-车牌号、driverId-驾驶员id、scheduleBillNo-调度单号、amount-现金、
	 * 					oilAmount-油费、status-状态、mark-备注、insertTime-插入时间、insertUser-插入人、
	 * 					updateTime-更新时间  、updateUser-更新人  ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("carNumber") String carNumber,
			@RequestParam("driverName") String driverName,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam("scheduleBillNo") String scheduleBillNo
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("carNumber", carNumber);
		params.put("driverName", driverName);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("scheduleBillNo", scheduleBillNo);
		String stockId = CommonUtil.getStockIdFromSession(request);
		if( !"0".equals(stockId) ){
			params.put("stockId", stockId);
		}
		//状态:1,2,3,4,5,6,7
		params.put( "statusIn", Constants.CostApplyStatus.COSTAUDIT + "," + Constants.CostApplyStatus.DIRVERVERIFY + "," + 
				Constants.CostApplyStatus.OPERVERIFY + "," + Constants.CostApplyStatus.CASHAUDIT + "," + Constants.CostApplyStatus.CASHLEADERAUDIT + "," + Constants.CostApplyStatus.PAYVEFIRY + "," + Constants.CostApplyStatus.FINISH);
		Map<String, Object> formatData = transportCostMngService.getExportData(params);

		String fileName = "驾驶员报销Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
}
