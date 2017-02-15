package com.jshpsoft.controller.commonSetting;

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

import com.jshpsoft.domain.SystemErrorLog;
import com.jshpsoft.service.SystemErrorLogService;
import com.jshpsoft.util.Pager;


/**
 * 系统异常日志
 * @author  ww 
 * @date 2016年10月11日 下午1:45:24
 */
@Controller
@RequestMapping("/commonSetting/systemErrorLog")
public class SystemErrorLogController {
	
	@Autowired
	private SystemErrorLogService systemErrorLogService;
	
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/systemErrorLog/index");		
		return mv;		
	}

	/**
	 * 获取数据
	 * @author  ww 
	 * @date 2016年10月11日 下午2:09:04
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<SystemErrorLog> pager =  systemErrorLogService.getPageData(params);
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
	 * 根据id查询
	 * @author  ww 
	 * @date 2016年10月24日 下午4:47:35
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getById/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getById(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			SystemErrorLog sys = systemErrorLogService.getById(id);
			result.put("data", sys);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		
		return result;
		
	}
}
