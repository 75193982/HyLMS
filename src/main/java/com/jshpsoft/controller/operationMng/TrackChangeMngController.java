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

import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleTrackChangeApply;
import com.jshpsoft.domain.Track;
import com.jshpsoft.service.ScheduleMngService;
import com.jshpsoft.service.TrackChangeMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 在途换车管理Controller
* @author  fengql 
* @date 2016年10月8日 下午4:46:14
 */
@Controller
@RequestMapping("/operationMng/trackChangeMng")
public class TrackChangeMngController {
	
	@Autowired  
	private TrackChangeMngService trackChangeMngService;
	
	@Autowired  
	private ScheduleMngService scheduleMngService;
	
	@Autowired  
	private CommonService commonService;
	
	/**
	 * 在途换车管理主页面
	* @author  fengql 
	* @date 2016年10月8日 下午4:47:19 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackChangeMng/index");		
		return mv;		
	}
	
	/**
	 * 获取换车申请列表数据
	* @author  fengql 
	* @date 2016年10月8日 下午4:59:19 
	* @parameter  params [ oldDriverId-原驾驶员(String)、newDriverId-新驾驶员(String)、scheduleBillNo-调度单号(String)、status-状态(String) 没有值传'' 
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、scheduleBillNo-调度单号、oldCarNumber-原货运车、oldDriverId-原驾驶员、oldDriverName、newCarNumber-新货运车、newDriverId-新驾驶员、newDriverName
	 * 							reason-原因、insertTime-申请时间、insertUser-申请人、submitTime-提交时间、auditTime-审核时间、auditUser-审核人、status-状态  ]
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
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			Pager<ScheduleTrackChangeApply> pager = trackChangeMngService.getPageData(params);
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
	 * 申请-获取调度单下拉数据--调度单中状态为在途并且未申请过的
	* @author  fengql 
	* @date 2016年10月8日 下午5:21:35 
	* @parameter  
	* @return	list [scheduleBillNo-调度单号、driverId-驾驶员、carNumber-货运车] 
	 */
	@RequestMapping(value = "/getSchBillNo",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSchBillNo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("status", Constants.ScheduleBillStatus.ONWAY);//4在途状态的
			params.put("delFlag", Constants.DelFlag.N);//未删除
			List<ScheduleBill> list = trackChangeMngService.getSchBillNo(params);
			
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
	 * 保存换车申请
	* @author  fengql 
	* @date  2016年10月8日  下午5:17:40 
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
			trackChangeMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "申请失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 获取换车申请详细信息-用于修改、提交、审核显示
	* @author  fengql 
	* @date 2016年10月9日 下午1:24:47 
	* @parameter  id-id号(int) 必传
	* @return	bean [ id-id号、scheduleBillNo-调度单号、reason-原因、oldDriverId-原驾驶员、oldCarNumber-原货运车牌号 、submitTime提交时间 ]
	 */
	@RequestMapping(value = "/getDetailData/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetailData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			ScheduleTrackChangeApply bean = trackChangeMngService.getById(id);
			
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
	 * 提交换车申请
	* @author  fengql 
	* @date 2016年10月8日 下午5:26:58 
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
			trackChangeMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 修改换车申请信息
	* @author  fengql 
	* @date 2016年10月9日 下午1:31:25 
	* @parameter  bean [ id-id号(int)、scheduleBillNo-调度单号(String)、reason-原因(String)、oldDriverId-原驾驶员(String)、oldCarNumber-原货运车牌号(String) ]
	* @return	
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ScheduleTrackChangeApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackChangeMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除换车申请--更新逻辑删除标志
	* @author  fengql 
	* @date 2016年10月8日 下午5:31:08 
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
			trackChangeMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取运输车辆信息
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter  
	* @return	list [ no-号码、driver-驾驶员 ]
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
	 * 审核通过
	* @author  fengql 
	* @date 2016年10月9日 下午1:34:15 
	* @parameter  params [ id-id号(int)、newCarNumber-新货运车(String)、newDriverId-新驾驶员(String) ]
	* @return
	 */
	@RequestMapping(value = "/auditSuccess",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> auditSuccess(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackChangeMngService.auditSuccess(params, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 审核不通过
	* @author  fengql 
	* @date 2016年10月9日 下午1:38:12 
	* @parameter  params [ id-id号(int)、auditContent-驳回理由(String) ]
	* @return
	 */
	@RequestMapping(value = "/auditFail",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> auditFail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackChangeMngService.auditFail(params, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取调度单的详细信息
	* @author  fengql 
	* @date 2016年9月22日 下午3:03:58 
	* @parameter  scheduleBillNo-调度单号(String) 必传
	* @return	  bean [  sendTime-发车时间、receiveTime-交车时间、planReachTime-预计到达时间、carNumber-货运车牌号、
	* 					  driverId-驾驶员、startAddress-出发地、endAddress-目的地
	* 					  detailList [  carShopId-4S店编号、mark-调度内容、amount-数量
	* 								            注意：当carShopId为空时，为二手车
	* 									carList [	waybillNo-运单原始编号、brand-品牌、model-车型、vin-车架号、color-颜色、
	* 					 							engineNo-发动机号、insertTime-入库时间  
	* 											]
	* 						  carAttachmentList [	position-存放位置、attachmentName-配件名称、outCount-出库数量
	* 											]
	* 								 ]
	* 					]
	 */
	@RequestMapping(value = "/getScheDetail/{scheduleBillNo}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getScheDetail(HttpServletRequest request, 
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
	
}
