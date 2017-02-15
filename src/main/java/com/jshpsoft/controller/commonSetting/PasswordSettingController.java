package com.jshpsoft.controller.commonSetting;

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

import com.jshpsoft.domain.User;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;

/**
 * 密码修改
* @author  fengql 
* @date 2016年10月9日 下午2:47:14
 */
@Controller
@RequestMapping("/common/passwordSetting")
public class PasswordSettingController {
	
	@Autowired  
	private UserService userService;
	
	@Autowired  
	private CommonService commonService;
	
	/**
	 * 密码修改页面
	* @author  fengql 
	* @date 2016年10月9日 下午2:47:30 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/edit",method=RequestMethod.GET)		
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("common/passwordSetting/edit");
		return mv;		
	}
	
	/**
	 * 校验原密码是否正确
	* @author  fengql 
	* @date 2016年10月9日 下午2:47:53 
	* @parameter  password-原密码
	* @return
	 */
	@RequestMapping(value = "/validateOldPassword/{password}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> validateOldPassword(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String password
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("name", CommonUtil.getUserNameFromSession(request));
			params.put("id", CommonUtil.getUserIdFromSession(request));
			params.put("password", password);
			List<User> list = userService.getByConditions(params);
			if( null != list && list.size() > 0 ){
				result.put("code", "200");
				result.put("msg", "成功");			
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存
	* @author  fengql 
	* @date 2016年10月9日 下午2:52:49 
	* @parameter  params [ oldPassword-原密码、password-新密码 ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String password = String.valueOf(params.get("password"));
			params.put("name", CommonUtil.getUserNameFromSession(request));
			params.put("id", CommonUtil.getUserIdFromSession(request));
			params.put("password", String.valueOf(params.get("oldPassword")));
			List<User> list = userService.getByConditions(params);
			if( null != list && list.size() > 0 ){
				User bean = list.get(0);
				bean.setPassword(password);
				//userService.update(bean, CommonUtil.getUserNameFromSession(request));
				
				Map<String, Object> paramsNew = new HashMap<String, Object>();
				paramsNew.put("id", bean.getId());
				paramsNew.put("password", password);
				
				String oper = CommonUtil.getOperId(request);//操作员
				userService.passwordReset(paramsNew, oper);
				
				CommonUtil.addUserToSession(request, bean);
				
				result.put("code", "200");
				result.put("msg", "成功");
			}else{
				result.put("code", "300");
				result.put("msg", "原密码不正确");
			}
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());
		}		 
		return result;
	}
	
}
