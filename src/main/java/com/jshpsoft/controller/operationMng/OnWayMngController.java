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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleTrackChangeApply;
import com.jshpsoft.service.ScheduleMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 在途管理Controller
* @author  fengql 
* @date 2016年9月23日 上午9:28:36
 */
@Controller
@RequestMapping("/operationMng/onWayMng")
public class OnWayMngController {
	
	@Autowired  
	private ScheduleMngService scheduleMngService;
	
	@Autowired  
	private CommonService commonService;
	
	/**
	 * 在途管理嘱页面
	* @author  fengql 
	* @date 2016年9月23日 上午9:28:59 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/onWayMng/index");		
		return mv;		
	}

	/**
	 * 获取在途的调度单列表数据
	* @author  fengql 
	* @date 2016年9月23日 上午9:30:34 
	* @parameter   params [ sendTimeStart-开始发车时间(String)、sendTimeEnd-结束发车时间(String)、carNumber-货运车牌号(String)  没有值传''
	* 						pageStartIndex -页开始索引
	* 						pageSize -页大小
	* 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return	 {
	* 					records:[  scheduleBillNo-调度单号、sendTime-发车时间、receiveTime-交车时间、planReachTime-预计到达时间、
	* 					  			carNumber-货运车牌号、driver-驾驶员、amount-数量、mark-内容
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
			params.put("status", Constants.ScheduleBillStatus.ONWAY);//在途
//			params.put("stockId", CommonUtil.getStockIdFromSession(request));
//			params.put("insertUser", CommonUtil.getUserIdFromSession(request));
			params.put("driverId", CommonUtil.getUserIdFromSession(request));
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
	 * 获取4S店(经销单位)的下拉数据  
	* @author  fengql 
	* @date 2016年9月22日 下午1:26:57 
	* @parameter  List [ id-id号、name-名称  ]
	* @return
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
			Map<String, Object> params = new HashMap<String, Object>();
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
	 * 获取调度单的详细信息--用于编辑默认、查看详细功能
	* @author  fengql 
	* @date 2016年9月22日 下午3:03:58 
	* @parameter  scheduleBillNo-调度单号(String) 必传
	* @return	  bean [  scheduleBillNo-调度单号、sendTime-发车时间、receiveTime-交车时间、planReachTime-预计到达时间、carNumber-货运车牌号、driver-驾驶员、
	* 					  mobile-手机号码(String)、status-状态0-新建，1-待复核，2-待仓管员已确认，3-待驾驶员确认，4-在途，5-已完成
	* 	       以下为装运预付的信息：  preList[ prepayCash-预付现金(double)、bankName-开户行名称(String)、bankAccount-账号(String)、oilCardNo-油卡卡号(String)、
	* 							   oilAmount-预付油费(double)、mark-备注(String)、status-状态：0-新建，1-待审核，2-待付款，3-已完成，4-已结算
	* 							 ]
	* 					  detailList [  id-id号(不显示)、carShopId-4S店编号、carShopName-4S店名称、mark-调度内容、amount-数量、carStockIds-商品车id,多个以，连接
	* 									attachmentIds-配件id,多个以，连接,attachmentCounts-配件数量,多个以，连接、status-状态0-未完成，1-已完成
	* 									startAddress-出发地、targetProvince-目的省、targetCity-目的地
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
	 * 到达每个4S店时确认完成
	* @author  fengql 
	* @date 2016年9月22日 下午5:07:55 
	* @parameter  params [ scheduleBillNo-调度单号(String)、id-调度单明细id ]  必传
	* @return
	 */
	@RequestMapping(value = "/finish",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> finish(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "设置完成失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			scheduleMngService.finish(params, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "设置完成失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 调度单确认完成
	* @author  fengql 
	* @date 2016年9月22日 下午5:07:55 
	* @parameter  params [ scheduleBillNo-调度单号(String) ]  必传
	* @return
	 */
	@RequestMapping(value = "/finishAll",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> finishAll(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "确认失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			scheduleMngService.finishAll(params, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "确认失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存换车申请
	* @author  fengql 
	* @date 2016年9月22日 下午5:17:40 
	* @parameter  bean [ scheduleBillNo-调度单号(String)、reason-原因(String)、oldDriverId-原驾驶员(String)、oldCarNumber-原货运车牌号(String) ]
	* @return
	 */
	@RequestMapping(value = "/trackChangeApply",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> trackChangeApply(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ScheduleTrackChangeApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "申请失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			scheduleMngService.trackChangeApply(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "申请失败："+e.getMessage());		
		}		
		return result;
	}
	
	
}
