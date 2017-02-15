package com.jshpsoft.dao;

import java.util.List;

import com.jshpsoft.domain.RoleUserGroups;

/**
 * @author  army.liu 
 * @date 2016年9月27日 下午1:12:38
 */
public interface RoleUserGroupsMapper {
	
	/**
	 * 根据角色id得到相关联的角色用户组表信息
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:15:28
	 * @parameter  
	 * @return
	 */
	public List<RoleUserGroups> getByRoleId(int id) throws Exception ;
	
	/**
	 * 插入角色用户组表信息
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:16:01
	 * @parameter  
	 * @return
	 */
	public void insert(RoleUserGroups bean)  throws Exception;

	/**
	 * 根据角色id 删除相关联的角色用户组信息
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:16:36
	 * @parameter  
	 * @return
	 */
	public void deleteByRoleId(int roleId) throws Exception ;

}
