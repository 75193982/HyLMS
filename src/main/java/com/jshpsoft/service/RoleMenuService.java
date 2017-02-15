package com.jshpsoft.service;

import java.util.List;

import com.jshpsoft.domain.RoleMenus;

/**
 * @author  ww 
 * @date 2016年9月27日 下午2:22:06
 */
public interface RoleMenuService {

	/**
	 * 根据角色id获取角色菜单
	 * @author  ww 
	 * @date 2016年9月27日 下午3:18:29
	 * @parameter  
	 * @return
	 */
	public List<RoleMenus> getByRoleId(int roleId) throws Exception ;
	
	/**
	 * 保存角色菜单
	 * @author  ww 
	 * @date 2016年9月27日 下午3:19:18
	 * @parameter  
	 * @return
	 */
	public void insert(RoleMenus bean)  throws Exception;

	//public int update(RoleMenus bean) throws Exception;
	
	/**
	 * 根据角色id删除角色菜单
	 * @author  ww 
	 * @date 2016年9月27日 下午3:18:49
	 * @parameter  
	 * @return
	 */
	public void delete(int roleId) throws Exception ;
}
