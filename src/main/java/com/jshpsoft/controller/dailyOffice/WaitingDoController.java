package com.jshpsoft.controller.dailyOffice;

import java.util.HashMap;
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

import com.jshpsoft.domain.ProcessDetail;
import com.jshpsoft.domain.Task;
import com.jshpsoft.domain.TaskHistory;
import com.jshpsoft.service.TaskService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 
 * @Description: 待办事项controller
 * @author army.liu
 * @date 2016年10月8日 上午10:06:26
 *
 */
@Controller("waitingDoController")
@RequestMapping("/dailyOffice/waitingDo")
public class WaitingDoController {
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private CommonService commonService;
	
	/**
	 * @Description: 待办页面
	 * @author army.liu 
	 * @param request
	 * @param response
	 * @param session
	 * @return ModelAndView
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/index", method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletRequest response, HttpSession session) {
		ModelAndView view = new ModelAndView("/dailyOffice/waitingDo/index");
		
		return view;
	}
	
	/**
	 * @Description: 已办页面
	 * @author army.liu 
	 * @param request
	 * @param response
	 * @param session
	 * @return ModelAndView
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/hasDoIndex", method=RequestMethod.GET)
	public ModelAndView hasDoIndex(HttpServletRequest request, HttpServletRequest response, HttpSession session) {
		ModelAndView view = new ModelAndView("/dailyOffice/waitingDo/hasDoIndex");
		
		return view;
	}

	/**
	 * @Description: 获取我的待办列表数据
	 * @author  army.liu 
	 * @param
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 
	 * 		itemName -项目名称
	 * }
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-主键
	 * 								itemId-项目主键
	 * 								processDetailId-流程步骤主键
	 * 								receiveUserId-接收人id
	 * 								insertTime-提交时间
	 * 								insertUser-提交人主键
	 * 								insertUserName-提交人名称
	 * 								itemName-项目名称
	 * 								operateUserId-当前操作人主键
	 * 								cancelFlag-取消标记
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }  
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/getListData", method=RequestMethod.POST, headers={"Content-Type=application/json"})
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
			//只查看当前登录用户的数据
			params.put("userId", CommonUtil.getUserIdFromSession(request));
			
			Pager<Task> pager = taskService.getPageData(params);
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
	 * @Description: 待办详情页面
	 * @author army.liu 
	 * @param request
	 * @param response
	 * @param session
	 * @return ModelAndView
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/detail", method=RequestMethod.GET)
	public ModelAndView waitingDoDetail(HttpServletRequest request, HttpServletRequest response, HttpSession session) {
		ModelAndView view = new ModelAndView("/dailyOffice/waitingDo/detail");
		
		return view;
	}
	
	/**
	 * @Description: 获取当前审核操作对应的流程步骤信息
	 * @author  army.liu 
	 * @param
	 * {
	 *   	processDetailId-下一个流程步骤id
	 * }
	 * @return
 	 * {
	 * 			id-主键
	 * 	 		processId-业务流程id
	 *			orderNo-序号
	 *			name-步骤名称
	 *			type-操作类型：0-审核操作，1-确认操作
	 *			operateUserId-操作人id
	 *			operateUserName-操作人名称
	 * }
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/getProcessDetailInfo/{processDetailId}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getProcessDetailInfo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer processDetailId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			ProcessDetail pd = taskService.getProcessDetailInfo(processDetailId);
			result.put("data", pd);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put( "msg", "获取失败："+e.getMessage() );		
		}		
		return result;
	}
	
	/**
	 * @Description: 获取待办任务详细信息
	 * @author  army.liu 
	 * @param
	 * {
	 *   	itemId-项目主键
	 * }
	 * @return
 	 * {
 	 * 		item : { ----------------项目信息
	 * 					id-主键
	 * 					processId-流程主键
	 * 					processName-流程名称
	 * 					detailId-业务信息主键（如调度单主键）
	 * 					itemName-项目名称
	 * 					applyTime-申请时间
	 * 					applyUserId-申请人主键
	 * 					amount-金额
	 * 					mark-备注
	 * 					status-状态:0-新建，1-流转中，2-已完成
 	 * 			   }
 	 * 
 	 * 		taskHistory : 
 	 * 			   { -----------------操作日志信息
	 * 					id-主键
	 * 					itemId-项目主键
	 * 					processDetailId-流程步骤主键
	 * 					processDetailName-流程步骤名称
	 * 					operateUserId-操作人主键
	 * 					operateUserName-操作人名称
	 * 					operateTime-操作时间
	 * 					mark-备注
 	 * 					attachFileName-原始文件名称
 	 * 					attachFilePath-附件路径
 	 * 			   }
 	 * 
 	 * 		businessType -业务信息类型：参见Constants.ProcessType定义
 	 * 		detail : 
 	 * 			   { -----------------业务信息
 	 * 					
 	 * 			   }
	 * }
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/getDetailInfoForItem/{itemId}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetailInfoForItem(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer itemId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> data = taskService.getDetailInfoForItem(itemId);
			result.put("data", data);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put( "msg", "获取失败："+e.getMessage() );		
		}		
		return result;
	}
	
	/**
	 * @Description: 提交待办任务的审核结果
	 * @author  army.liu 
	 * @param
 	 * {
 	 * 		taskId-任务主键，字符串
 	 * 		successFlag-审核是否通过：Y-审核通过，N-审核不通过，字符串
 	 * 		mark-审核内容，字符串
 	 * 		attachFileName-原始文件名称
 	 * 		attachFilePath-附件路径
 	 * 		
 	 * 业务数据：
 	 * 		newCarNumber-车号，换车申请时
 	 * 		newDriverId-司机，换车申请时
 	 * 
 	 * 		[装运费用核算申请]
 	 * 		distance-公里数
 	 * 		balanceCash-结付驾驶员金额
 	 * 		balanceCashNextMonth-下月结付驾驶员金额
 	 * 		balanceOil-结付驾驶员油卡
 	 * 		cashChangeList : [ -变更费用-2016-11-29
 	 * 			transportCostCashDetailId-现金明细id
 	 * 			newAmount-更改金额
 	 * 			mark-更改原因
 	 * 		]
 	 * 		oilPrice-油价
 	 * 		amerce-罚款
 	 * 
 	 * 		prepareMoney-预付金额，办公费用申请/装运预付申请/折损费用申请
 	 * 
 	 * }
	 * @return
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/audit", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> audit(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String taskId = params.get("taskId") != null ? params.get("taskId").toString() : null;
			String mark = params.get("mark") != null ? params.get("mark").toString() : null;
			String successFlag = params.get("successFlag") != null ? params.get("successFlag").toString() : null;
			String attachFileName = params.get("attachFileName") != null ? params.get("attachFileName").toString() : null;
			String attachFilePath = params.get("attachFilePath") != null ? params.get("attachFilePath").toString() : null;
			int operId = CommonUtil.getUserIdFromSession(request);
			
			taskService.audit(taskId, operId+"", mark, successFlag, attachFileName, attachFilePath, params, request);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * @Description: 提交待办任务的审核结果-手机端
	 * @author  army.liu 
	 * @param
	 * {
	 * 		type-类型，字符串,调度单-02
	 * 		detailId-业务主键，字符串
	 * 		successFlag-审核是否通过：Y-审核通过，N-审核不通过，字符串
	 * 		mark-审核内容，字符串
	 * }
	 * @return
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/auditForApp", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> auditForApp(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String type = params.get("type") != null ? params.get("type").toString() : null;
			String detailId = params.get("detailId") != null ? params.get("detailId").toString() : null;
			
			String taskId = commonService.getTaskIdByBusinessType(type, detailId);
			String mark = params.get("mark") != null ? params.get("mark").toString() : null;
			String successFlag = params.get("successFlag") != null ? params.get("successFlag").toString() : null;
			int operId = CommonUtil.getUserIdFromSession(request);
			
			taskService.audit(taskId, operId+"", mark, successFlag, null, null, params, request);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * @Description: 取消待办事项（用于流程数据退回到新建人处，新建人取消流程时）
	 * @author  army.liu 
	 * @param
	 * {
	 *   	taskId-待办事项id
	 * }
	 * @return
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/cancelTask/{taskId}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> cancelTask(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer taskId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			taskService.cancelTask(taskId);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put( "msg", "取消失败："+e.getMessage() );		
		}		
		return result;
	}
	
	/**
	 * @Description: 获取已办列表数据
	 * @author  army.liu 
	 * @param
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 
	 * 		itemName -项目名称
	 * }
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-主键
	 * 								itemId-项目主键
	 * 								processDetailId-流程步骤主键
	 * 								operateUserId-操作人id
	 * 								operateTime-操作时间
	 * 								mark-备注
	 * 								attachFileName-附件名称
	 * 								attachFilePath-附件路径
	 * 								itemName-项目名称
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }  
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/getListDataForHasDo", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getListDataForHasDo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			//只查看当前登录用户的数据
			params.put("userId", CommonUtil.getUserIdFromSession(request));
			
			Pager<TaskHistory> pager = taskService.getPageDataForHasDo(params);
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
	 * 待办事项管理查询
	 * @author  ww 
	 * @date 2016年11月11日 下午3:49:49
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex", method=RequestMethod.GET)
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletRequest response, HttpSession session) {
		ModelAndView view = new ModelAndView("/dailyOffice/waitingDo/adminIndex");
		
		return view;
	}

	/**
	 * 得到待办事项管理列表数据(没有权限)
	 * @author  ww 
	 * @date 2016年11月11日 下午3:42:50
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getAllListData", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAllListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<Task> pager = taskService.getPageData(params);
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
	 * @Description: 获取待办任务详细信息
	 * @author  gll
	 * @param
	 * {
	 * 		type-WD-运单，DDD-调度单
	 *   	detailId-具体业务流程id
	 * }
	 * @return
 	 * {
 	 * 		
 	 * 
 	 * 		taskHistory : 
 	 * 			   { -----------------操作日志信息
	 * 					id-主键
	 * 					itemId-项目主键
	 * 					processDetailId-流程步骤主键
	 * 					processDetailName-流程步骤名称
	 * 					operateUserId-操作人主键
	 * 					operateUserName-操作人名称
	 * 					operateTime-操作时间
	 * 					mark-备注
 	 * 					attachFileName-原始文件名称
 	 * 					attachFilePath-附件路径
 	 * 			   }
 	 * 
	 * }
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/getDetailInfoDetailId",method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getDetailInfoDetailId(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> data = taskService.getDetailInfoDetailId(params);
			result.put("data", data);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put( "msg", "获取失败："+e.getMessage() );		
		}		
		return result;
	}
}
