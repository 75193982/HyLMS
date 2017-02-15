package com.jshpsoft.serviceImpl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.jshpsoft.service.SecurityService;

/**
 * 安全服务实现
 * 
 */
@Service("securityService")
public class SecurityServiceImpl implements SecurityService {

	static {
		//web
		publicUris.add("/index"); // 登录主页面
		publicUris.add("/login"); // 登录
		publicUris.add("/validate"); // 校验
		publicUris.add("/upload/saveFile");//上传
		
		publicUris.add("/error"); // 错误页面
		publicUris.add("/404"); // 错误页面
		publicUris.add("/staticPublic"); // 公用图片 样式 脚本
		
		//app
		publicUris.add("/mobile/validateLogin"); //手机端
		
		
		
		
	}

	@Override
	public boolean isPublicUri(String uri) {
		if (uri.equals("/"))
			return true;
		for (String _uri : publicUris) {
			if (uri.startsWith(_uri)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public Map<String, Integer> getAllUri() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean verifyUserUri(String uri, HttpSession session) {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean verifyUserData(String uri, HttpServletRequest request, HttpSession session) {
		// TODO Auto-generated method stub
		return true;
	}

}
