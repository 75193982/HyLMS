package com.jshpsoft.mobile;

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

import com.jshpsoft.domain.Menu;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.RoleService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.util.CommonUtil;


/**
 * 登录controller
 * @Description: 提供登录，退出等功能
 * @author army.liu
 */
@Controller("mobileLoginController")
@RequestMapping("/mobile")
public class InterfaceController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private RoleService roleService;
	
//	/**
//	 * 测试接口-get
//	 */
//	@RequestMapping(value = "/getUserInfo/{id}", method=RequestMethod.GET)
//	@ResponseBody
//	public Map<String, Object> validateLogin(
//			HttpServletRequest request, 
//			HttpServletResponse response,
//			HttpSession session,
//			@PathVariable Integer id
//			) throws Exception {
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("code", "300");
//		result.put("msg", "检查失败");
//		
//		try{
//			//TODO
//			
//			result.put("code", "200");
//			result.put("msg", "成功");
//			
//		}catch(Exception e){
//			e.printStackTrace();
//			result.put("msg", "检查失败："+e.getMessage());		
//			
//		}		
//		return result;
//	}
//	
//	/**
//	 * 测试接口-get,多个参数
//	 */
//	@RequestMapping(value = "/register/{userName}/{password}", method=RequestMethod.GET)
//	@ResponseBody
//	public Map<String, Object> register(
//			HttpServletRequest request, 
//			HttpServletResponse response,
//			HttpSession session,
//			@PathVariable String userName,
//			@PathVariable String password
//			) throws Exception {
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("code", "300");
//		result.put("msg", "检查失败");
//		
//		try{
//			//TODO
//			System.out.println(userName+"-------------------------"+password);
//			result.put("code", "200");
//			result.put("msg", "成功");
//			
//		}catch(Exception e){
//			e.printStackTrace();
//			result.put("msg", "检查失败："+e.getMessage());		
//			
//		}		
//		return result;
//	}
//	
//	/**
//	 * 事物测试
//	 */
//	@RequestMapping(value = "/register", method=RequestMethod.POST, headers={"Content-Type=application/json"})
//	@ResponseBody
//	public Map<String, Object> register(
//			HttpServletRequest request, 
//			HttpServletResponse response,
//			HttpSession session,
//			@RequestBody User user
//			) throws Exception {
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("code", "300");
//		result.put("msg", "检查失败");
//		
//		try{
//			userService.registerUser(user);
//			result.put("code", "200");
//			result.put("msg", "成功");
//			
//		}catch(Exception e){
//			e.printStackTrace();
//			result.put("msg", "检查失败："+e.getMessage());		
//		}		
//		return result;
//	}
	
	/**
	 * 登录检查
	 * @parameter
	 * {
	 * 		mobile -手机号
	 * 		password -密码
	 * }
	 * 
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		token
	 * }  
	 */
	@RequestMapping(value = "/validateLogin", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> validateLogin(
			HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, String> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "检查失败");
		
		try{
			String mobile = params.get("mobile");
			String password = params.get("password");
			if( StringUtils.isEmpty(mobile) ){
				result.put("msg", "mobile不能为空");
				return result;
			}
			if( StringUtils.isEmpty(password) ){
				result.put("msg", "password不能为空");
				return result;
			}
			
			List<User> list = userService.validateLogin(mobile, password);
			if( null != list && list.size()>0){
				User user = list.get(0);
				//生成token
				String token = CommonUtil.createToken(user.getMobile());
				user.setToken(token);
				userService.updateToken(user);
				result.put("name", user.getName());
				result.put("mobile", user.getMobile());
				result.put("id", user.getId());
				result.put("departmentId", user.getDepartmentId());
				result.put("departmentName", user.getDepartmentName());
				
				//获取用户的角色类型
				String roleType = roleService.getRoleByUserId(user.getId());
				result.put("roleType", roleType);
				
				result.put("token", token);
				result.put("code", "200");
				result.put("msg", "成功");
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "检查失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * token校验
	 * @parameter
	 * {
	 * 		token-
	 * }
	 * 
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		equalFlag-Y-正常，N-失效
	 * }  
	 */
	@RequestMapping(value = "/validateToken", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> validateToken(
			HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, String> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "检查失败");
		
		try{
			String token = params.get("token");
			if( StringUtils.isEmpty(token) ){
				result.put("msg", "token不能为空");
				return result;
			}
			
			boolean equalFlag = userService.validateToken(token);
			if( equalFlag ){
				result.put("equalFlag", "Y");
			}else{
				result.put("equalFlag", "N");
			}
			result.put("code", "200");
			result.put("msg", "成功");
			
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "检查失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取个人资料
	 */
	@RequestMapping(value = "/getUserInfo/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> validateLogin(
			HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "检查失败");
		
		try{
			User user = userService.getById(id);
			user.setPassword(null);
			user.setToken(null);
			result.put("data", user);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "检查失败："+e.getMessage());		
			
		}		
		return result;
	}
	
	/**
	 * 获取用户的权限菜单
	 * @author  ww 
	 * @date 2016年11月11日 下午4:53:57 
	 * @parameter  userId-用户id
	 * @return	list [ id、name-菜单名称、url-菜单URL、orderId-排序值、parentId-上级菜单id、flag-标志：Y包含，N不包含 ] 
	 */
	@RequestMapping(value = "/getUserMenuList", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getUserMenuList(HttpServletRequest request,
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			int userId = CommonUtil.getUserIdFromSession(request);
			List<Menu> list = userService.getUserMenuListForApp(userId);
			
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
