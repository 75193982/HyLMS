package com.jshpsoft.interceptor;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.json.JSONUtils;
import com.jshpsoft.service.SecurityService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;

/**
 * 验证权限拦截器
 * 
 */
public class AuthenticationInterceptor implements HandlerInterceptor {

	@Resource
	private SecurityService securityService;
	
	@Resource
	private UserService userService;

	// preHandle()方法在业务处理器处理请求之前被调用
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		String uri = request.getRequestURI();
		String ctx = Constants.CTX;
		uri = uri.substring( uri.indexOf(ctx) + ctx.length() );
		
		if( securityService.isPublicUri(uri) ) {
			return true;
		}
		
		String loginUrl = "";
		loginUrl = ctx + "/login";
		HttpSession session = request.getSession();
		//app端验证
		String token = request.getHeader(CommonUtil.TOKEN);
		if( StringUtils.isNotEmpty(token) ){
			//检查token是否正确
			boolean enable = userService.validateToken(token, request);
			if( enable ){
				return true;
			}else{
				response.setContentType("application/json;charset=UTF-8");
                PrintWriter writer = response.getWriter();
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("code", "301");
                map.put("msg", "Token失效");
                writer.write(JSONUtils.toJSONString(map));
                writer.flush();
                writer.close();
				return false;
			}
			
		}else if (session.getAttribute(CommonUtil.SESSION_USER_FLAG) != null) {//web端session验证
			if (!securityService.verifyUserUri(uri, session)) {
				response.sendRedirect(loginUrl);
				return false;
				
			}
		} else {
			response.sendRedirect(loginUrl);
			return false;
			
		}

		if (!securityService.verifyUserData(uri, request, session)) {
			response.sendRedirect(loginUrl);
			return false;
		}

		return true;
	}

	// postHandle()方法在业务处理器处理请求之后被调用
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	// afterCompletion()方法在DispatcherServlet完全处理完请求后被调用
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
//		System.out.println("++++++++++++++++++++++++++++++++++++++++++++++++");
//		String id = request.getSession().getId();
//		System.out.println(id);
//		boolean loginFlag = request.getSession().getAttribute("user") != null ? true : false;
//		if( loginFlag ){
//			DicEmployee currUser = (DicEmployee) request.getSession().getAttribute("user");
//			int userId = currUser.getId();
//			Object onlineUsersObj = request.getServletContext().getAttribute("onlineUsers");
//			Map<String, Object> onlineUsers = null;
//			if( null != onlineUsersObj ){
//				onlineUsers = (Map<String, Object>) onlineUsersObj;
//			}else{
//				onlineUsers = new HashMap<String, Object>();
//			}
//			if( !onlineUsers.containsKey(userId+"") ){
//				onlineUsers.put(userId+"", currUser);
//			}
//			request.getServletContext().setAttribute("onlineUsers", onlineUsers);
//		}
		//app端将session中用户移除
		String token = request.getHeader(CommonUtil.TOKEN);
		if( StringUtils.isNotEmpty(token) ){
			CommonUtil.removeUserFromSession(request);
			
		}
			
	}

}