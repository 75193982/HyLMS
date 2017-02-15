package com.jshpsoft.controller.basicSetting;

import java.io.IOException;
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

import com.jshpsoft.domain.ProcessDetail;
import com.jshpsoft.domain.ProcessInfo;
import com.jshpsoft.service.ProcessService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 业务流程管理Controller
 * @author  fengql 
 * @date 2016年9月21日 上午10:07:01
 */
@Controller
@RequestMapping("/basicSetting/processMng")
public class ProcessMngController {
	
	@Autowired
	private ProcessService processService;
	
	/**
	 * 业务流程管理页面
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:10:01
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/processMng/index");		
		return mv;		
	}

	/**
	 * 获取业务流程列表数据
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:13:01
	 * @parameter
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去
	 * 		processName-业务流程名称
	 *		status-业务流程名称
	 * }
	 * 
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-id号、stock_id-仓库id、itemTypeId-项目类型id、status-流程当前使用状态、insert_time-插入时间、insert_user-插入人
	 * 								stockName-仓库名称，
	 * 								insertUserName-插入人名称
	 * 								processName-流程名称
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去
	 * 				}
	 * }  
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST, headers={"Content-Type=application/json"})
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
			Pager<ProcessInfo> pager = processService.getPageData(params);
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
	 * 保存业务流程信息
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:17:01 
	 * @parameter
	 * {
	 * 	    id-主键
	 *		stockId-仓库id
	 *		itemTypeId-项目类型id
	 *		status-流程当前使用状态
	 * }
	 * @return
	 * 
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ProcessInfo bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			processService.save(bean, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 启用/停用业务流程信息
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:17:01 
	 * @parameter
	 * {
	 * 	    id-主键
	 * 		enabled-Y-启用，N-停用
	 * }
	 * @return
	 * 
	 */
	@RequestMapping(value = "/modifyStatus/{id}/{enabled}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> modifyStatus(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id,
			@PathVariable String enabled
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			processService.modifyStatus(id, enabled, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取业务流程信息-用于修改
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:27:01
	 * @parameter  id-id号
	 * {
	 *   	id-id号
	 * }
	 * @return
 	 * {
	 * 	    code 
	 * 		msg 
	 * 		data : {
	 * 	    			id-主键
	 * 	 				stockId-仓库id
	 *					itemTypeId-项目类型id
	 *					status-流程当前使用状态
	 * 			   }
	 * }
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
			ProcessInfo bean = processService.getById(id);
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
	 * 删除业务流程信息--更新逻辑删除键标志
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:35:01
	 * @parameter  id-id号
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
			int operId = CommonUtil.getUserIdFromSession(request);
			processService.delete(id, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取流程步骤详细信息
	 * @author  army.liu 
	 * @date 2016年9月21日 上午10:27:01
	 * @parameter
	 * {
	 *   	processId-业务流程id
	 * }
	 * @return
 	 * {
	 * 	    code 
	 * 		msg 
	 * 		data : [
	 * 					id-主键
	 * 	 				processId-业务流程id
	 *					orderNo-序号
	 *					name-步骤名称
	 *					type-操作类型：0-审核操作，1-确认操作
	 *					operateUserId-操作人id
	 *					operateUserName-操作人名称
	 *					needSuggestFlag-是否需要填写审核意见：Y-是，N-否
	 * 			   ]
	 * }
	 */
	@RequestMapping(value = "/getProcessDetailList/{processId}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getProcessDetailList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer processId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			
			List<ProcessDetail> list = processService.getProcessDetailList(processId);
			
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
	 * 保存流程步骤信息
	 * @author  army.liu 
	 * @date 2016年9月21日 下午2:04:44 
	 * @parameter
	 * {
	 * 		id-业务流程id
	 * 		detailList : [
	 *						name-步骤名称
	 *	 					type-操作类型
	 *						operateUserId-操作人id
	 *						needSuggestFlag-是否需要填写审核意见：Y-是，N-否
	 * 			   		 ]
	 * }
	 * @return
	 */
	@RequestMapping(value = "/saveProcessDetailList",method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> saveProcessDetail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ProcessInfo bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "设置失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			processService.saveProcessDetailList(bean, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "设置失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取办公申请的流程下拉数据
	 * @author  army.liu 
	 * @parameter
	 * {
	 * }
	 * @return
 	 * {
	 * 	    code 
	 * 		msg 
	 * 		data : [
	 * 					id-主键
	 * 	 				mark-流程名称
	 * 			   ]
	 * }
	 */
	@RequestMapping(value = "/getProcessListForOffice",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getProcessListForOffice(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);
			if( StringUtils.isEmpty(stockId) ){
				result.put("msg", "当前用户的仓库未设置，请联系管理员");
				return result;
			}
			List<ProcessInfo> list = processService.getProcessListForOffice( Integer.parseInt(stockId) );
			
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
