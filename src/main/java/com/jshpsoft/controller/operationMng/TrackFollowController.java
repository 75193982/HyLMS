package com.jshpsoft.controller.operationMng;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * 车辆跟踪Controller
* @author  fengql 
* @date 2016年11月26日 下午5:09:42
 */
@Controller
@RequestMapping("/operationMng/trackFollow")
public class TrackFollowController {
	
	/**
	 * 车辆跟踪页面
	* @author  fengql 
	* @date 2016年11月26日 下午5:10:10 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackFollow/index");		
		return mv;		
	}
	
	
}
