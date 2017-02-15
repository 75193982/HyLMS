package com.jshpsoft.controller.dailyOffice;

import java.io.IOException;
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

import com.jshpsoft.domain.Message;
import com.jshpsoft.service.MessageService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 待阅消息管理Controller
 * @author  army.liu 
 * @date 2016年9月21日 上午10:07:01
 */
@Controller
@RequestMapping("/dailyOffice/message")
public class MessageController {
	
	@Autowired
	private MessageService messageService;
	
	/**
	 * 待阅消息管理页面
	 * @author  army.liu 
	 * @date 2016年9月21日 上午10:10:01
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("dailyOffice/message/index");		
		return mv;		
	}
	
	/**
	 * 已阅消息管理页面
	 * @author  army.liu 
	 * @date 2016年9月21日 上午10:10:01
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/hasReadIndex",method=RequestMethod.GET)		
	public ModelAndView hasReadIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("dailyOffice/message/hasReadIndex");		
		return mv;		
	}

	/**
	 * 获取待阅消息列表数据
	 * @author  army.liu 
	 * @date 2016年9月21日 上午10:13:01
	 * @parameter
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		status-读取标记：N-未读取，Y-已读取
	 * }
	 * 
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-id号
	 *								receiveUserId-接收人id
	 *								detailId-业务id
	 *								mark-消息内容
	 *								status-N-未读取，Y-已读取
	 *								insertTime-接收时间
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
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
			params.put("receiveUserId", CommonUtil.getUserIdFromSession(request));
			Pager<Message> pager = messageService.getPageData(params);
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
	 * 获取待阅消息详细信息
	 * @author  army.liu 
	 * @date 2016年9月21日 上午10:27:01
	 * @parameter  id-id号
	 * {
	 *   	id-id号
	 * }
	 * @return
 	 * {
 	 * 		id-id号、receiveUserId-接收人id、detailId-业务id、mark-消息内容、status-N-未读取，Y-已读取
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
			
			Message bean = messageService.getById(id);
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
	 * 更新待阅消息信息
	 * @author  army.liu 
	 * @date 2016年9月21日 上午10:35:01
	 * @parameter
	 * {
	 *   id-id号
	 * }
	 * @return
	 */
	@RequestMapping(value = "/updateRead/{id}",method=RequestMethod.GET)
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
			messageService.updateRead(id, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
}
