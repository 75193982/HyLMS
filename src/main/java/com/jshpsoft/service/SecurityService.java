package com.jshpsoft.service;

import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 安全服务接口
 * 
 */
public interface SecurityService {

	/**
	 * 公共的uri不需要权限验证的
	 */
	public static final Set<String> publicUris = new HashSet<String>();

	/**
	 * 判断是否可以直接访问的uri地址<br>
	 * 将来应该使用cdn的方式，不能每次请求都进入java，这样效率太低
	 * 
	 * @param uri
	 * @return
	 */
	public boolean isPublicUri(String uri);

	/**
	 * 获取用户所能操作的所有uri
	 * 
	 * @return
	 */
	public Map<String, Integer> getAllUri();

	/**
	 * 验证用户动作权限
	 * 
	 * @param uri
	 * @param session
	 * @return
	 */
	public boolean verifyUserUri(String uri, HttpSession session);

	/**
	 * 验证用户数据权限
	 * 
	 * @param uri
	 * @param request
	 * @param session
	 * @return
	 */
	public boolean verifyUserData(String uri, HttpServletRequest request, HttpSession session);

}
