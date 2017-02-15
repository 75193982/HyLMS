package com.jshpsoft.service;

import java.util.List;

import com.jshpsoft.domain.RoleUserGroups;

/**
 * @author  army.liu 
 * @date 2016年9月27日 下午2:22:06
 */
public interface RoleUserGroupsService {

	/**
	 * 根据角色id获取角色用户组
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:18:29
	 * @parameter  
	 * @return
	 */
	public List<RoleUserGroups> getByRoleId(int roleId) throws Exception ;
	
	/**
	 * 保存角色用户组
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:19:18
	 * @parameter  
	 * @return
	 */
	public void insert(RoleUserGroups bean)  throws Exception;

	/**
	 * 根据角色id删除用户组菜单
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:18:49
	 * @parameter  
	 * @return
	 */
	public void delete(int roleId) throws Exception ;
}
