package com.jshpsoft.controller.dailyOffice;

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

import com.jshpsoft.domain.Item;
import com.jshpsoft.service.TaskService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 
 * @Description: 办公申请controller
 * @author army.liu
 * @date 2016年10月12日 上午10:06:26
 *
 */
@Controller("officeApplyController")
@RequestMapping("/dailyOffice/officeApply")
public class OfficeApplyController {
	
	@Autowired
	private TaskService taskService;
	
	/**
	 * @Description: 办公申请列表页面
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
		ModelAndView view = new ModelAndView("/dailyOffice/officeApply/index");
		
		return view;
	}
	
	/**
	 * 办公费用管理
	 * @author  ww 
	 * @date 2016年10月26日 下午3:21:02
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/financeIndex", method=RequestMethod.GET)
	public ModelAndView financeIndex(HttpServletRequest request, HttpServletRequest response, HttpSession session) {
		ModelAndView view = new ModelAndView("/dailyOffice/officeApply/financeIndex");
		return view;
	}

	/**
	 * @Description: 获取办公申请列表数据
	 * @author  army.liu 
	 * @param
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 
	 * 		itemName -项目名称,sign - 0 表示日常办公 ，1 表示财务管理,startTime-申请开始时间，endTime-申请结束时间
	 * }
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-主键
	 * 								itemName-项目名称
	 * 								status-状态
	 * 								insertTime-插入时间
	 * 								updateTime-最新更新时间
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
			if(params.get("sign").equals(0))
			{
				//只查看当前登录用户的数据(日常办公)
				params.put("insertUser", CommonUtil.getUserIdFromSession(request));
			}
			String stockId = CommonUtil.getStockIdFromSession(request);
			params.put("stockId", stockId);
			params.put("systemFlag", "N");//非系统流程
			Pager<Item> pager = taskService.getPageDataForItem(params);
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
	 * @Description: 查看办公申请详情页面
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
		ModelAndView view = new ModelAndView("/dailyOffice/officeApply/detail");
		
		return view;
	}
	
	/**
	 * @Description: 获取办公申请的详细信息
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
	public Map<String, Object> getDetailData(HttpServletRequest request, 
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
	 * @Description: 保存办公申请
	 * @author  army.liu 
	 * @param
 	 * {
	 * 					id-主键
	 * 					processId-流程主键
	 * 					itemName-项目名称
	 * 					startTime-开始时间
	 * 					endTime-结束时间
	 * 					applyUserId-申请人主键
	 * 					amount-金额
	 * 					cashAdvance-预付现金
	 * 					mark-备注
 	 * }
	 * @return
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/save", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Item bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			
			taskService.saveForItem(bean, operId);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * @Description: 提交办公申请
	 * @author  army.liu 
	 * @param
	 * {
	 * 					id-主键
	 * }
	 * @return
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/submit/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable int id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			
			taskService.submitForItem(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * @Description: 删除办公申请
	 * @author  army.liu 
	 * @param
	 * {
	 * 		id-主键
	 * }
	 * @return
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/delete/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable int id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			
			taskService.deleteForItem(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 导出
	 * @author  ww 
	 * @date 2016年10月21日 上午10:55:23
	 * @parameter  startTime -申请时间开始 ，endTime-申请时间结束，itemName-项目描述
	 * @return 
	 */
	@RequestMapping(value = "/export", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> export(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam("itemName") String itemName) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("startTime", startTime);
			params.put("endTime", endTime);
			params.put("itemName", itemName);
			String stockId = CommonUtil.getStockIdFromSession(request);
			params.put("stockId", stockId);
			Map<String, Object> formatData = taskService.getExportDataForItem(params);
			String fileName = "办公费用导出Excel";
			String fileExtend = "xls";
			POIUtil.exportToExcel(request, response, formatData, fileName, fileExtend);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "导出失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 打印
	 * @author  ww 
	 * @date 2016年10月21日 下午2:24:19
	 * @parameter  params [startTime -申请时间开始 ，endTime-申请时间结束，itemName-项目描述]
	 * @return list
	 */
	@RequestMapping(value = "/print",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> print(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);
			params.put("stockId", stockId);
			List<Item> list = taskService.getListForItem(params);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
}
