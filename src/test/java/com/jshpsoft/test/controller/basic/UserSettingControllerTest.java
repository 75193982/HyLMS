package com.jshpsoft.test.controller.basic;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.jshpsoft.service.UserService;

public class UserSettingControllerTest {

	/**
	 * 密码重置
	* @author  fengql 
	* @date 2016年10月19日 下午2:42:12 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testsubmit() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserService userService = (UserService) context.getBean("userService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 17);
		params.put("password", "222222");
		userService.passwordReset(params, "1");
		
	}
	
	
	
}
