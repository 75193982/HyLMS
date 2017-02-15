package com.jshpsoft.controller.commonSetting;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.SystemOperateLog;
import com.jshpsoft.service.SystemOperateLogService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 系统操作日志Controller
* @author  fengql 
* @date 2016年9月14日 上午10:56:38
 */
@Controller
@RequestMapping("/commonSetting/systemOperateLog")
public class SystemOperateLogController {
	
	@Autowired
	private SystemOperateLogService systemOperateLogService;
	
	/**
	 * 系统日志查询页面
	* @author  fengql 
	* @date 2016年9月14日 上午10:57:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/systemOperateLog/index");		
		
		//当前日期
		mv.addObject("currDate", CommonUtil.getCustomDateToString(new Date(), "yyyy-MM-dd"));
		return mv;		
	}

	/**
	 * 获取日志列表数据
	* @author  fengql 
	* @date 2016年9月14日 上午10:57:49 
	* @parameter  operator-操作人、operate_content-操作内容、startTime-开始时间yyyy-MM-dd、endTime-结束时间yyyy-MM-dd
	* 
	* @return    list [ type-类型、operator-操作人、operate_time-操作时间、operate_name-操作名称、operate_content-操作内容、
	* 					login_ip-登录IP地址、mark-备注
	* 				  ]
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
			Pager<SystemOperateLog> pager =  systemOperateLogService.getPageData(params);
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
}
