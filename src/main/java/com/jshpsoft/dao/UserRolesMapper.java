package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.UserRoles;

/**
 * 用户角色关系dao
* @author  fengql 
* @date 2016年9月26日 下午2:40:25
 */
public interface UserRolesMapper {

	public List<UserRoles> getByUserId(Integer userId) throws Exception ;

	public void insert(UserRoles bean)  throws Exception;

	public int update(UserRoles bean) throws Exception;
	
	public void delete(Integer userId) throws Exception;
	
	public List<UserRoles> getByConditions(Map<String,Object> params) throws Exception;
	
}
