package com.jshpsoft.controller.operationMng;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.CarOutStockBill;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleBillChangeApply;
import com.jshpsoft.domain.Stock;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.UserRoles;
import com.jshpsoft.service.CarStockMangeService;
import com.jshpsoft.service.RoleService;
import com.jshpsoft.service.ScheduleMngService;
import com.jshpsoft.service.StockService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 调度管理Controller
* @author  fengql 
* @date 2016年9月22日 上午9:45:57
 */
@Controller
@RequestMapping("/operationMng/scheduleMng")
public class ScheduleMngController {
	
	@Autowired  
	private ScheduleMngService scheduleMngService;
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private CarStockMangeService carStockMangeService;
	
	@Autowired  
	private UserService userService;
	
	@Autowired  
	private StockService stockService;
	
	@Autowired  
	private RoleService roleService;
	
	/**
	 * 调度管理主页面
	* @author  fengql 
	* @date 2016年9月22日 上午9:47:01 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/index");		
		return mv;		
	}
	
	/**
	 * 新增调度单页面
	* @author  fengql 
	* @date 2016年10月10日 下午3:24:15 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/add",method=RequestMethod.GET)		
	public ModelAndView add(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/add");		
		return mv;		
	}
	
	/**
	 * 编辑调度单页面
	* @author  fengql 
	* @date 2016年10月10日 下午3:24:27 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/edit/{scheduleBillNo}",method=RequestMethod.GET)		
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable String scheduleBillNo
			) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/edit");	
		mv.addObject("scheduleBillNo",scheduleBillNo);
		return mv;		
	}
	
	/**
	 * 查看调度单详情页面
	* @author  fengql 
	* @date 2016年10月10日 下午3:24:39 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/detail/{scheduleBillNo}",method=RequestMethod.GET)		
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable String scheduleBillNo
			) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/detail");	
		mv.addObject("scheduleBillNo",scheduleBillNo);
		return mv;		
	}

	/**
	 * 获取调度单列表数据   
	* @author  fengql 
	* @date 2016年9月22日 上午9:50:17 
	* @parameter  params [ sendTimeStart-开始发车时间(String)、sendTimeEnd-结束发车时间(String)、carNumber-货运车牌号(String)、stockId
	* 			  			status-状态(String)  没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 					 ]
	* 
	* @return		{
	 * 					records:[  scheduleBillNo-调度单号、sendTime-发车时间、receiveTime-交车时间、planReachTime-预计到达时间、
	* 					  			carNumber-货运车牌号、driverId-驾驶员id、driverName-驾驶员名称、amount-数量、mark-内容、status-状态、stockId、stockName
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			//params.put("stockId", CommonUtil.getStockIdFromSession(request));
			params.put("insertUser", CommonUtil.getOperId(request));
			Pager<ScheduleBill> pager = scheduleMngService.getPageData(params);
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
	 * 获取运输车辆信息
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter  params[no-车牌号]
	* @return	list [ no-号码、driverId-驾驶员 、mobile-手机号码 、status-状态、codriverId-副驾驶员 ]
	 */
	@RequestMapping(value = "/getStockList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getStockList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String,Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
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
	 * 品牌名称、拼音、五笔模糊查询
	 * @author  ww 
	 * @date 2016年12月14日 上午9:53:04
	 * @parameter   params[brandName-品牌名称、py、wb]
	 * @return List [ id-id号、brandName-名称  ]
	 */
	@RequestMapping(value = "/getCarBrandList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarBrandList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String,Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			
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
	 * 获取4S店(经销单位)的下拉数据  
	* @author  fengql 
	* @date 2016年9月22日 下午1:26:57 
	* @parameter  params[name-4s店名称、py、wb]
	* @return		List [ id-id号、name-名称  ]
	 */
	@RequestMapping(value = "/getCarShopList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarShopList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String name = request.getParameter("name");
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("name", name);
			List<CarShop> list = commonService.getCarShopList(params);
			
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
	 * 根据4S店(经销单位)编号获取所有的商品车列表数据 
	* @author  fengql 
	* @date 2016年9月22日 下午1:29:25 
	* @parameter  params [ carShopId-4S店编号 (String) 必传
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return		{
	 * 					records:[ id-id号(不显示，用于保存)、waybillNo-运单原始编号、brand-品牌、model-车型、vin-车架号、color-颜色、
	* 					 			engineNo-发动机号、insertTime-入库时间 、scheduleBillNo-调度单号
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getCarList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			//2016.11.26注释--调度员可以看到所有的商品车
			/*String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号--根据登录者获取
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				params.put("stockId", stockId);*/
				params.put("type", "0");//类型：0-正常新车，1-二手车，2-折损车
				params.put("status", Constants.CarStatus.HASIN);//1已入库
				params.put("delFlag", Constants.DelFlag.N);
				
				Pager<CarStock> pager = carStockMangeService.getCarList(params);
				pager.setFrontParams(params.get("sEcho"));
				
				result.put("data", pager);
				result.put("code", "200");
				result.put("msg", "成功");
			//}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 根据4S店(经销单位)编号获取配件列表数据
	* @author  fengql 
	* @date 2016年9月23日 下午3:26:07 
	* @parameter  params [ carShopId-4S店编号 (String)  必传
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return  		{
	 * 					records:[ id-id号(不显示，用于保存)、position-存放位置、attachmentName-配件名称、count-数量  ]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getCarAttachmentList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarAttachmentList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			//2016.11.26注释--调度员可以看到所有的商品车
			/*String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号--根据登录者获取
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				params.put("stockId", stockId);*/
				params.put("type", "0");//类型：0-正常新车，1-二手车，2-折损车
				params.put("delFlag", Constants.DelFlag.N);
				
				Pager<CarAttachmentStock> pager = scheduleMngService.getPageCarAttachmentData(params);
				pager.setFrontParams(params.get("sEcho"));
				
				result.put("data", pager);
				result.put("code", "200");
				result.put("msg", "成功");
			//}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取二手车列表数据 
	* @author  fengql 
	* @date 2016年9月22日 下午1:29:25 
	* @parameter  params [ 	pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return		{
	 * 					records:[ id-id号(不显示，用于保存)、waybillNo-运单原始编号、brand-品牌、model-车型、vin-车架号、color-颜色、
	* 					 			engineNo-发动机号、insertTime-入库时间 、scheduleBillNo-调度单号
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getSecCarList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSecCarList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号--根据登录者获取
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				params.put("stockId", stockId);
				params.put("type", "1");//类型：0-正常新车，1-二手车，2-折损车
				params.put("status", Constants.CarStatus.HASIN);//1已入库
				params.put("delFlag", Constants.DelFlag.N);
				
				Pager<CarStock> pager = carStockMangeService.getCarList(params);
				pager.setFrontParams(params.get("sEcho"));
				
				result.put("data", pager);
				result.put("code", "200");
				result.put("msg", "成功");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取二手车配件列表数据
	* @author  fengql 
	* @date 2016年9月23日 下午3:40:08 
	* @parameter  params [ 	pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return		{
	 * 					records:[ id-id号(不显示，用于保存)、position-存放位置、attachmentName-配件名称、count-数量  ]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getSecCarAttachmentList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSecCarAttachmentList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号--根据登录者获取
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				params.put("stockId", stockId);
				params.put("type", "1");//类型：0-正常新车，1-二手车，2-折损车
				params.put("delFlag", Constants.DelFlag.N);
				
				Pager<CarAttachmentStock> pager = scheduleMngService.getPageCarAttachmentData(params);
				pager.setFrontParams(params.get("sEcho"));
				
				result.put("data", pager);
				result.put("code", "200");
				result.put("msg", "成功");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存新建调度单   
	* @author  fengql 
	* @date 2016年9月22日 下午1:13:01 
	* @parameter  bean [  scheduleBillNo-调度单号，根据是否存在判断是新建还是编辑 (String) 
	* 					  sendTime-发车时间(date)、receiveTime-交车时间(date)、planReachTime-预计到达时间(date)、carNumber-货运车牌号(String)、
	* 					  driverId-驾驶员(String)、amount-数量(int)、mark-调度内容(String)、
	* 	        以下为装运预付的信息：  mobile-手机号码(String)、prepayCash-预付现金(double)、bankName-开户行名称(String)、bankAccount-账号(String)、
	* 					  oilCardNo-油卡卡号(String)、oilAmount-预付油费(double)
	* 					  detailList [  carShopId-4S店编号(int)、mark-调度内容(String)、amount-数量(int)、carStockIds-商品车id,多个以，连接(String)
	* 									attachmentIds-配件id,多个以，连接(String),attachmentCounts-配件数量,多个以，连接(String)
	* 									startProvince 出发地省份，startAddress-出发地(String)、targetProvince-目的省(String)、targetCity-目的地(String)
	* 								            注意：当为二手车时，carShopId为空
	* 								 ]
	* 					]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ScheduleBill bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			String stockId = CommonUtil.getStockIdFromSession(request);
			bean.setStockId(Integer.parseInt(stockId));
			scheduleMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 追加调度单的预付信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ scheduleBillNo-调度单号(String)、prepayCash-预付现金(double)、bankName-开户行名称(String)、bankAccount-账号(String)、
	* 					  oilCardNo-油卡卡号(String)、oilAmount-预付油费(double)、mark-备注(String)]
	* @return
	 */
	@RequestMapping(value = "/addPrepay",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> addPrepay(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TransportPrepayApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "追加预付失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			scheduleMngService.addPrepay(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "追加预付失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取调度单的详细信息--用于编辑默认、查看详细功能
	* @author  fengql 
	* @date 2016年9月22日 下午3:03:58 
	* @parameter  scheduleBillNo-调度单号(String) 必传
	* @return	  bean [  scheduleBillNo-调度单号、sendTime-发车时间、receiveTime-交车时间、planReachTime-预计到达时间、carNumber-货运车牌号、driverId-驾驶员id、driverName-驾驶员名称
	* 					  mobile-手机号码(String)、status-状态0-新建，1-待复核，2-待仓管员已确认，3-待驾驶员确认，4-在途，5-已完成
	* 	       以下为装运预付的信息：  preList[ prepayCash-预付现金(double)、bankName-开户行名称(String)、bankAccount-账号(String)、oilCardNo-油卡卡号(String)、
	* 							   oilAmount-预付油费(double)、mark-备注(String)、status-状态：0-新建，1-待审核，2-待付款，3-已完成，4-已结算
	* 							 ]
	* 					  detailList [  id-id号(不显示)、carShopId-4S店编号、carShopName-4S店名称、mark-调度内容、amount-数量、carStockIds-商品车id,多个以，连接
	* 									attachmentIds-配件id,多个以，连接,attachmentCounts-配件数量,多个以，连接、status-状态0-未完成，1-已完成
	* 									startProvince 出发地省份，startAddress-出发地、targetProvince-目的省、targetCity-目的地
	* 								            注意：当carShopId为空时，为二手车
	* 									carList [	id-id号(不显示)、waybillNo-运单原始编号、brand-品牌、model-车型、vin-车架号、color-颜色、
	* 					 							engineNo-发动机号、insertTime-入库时间  
	* 											]
	* 						  carAttachmentList [	id-id号(不显示)、position-存放位置、attachmentName-配件名称、count-库存数量 、outCount-出库数量
	* 											]
	* 								 ]
	* 					]
	 */
	@RequestMapping(value = "/getDetailData/{scheduleBillNo}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetailData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String scheduleBillNo
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			ScheduleBill bean = scheduleMngService.getDetailData(scheduleBillNo);
			
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
	 * 删除调度单信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月22日 下午4:01:05 
	* @parameter  scheduleBillNo-调度单号(String) 必传
	* @return
	 */
	@RequestMapping(value = "/delete/{scheduleBillNo}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String scheduleBillNo
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "删除失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			scheduleMngService.updateByBillNo(scheduleBillNo, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 提交调度单信息
	* @author  fengql 
	* @date 2016年9月22日 下午4:03:53 
	* @parameter  scheduleBillNo-调度单号(String) 必传
	* @return
	 */
	@RequestMapping(value = "/submit/{scheduleBillNo}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String scheduleBillNo
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			scheduleMngService.submit(scheduleBillNo, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 管理员调度管理主页面
	* @author  fengql 
	* @date 2016年9月22日 上午9:47:01 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/adminiIndex",method=RequestMethod.GET)		
	public ModelAndView adminiIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/adminiIndex");		
		return mv;		
	}
	
	/**
	 * 管理员查看调度单详情页面
	* @author  fengql 
	* @date 2016年10月10日 下午3:24:39 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/adminiDetail/{scheduleBillNo}",method=RequestMethod.GET)		
	public ModelAndView adminiDetail(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable String scheduleBillNo
			) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/adminiDetail");	
		mv.addObject("scheduleBillNo",scheduleBillNo);
		return mv;		
	}
	
	/**
	 * 获取管理员调度单列表数据   
	* @author  fengql 
	* @date 2016年9月22日 上午9:50:17 
	* @parameter  params [ sendTimeStart-开始发车时间(String)、sendTimeEnd-结束发车时间(String)、carNumber-货运车牌号(String)、
	* 			  			status-状态(String)  没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 					 ]
	* 
	* @return		{
	 * 					records:[  scheduleBillNo-调度单号、sendTime-发车时间、receiveTime-交车时间、planReachTime-预计到达时间、
	* 					  			carNumber-货运车牌号、driverId-驾驶员id、driverName-驾驶员名称、amount-数量、mark-内容、status-状态
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getAdminiListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAdminiListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			//params.put("stockId", CommonUtil.getStockIdFromSession(request));
			Pager<ScheduleBill> pager = scheduleMngService.getPageData(params);
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
	 * 获取调度员下拉列表
	 * @author  ww 
	 * @date 2016年12月28日 下午4:24:06
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getSchUser",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getSchUser(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<User> list = new ArrayList<User>();
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("name", "调度员");
			List<Role> roleList = roleService.getByConditions(params);
			params.clear();
			params.put("delFlag", Constants.DelFlag.N);
			List<User> l = userService.getByConditions(params);
			if(null != roleList && roleList.size() > 0)
			{
				params.clear();
				params.put("roleId", roleList.get(0).getId());
				List<UserRoles> urList = userService.getUserRolesList(params);
				if(null != urList && urList.size() > 0)
				{
					for(int i = 0;i<urList.size();i++)
					{
						if(null != l && l.size() > 0)
						{
							for(int j = 0;j<l.size();j++)
							{
								if(urList.get(i).getUserId().equals(l.get(j).getId()))
								{
									list.add(l.get(j));
								}
							}
						}
					}
					
				}
			}
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
	 * 查询系统- 汇总查询页面
	 * @author  ww 
	 * @date 2016年12月28日 下午3:44:22
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/sumSearchIndex",method=RequestMethod.GET)		
	public ModelAndView sumSearchIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/sumSearchIndex");		
		return mv;		
	}
	
	
	/**
	 * 汇总 查询
	 * @author  ww 
	 * @date 2016年12月30日 上午9:51:41
	 * @parameter  params[stockId-仓库、insertUser-调度员id]
	 * @return bean[insertUser-调度员id、insertUserName-调度员名字、degree-发车次数、amount-装运台数]
	 */
	@RequestMapping(value = "/getGroupByUser",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getGroupByUser(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,@RequestBody Map<String,Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Pager<ScheduleBill> pager = scheduleMngService.getGroupByUserPageData(params);
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "查询失败："+e.getMessage());	
		}
		return result;
		
	}
	
	
	
	
	/**
	 * 获取商品车出库单数据
	* @author  fengql 
	* @date 2016年11月11日 下午1:39:32 
	* @parameter  scheduleBillNo-调度单号(String) 必传
	* @return	list [ id-id号、scheduleBillNo-调度单号、carShopName-4S店名称、type-类型、startAddress-出发地、targetAddress-目的地、receiveUser-接车联系人、receiveUserTelephone-接车联系人电话、
	* 					receiveUserMobile-接车联系人手机号、carBrand-品牌、carVin-车架号、carModel-车型、carColor-颜色、carEngineNo-发动机号、carMark-备注、
	* 					attachmentName-配件名称、attachmentCount-数量、insertTime-插入时间 ]
	 */
	@RequestMapping(value = "/getCarOutStockBillData/{scheduleBillNo}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getCarOutStockBillData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String scheduleBillNo
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<CarOutStockBill> bean = scheduleMngService.getCarOutStockBillData(scheduleBillNo);
			
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
	 * 仓管员调度页面
	* @author  fengql 
	* @date 2016年9月22日 上午9:47:01 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/storeIndex",method=RequestMethod.GET)		
	public ModelAndView storeIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/storeIndex");		
		return mv;		
	}
	
	/**
	 * 驾驶员调度页面
	* @author  fengql 
	* @date 2016年9月22日 上午9:47:01 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/driverIndex",method=RequestMethod.GET)		
	public ModelAndView driverIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/driverIndex");		
		return mv;		
	}
	
	/**
	 * 查看驾仓管员、驶员调度单详情页面
	* @author  fengql 
	* @date 2016年10月10日 下午3:24:39 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/detailIndex/{scheduleBillNo}",method=RequestMethod.GET)		
	public ModelAndView detailIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable String scheduleBillNo
			) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/detailIndex");	
		mv.addObject("scheduleBillNo",scheduleBillNo);
		return mv;		
	}
	
	/**仓管员、驾驶员
	 * 获取调度单列表数据   
	* @author  fengql 
	* @date 2016年9月22日 上午9:50:17 
	* @parameter  params [ sendTimeStart-开始发车时间(String)、sendTimeEnd-结束发车时间(String)、carNumber-货运车牌号(String)  没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 					 ]
	* 
	* @return		{
	 * 					records:[  scheduleBillNo-调度单号、sendTime-发车时间、receiveTime-交车时间、planReachTime-预计到达时间、
	* 					  			carNumber-货运车牌号、driverId-驾驶员id、driverName-驾驶员名称、amount-数量、mark-内容、status-状态
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getOwnListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getOwnListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			int currUserId = CommonUtil.getUserIdFromSession(request);
			params.put("userId", currUserId);
			//仓库id-运单、调度单有用
			int stockId = 0;
			User user = userService.getById( currUserId );
			if( null != user ){
				if( StringUtils.isNotEmpty(user.getStockId()) ){
					stockId = Integer.parseInt(user.getStockId());
				}
			}
				
			String processId = commonService.getProcessId(stockId, Constants.ProcessType.DDD );////02调度单
			params.put("processId", processId);
			Pager<ScheduleBill> pager = scheduleMngService.getOwnPageData(params);
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
	 * 根据调度单号获取所有的商品车列表数据 
	 * @author  army.liu 
	 * @date 2016年9月22日 下午1:29:25 
	 * @parameter 	{
	 * 					scheduleBillNo-调度单号
	 * 				}
	 * @return		{
	 * 					[ 
	 * 						id-id号、waybillNo-运单原始编号、brand-品牌、model-车型、vin-车架号、color-颜色、
	 * 					 			engineNo-发动机号、scheduleBillNo-调度单号、carShopName-4s店
	 * 					]
	 * 				}
	 */
	@RequestMapping(value = "/getCarListForScheduleBillNo/{scheduleBillNo}",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarListForScheduleBillNo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String scheduleBillNo
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<CarStock> list = carStockMangeService.getCarListForScheduleBillNo(scheduleBillNo);
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
	 * 得到仓库下拉
	 * @author  ww 
	 * @date 2016年12月6日 上午9:26:32
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getBasicStockList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getBasicStockList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			List<Stock> list = stockService.getByConditions(params);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	//-----------------------------------------------------------快速调度相关接口----------------------------------------------------------------------------------
	/**
	 * 获取供应商下拉
	 * @author  ww 
	 * @date 2017年2月13日 下午3:13:16
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getBasicSuppliersList", method = RequestMethod.GET)
	@ResponseBody
	public List<Supplier> getBasicSuppliersList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws Exception {

		/*Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");*/
		List<Supplier> suppliersList = new ArrayList<Supplier>();
		try {
			
			suppliersList = commonService.getComSuppliersList();
			/*result.put("data", suppliersList);
			result.put("code", "200");
			result.put("msg", "获取成功");*/

		} catch (Exception e) {
			e.printStackTrace();
			//result.put("msg", "获取失败" );
		}
		return suppliersList;
	}
	
	/**
	 * 快速调度管理主页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/fastIndex",method=RequestMethod.GET)		
	public ModelAndView fastIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/fastIndex");	
		
		String scheduleBillNo = request.getParameter("scheduleBillNo");
		if( StringUtils.isNotEmpty(scheduleBillNo) ){
			mv.addObject("scheduleBillNo", scheduleBillNo);//需要回显
		}
		return mv;		
	}
	
	/**
	 * 获取最新的调度单号
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getLatestBillNo",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getLatestBillNo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String latestBillNo = commonService.createBusinessBillNo(Constants.BusinessType.DDD, CommonUtil.getUserIdFromSession(session));
			result.put("data", latestBillNo);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取未完成的调度单号
	 * @author  army.liu 
	 * @parameter  {
	 * 		scheduleBillNo-调度单号，模糊查询
	 * }
	 * @return
	 */
	@RequestMapping(value = "/getUnFinishedBillNo",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getUnFinishedBillNo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("type", Constants.ScheduleBillType.FAST);
			params.put("delFlag", Constants.DelFlag.N);
			params.put("statusLess", Constants.ScheduleBillStatus.ONWAY);//非已完成的
			params.put("insertUser", CommonUtil.getUserIdFromSession(request));
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
	 * 保存调度单-快速调度   
	 * @author  army.liu 
	 * @parameter 
  	 * {
  	 * 		id-调度单主键
  	 * 		scheduleBillNo-调度单号
	 * 		sendTime-装运时间(date)
	 * 		carNumber-货运车牌号(String)
	 * 		driverId-驾驶员id(int)
	 * 		amount-总数
	 * 
	 * 		------装运预付的信息
	 * 		mobile-联系方式、
	 * 		prepayCash-预付现金(double)、
	 * 		bankName-开户行名称(String)、
	 *  	bankAccount-账号(String)、
	 * 		oilCardNo-油卡卡号(String)、
	 * 		oilAmount-预付油费(double)、
	 * 		prepayTime-预付时间(date)
	 * 
	 * 		detailList : [        --------商品车信息
	 * 			type:0-商品车，1-配件，2-二手车,int
	 * 			waybillNo-运单号(String)
	 * 			supplierId-供应商id（运单）
	 * 			money-金额(保存到车库存表  二手车)
	 * 			brandName-品牌(String)
	 * 			carStyle-车型(String)
	 * 			count-台数,int
	 * 			sendTime-托运时间,yyyy-MM-dd
	 * 			arrivalTime-交车时间,yyyy-MM-dd
	 * 			carShopId-4S店编号(int)、
	 * 			carShopName-4S店名称(String)
	 * 			startProvince 出发地省份、
	 * 			startAddress-出发地(String)、
	 * 	        mark-备注(String)、
	 * 			vinList:[		   --------车架号信息
	 * 				车架号(String)
	 * 			]
	 * 			waybillNo-运单号
	 * 		]
	 * }
	 * @return
	 */
	@RequestMapping(value = "/saveForFast",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> saveForFast(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ScheduleBill bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);
			bean.setStockId(Integer.parseInt(stockId));
			scheduleMngService.saveForFast(bean, CommonUtil.getUserIdFromSession(request));
			
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 查看快速调度详细页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/fastDetailIndex/{scheduleBillNo}/{type}",method=RequestMethod.GET)		
	public ModelAndView fastDetailIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable String scheduleBillNo,
			@PathVariable String type
			) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/fastDetailIndex");		
		mv.addObject("scheduleBillNo",scheduleBillNo);
		mv.addObject("type",type);//用于前台参数判断
		return mv;		
	}
	
	/**
	 * 获取调度单详细信息-快速调度   
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		scheduleBillNo-调度单号
	 * }
	 * @return
	 * {
	 * 		id-调度主键
	 * 		scheduleBillNo-调度单号
	 * 		sendTime-装运时间(date)
	 * 		carNumber-货运车牌号(String)
	 * 		driverId-驾驶员id(int)
	 * 		driverName-驾驶员名称
	 * 		mobile-手机号码
	 * 		amount-总数
	 * 		modifyEnabledFlag-可修改标记：Y-可修改，N-不可修改
	 * 		insertUser-创建人id
	 * 		insertUserName-创建人名称
	 * 
	 * 		------装运预付的信息
	 * 		transportCostApplyId-预付id
	 * 		prepayCash-预付现金(double)、
	 * 		bankName-开户行名称(String)、
	 *  	bankAccount-账号(String)、
	 * 		oilCardNo-油卡卡号(String)、
	 * 		oilAmount-预付油费(double)、
	 * 		prepayTime-预付时间(date)
	 * 
	 * 		detailList : [        --------商品车信息
	 * 			type:0-商品车，1-配件，2-二手车,int
	 * 			waybillNo-运单号(String)
	 * 			brandName-品牌(String)，格式：品牌-车型
	 * 			carStyle-车型(String)
	 * 			count-台数,int
	 * 			sendTime-托运时间,yyyy-MM-dd
	 * 			arrivalTime-交车时间,yyyy-MM-dd
	 * 			carShopId-4S店编号(int)、
	 * 			carShopName-4S店名称(String)
	 * 			startProvince 出发地省份，
	 * 			startAddress-出发地(String)、
	 * 	        mark-备注(String)、
	 * 			vinList:[		   --------车架号信息
	 * 				车架号(String)
	 * 			]
	 * 			waybillNo-运单号
	 * 		]
	 * }
	 */
	@RequestMapping(value = "/getScheduleDetailForFast/{scheduleBillNo}")
	@ResponseBody
	public Map<String, Object> getScheduleDetailForFast(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String scheduleBillNo
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			ScheduleBill detail = scheduleMngService.getScheduleDetailForFast( scheduleBillNo );
			
			result.put("data", detail);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "查询失败："+e.getMessage());		
		}		
		return result;
	}
	
	//----------------------------------------------------------------------调度修改申请相关接口-------------------------------------------------------------------------
	/**
	 * 提交申请修改
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		scheduleBillNo-调度单号
	 * 		reason-修改原因
	 * }
	 * @return
	 */
	@RequestMapping(value = "/submitScheduleBillChangeApply", method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> submitScheduleBillChangeApply(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ScheduleBillChangeApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			scheduleMngService.applyModifyScheduleForFast( bean.getScheduleBillNo(), CommonUtil.getUserIdFromSession(request) ,bean.getReason());
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "申请失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 调度修改申请列表页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/changeApplyIndex",method=RequestMethod.GET)		
	public ModelAndView changeApplyIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/changeApplyIndex");		
		return mv;		
	}
	
	/**
	 * 调度修改审核列表页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/changeApplyAuditIndex",method=RequestMethod.GET)		
	public ModelAndView changeApplyAuditIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/scheduleMng/changeApplyAuditIndex");		
		return mv;		
	}
	
	/**
	 * 获取调度单修改申请的审核列表数据   
	 * @author  army.liu 
	 * @parameter   [ 
	 * 						scheduleBillNo-调度单号，模糊查询
	 * 			  			status-状态(String)  没有值传''
	 * 
	 * 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 				]
	 * 
	 * @return		{
	 * 					records:[  scheduleBillNo-调度单号、applyUserId-申请人id、applyUserName-申请人名称、auditUserId-审核人id、auditUserName-审核人名称、reason-修改原因、mark-备注
	 * 								status-状态：0-待复核，1-审核通过，2-审核未通过，3-已修改
	 * 								insertTime-创建时间
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getScheduleBillChangeApplyListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getScheduleBillChangeApplyListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("insertUser", CommonUtil.getUserIdFromSession(request));
			Pager<ScheduleBillChangeApply> pager = scheduleMngService.getScheduleBillChangeApplyPageData(params);
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
	 * 获取调度单修改申请的审核列表数据   
	 * @author  army.liu 
	 * @parameter   [ 
	 * 						scheduleBillNo-调度单号，模糊查询
	 * 			  			status-状态(String)  没有值传''
	 * 
	 * 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 				]
	 * 
	 * @return		{
	 * 					records:[  scheduleBillNo-调度单号、applyUserId-申请人id、applyUserName-申请人名称、auditUserId-审核人id、auditUserName-审核人名称、reason-修改原因、mark-备注
	 * 								status-状态：0-待复核，1-审核通过，2-审核未通过，3-已修改
	 * 								insertTime-创建时间
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getScheduleBillChangeApplyAuditListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getScheduleBillChangeApplyAuditListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("auditUserId", CommonUtil.getUserIdFromSession(request));
			Pager<ScheduleBillChangeApply> pager = scheduleMngService.getScheduleBillChangeApplyPageData(params);
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
	 * 审核申请修改
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		scheduleBillApplyIds-id,多个;连接
	 * 		auditResult-审核结果：Y-通过，N-未通过
	 * 		auditSuggest-审核意见
	 * }
	 * @return
	 */
	@RequestMapping(value = "/auditScheduleBillChangeApply", method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> auditScheduleBillChangeApply(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, String> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String scheduleBillApplyIds = params.get("scheduleBillApplyIds");
			String auditResult = params.get("auditResult");
			String auditSuggest = params.get("auditSuggest");
			if( StringUtils.isEmpty(scheduleBillApplyIds) ){
				throw new RuntimeException("申请ID不能为空！");
			}
			if( StringUtils.isEmpty(auditResult) ){
				throw new RuntimeException("审核结果不能为空！");
			}
			scheduleMngService.auditScheduleBillChangeApply(scheduleBillApplyIds, auditResult, auditSuggest, CommonUtil.getUserIdFromSession(request) );
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "申请失败："+e.getMessage());		
		}		
		return result;
	}

	
	
}

