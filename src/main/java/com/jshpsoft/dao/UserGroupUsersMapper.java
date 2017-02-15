package com.jshpsoft.dao;

import java.util.List;

import com.jshpsoft.domain.UserGroupUsers;

/**
 * @author  army.liu 
 * @date 2016年9月27日 下午1:12:38
 */
public interface UserGroupUsersMapper {
	
	/**
	 * 根据用户组id得到相关联的用户组用户表信息
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:15:28
	 * @parameter  
	 * @return
	 */
	public List<UserGroupUsers> getByUserGroupId(int id) throws Exception ;
	
	/**
	 * 插入用户组用户表信息
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:16:01
	 * @parameter  
	 * @return
	 */
	public void insert(UserGroupUsers bean)  throws Exception;

	/**
	 * 根据用户组id 删除相关联的用户组用户信息
	 * @author  army.liu 
	 * @date 2016年9月27日 下午3:16:36
	 * @parameter  
	 * @return
	 */
	public void delete(int id) throws Exception ;

}
