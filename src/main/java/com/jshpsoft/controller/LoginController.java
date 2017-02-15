package com.jshpsoft.controller;

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

import com.jshpsoft.annotation.SystemControllerLog;
import com.jshpsoft.domain.Menu;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.MenuService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.util.CommonUtil;


/**
 * 登录controller
 * @Description: 提供登录，退出等功能
 * @author army.liu
 */
@Controller("loginController")
public class LoginController {
	
	@Autowired  
	private UserService userService;
	
	@Autowired  
	private MenuService menuService;
	
	/**
	 * 登录页面
	 * @Description: 打开登录页面
	 * @author army.liu
	 * @param  
	 * @return
	 * @throws
	 */
	@SystemControllerLog(description="根据id查询用户-controller")
	@RequestMapping(value = "/",method=RequestMethod.GET)	
	public ModelAndView rootlogin(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("login");
	
		return mv;
		
	}
	
	/**
	 * 登录页面
	 * @Description: 打开登录页面
	 * @author army.liu
	 * @param  
	 * @return
	 * @throws
	 */
	@RequestMapping(value = "/login",method=RequestMethod.GET)		
	public ModelAndView rootlogin2(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("login");
		
		return mv;
		
	}
	
	/**
	  * 首页
	  * @Description: 首页
	  * @author army.liu
	  * @param  
	  * @return
	  * @throws
	  */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("index");

		return mv;
		
	}
	
	/**
	 * 首页中的右侧主页
	 * @Description: 主页
	 * @author army.liu
	 * @param  
	 * @return
	 * @throws
	 */
	@RequestMapping(value = "/content",method=RequestMethod.GET)		
	public ModelAndView content(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("content");
		
		return mv;
		
	}
	
	/**
	 * 登录校验
	* @author  fengql 
	* @date 2016年9月26日 上午9:56:54 
	* @parameter  params [ mobile-手机号(用户名)、password-密码 ]
	* @return
	 */
	@RequestMapping(value = "/validate",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> validate(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "用户名或密码错误");
		
		try{
			
			if( StringUtils.isEmpty(String.valueOf(params.get("mobile"))) ){
				result.put("msg", "用户名不能为空");
				return result;
			}
			
			if( StringUtils.isEmpty(String.valueOf( params.get("password"))) ){
				result.put("msg", "密码不能为空");
				return result;
			}
			
			//校验用户名密码
			List<User> users = userService.getByConditions(params);
			if( null != users && users.size() > 0 ){
				User user = users.get(0);
				CommonUtil.addUserToSession(request, user);
				result.put("code", "200");
				result.put("msg", "登录成功");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "登录失败："+e.getMessage());			
		}		 
		return result;
	}
	
	/**
	 * 退出登录
	* @author  fengql 
	* @date 2016年9月26日 上午9:56:06 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/logout",method=RequestMethod.GET)		
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("login");
		
		CommonUtil.removeUserFromSession( request );
		
		return mv;
		
	}
	
	/**
	  * 错误页面
	  * @Description: 错误页面
	  * @author army.liu
	  * @param  
	  * @return
	  * @throws
	  */
	@RequestMapping(value = "/error",method=RequestMethod.GET)		
	public ModelAndView error(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("error");

		return mv;
		
	}
	
	/**
	 * 404页面
	 * @Description: 404页面
	 * @author army.liu
	 * @param  
	 * @return
	 * @throws
	 */
	@RequestMapping(value = "/404",method=RequestMethod.GET)		
	public ModelAndView error404(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("404");
		
		return mv;
		
	}
	
	/**
	 * 获取当前用的菜单列表
	* @author  fengql 
	* @date 2016年10月31日 上午9:59:02 
	* @parameter  userId-用户id
	* @return	list [ id、name-菜单名称、url-菜单URL、orderId-排序值、parentId-上级菜单id] 
	 */
	@RequestMapping(value = "/getMenuListData/{userId}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getMenuListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer userId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<Menu> list = menuService.getMenuListData(userId);
			
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
