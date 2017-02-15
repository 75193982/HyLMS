package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Role;

/**
 * @author  ww 
 * @date 2016年9月27日 下午1:12:14
 */
public interface RoleMapper {
	
	public List<Role> getRoleList() throws Exception ;
	
	public Role getById(int id) throws Exception ;
	
	public void insert(Role bean)  throws Exception;

	public int update(Role bean) throws Exception;
	
	public void delete(int id) throws Exception ;
	
	public List<Role> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;

	public List<Role> getRoleByUserId(Integer userId) throws Exception ;

	public List<Role> getByConditions(Map<String, Object> params) throws Exception ;
	
}
