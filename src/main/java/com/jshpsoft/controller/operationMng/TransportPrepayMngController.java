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
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.service.TransportPrepayMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 装运预付申请管理Controller
* @author  fengql 
* @date 2016年10月21日 上午11:26:33
 */
@Controller
@RequestMapping("/operationMng/transportPrepayMng")
public class TransportPrepayMngController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private TransportPrepayMngService transportPrepayMngService;
	
	/**
	 * 装运预付管理页面(日常办公)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/officeIndex",method=RequestMethod.GET)		
	public ModelAndView officeIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportPrepayMng/officeIndex");		
		return mv;		
	}
	
	/**
	 * 装运预付新增页面(日常办公)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/addIndex",method=RequestMethod.GET)		
	public ModelAndView addIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportPrepayMng/addIndex");		
		return mv;		
	}
	
	/**
	 * 装运预付编辑页面(日常办公)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/editIndex/{id}",method=RequestMethod.GET)		
	public ModelAndView editIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable Integer id ) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportPrepayMng/editIndex");	
		mv.addObject("id",id);
		return mv;		
	}
	
	/**
	 * 装运预付查看页面(日常办公)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/queryIndex/{id}",method=RequestMethod.GET)		
	public ModelAndView queryIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable Integer id ) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportPrepayMng/queryIndex");	
		mv.addObject("id",id);
		return mv;		
	}
	
	/**
	 * 获取货运车号信息--用于查询条件、新增申请
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter  
	* @return	list [ no-车牌号、driverId-驾驶员id、driverName-驾驶员名称 、 mobile-手机号码 ]
	 */
	@RequestMapping(value = "/getStockList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getStockList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("type", "0");//车头
			List<Track> list = commonService.getTrackList(params);
			
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
	 * 获取装运预付申请列表数据(日常办公)
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ carNumber-车牌号(String)、driverName-驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、scheduleBillNo-调度单号、carNumber-车牌号、driverId-驾驶员id、driverName-驾驶员名称、mobile-手机号码、applyTime-申请时间、prepayCash-预付现金、bankName-开户行名称、
	 * 								bankAccount-账号、oilCardNo-油卡卡号、oilAmount-预付油费、status-状态、mark-备注、insertTime-插入时间、updateTime更新时间  ]
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
			Pager<TransportPrepayApply> pager = transportPrepayMngService.getPageData(params);
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
	 * 获取品牌列表信息--用于申请明细
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
	 * 保存装运预付申请
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ carNumber-车牌号(String)、driverId-驾驶员id(int)、mobile-手机号码(String)、applyTime-申请时间(date)、prepayCash-预付现金(double)、
	* 					  bankName-开户行名称(String)、bankAccount-账号(String)、oilCardNo-油卡卡号(String)、oilAmount-预付油费(double)、mark-备注(String)
	 * 					  detailList [ brandName-品牌(String)、count-台数(int)、startAddress-起运地(String)、endAddress-目的地(String)、mark-备注(String) ]
	 * 				   ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TransportPrepayApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			transportPrepayMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取装运预付申请详细信息-用于修改、查看、打印明细
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [ id-id号、scheduleBillNo-调度单号、carNumber-车牌号、driverId-驾驶员id、driverName-驾驶员名称、mobile-手机号码、applyTime-申请时间、prepayCash-预付现金、bankName-开户行名称、
	 * 					  bankAccount-账号、oilCardNo-油卡卡号、oilAmount-预付油费、status-状态、mark-备注 、insertUser插入人 、insertTime-插入时间 、
	 * 					  updateUser-更新人、updateTime-更新时间 
	 * 					  detailList [ brandName-品牌、count-台数、startAddress-起运地、endAddress-目的地、mark-备注  ]
	 * 				   ]
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
			TransportPrepayApply bean = transportPrepayMngService.getById(id);
			
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
	 * 修改装运预付申请
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ id-id号(int)、carNumber-车牌号(String)、driverId-驾驶员Id(int)、mobile-手机号码(String)、applyTime-申请时间(date)、prepayCash-预付现金(double)、
	* 					  bankName-开户行名称(String)、bankAccount-账号(String)、oilCardNo-油卡卡号(String)、oilAmount-预付油费(double)、mark-备注(String)
	 * 					  detail [ brandName-品牌(String)、count-台数(int)、startAddress-起运地(String)、endAddress-目的地(String)、mark-备注(String) ]
	 * 				   ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TransportPrepayApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			transportPrepayMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除装运预付申请信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月21日 上午10:35:01
	* @parameter  id-id号(int) 必传
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
			transportPrepayMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 提交装运预付申请
	* @author  fengql 
	* @date 2016年10月14日 下午1:30:45 
	* @parameter  id-id号(int) 必传
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
			transportPrepayMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 装运预付管理页面(财务部)
	* @author  fengql 
	* @date 2016年10月21日 上午11:27:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/financeIndex",method=RequestMethod.GET)		
	public ModelAndView financeIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/transportPrepayMng/financeIndex");		
		return mv;		
	}
	
	/**
	 * 获取装运预付申请列表数据(财务部)
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ carNumber-车牌号(String)、driverName-驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String)、status-状态(String) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、scheduleBillNo-调度单号、carNumber-车牌号、driverId-驾驶员id、mobile-手机号码、applyTime-申请时间、prepayCash-预付现金、bankName-开户行名称、
	 * 								bankAccount-账号、oilCardNo-油卡卡号、oilAmount-预付油费、status-状态、mark-备注、insertTime-插入时间、updateTime-更新时间  ]
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
			//状态:
			params.put( "statusIn", Constants.PrepayApplyStatus.LEADERAUDIT + "," + Constants.PrepayApplyStatus.CASHAUDIT + "," + Constants.PrepayApplyStatus.CASHLEADERAUDIT
					+ "," + Constants.PrepayApplyStatus.CASHPAY + "," + Constants.PrepayApplyStatus.FINISH );
			Pager<TransportPrepayApply> pager = transportPrepayMngService.getPageData(params);
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
	* @parameter  params [ carNumber-车牌号(String)、driverName-驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String)、status-状态(String)  ]  没有值的传''
	* 
	* @return	list [ id-id号、scheduleBillNo-调度单号、carNumber-车牌号、driver-驾驶员、mobile-手机号码、applyTime-申请时间、prepayCash-预付现金、bankName-开户行名称、
	 * 					bankAccount-账号、oilCardNo-油卡卡号、oilAmount-预付油费、status-状态、mark-备注、insertTime-插入时间、updateTime-更新时间  ]
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
			//状态:
			params.put( "statusIn", Constants.PrepayApplyStatus.LEADERAUDIT + "," + Constants.PrepayApplyStatus.CASHAUDIT + "," + Constants.PrepayApplyStatus.CASHLEADERAUDIT
					+ "," + Constants.PrepayApplyStatus.CASHPAY + "," + Constants.PrepayApplyStatus.FINISH );
			List<TransportPrepayApply> list = transportPrepayMngService.getFinancePrint(params);
				
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
	* @parameter  params [ carNumber-车牌号(String)、driverName-驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String)、status-状态(String) ]    没有值的传''
	* 					 
	* @return	list [ scheduleBillNo-调度单号、carNumber-车牌号、driver-驾驶员、mobile-手机号码、applyTime-申请时间、prepayCash-预付现金、bankName-开户行名称、
	 * 					bankAccount-账号、oilCardNo-油卡卡号、oilAmount-预付油费、status-状态、mark-备注、
	 * 					insertTime-插入时间、insertUser-插入人、updateTime-更新时间  、updateUser-更新人  ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("carNumber") String carNumber,
			@RequestParam("driverName") String driverName,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam("status") String status
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("carNumber", carNumber);
		params.put("driverName", driverName);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("status", status);
		String stockId = CommonUtil.getStockIdFromSession(request);
		if( !"0".equals(stockId) ){
			params.put("stockId", stockId);
		}
		//状态:
		params.put( "statusIn", Constants.PrepayApplyStatus.LEADERAUDIT + "," + Constants.PrepayApplyStatus.CASHAUDIT + "," + Constants.PrepayApplyStatus.CASHLEADERAUDIT
				+ "," + Constants.PrepayApplyStatus.CASHPAY + "," + Constants.PrepayApplyStatus.FINISH );
		Map<String, Object> formatData = transportPrepayMngService.getExportData(params);

		String fileName = "装运预付申请Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
}
