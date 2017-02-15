package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.UserGroup;

/**
 * @author army.liu 
 * @date 2016年9月27日 下午1:12:14
 */
public interface UserGroupMapper {
	
	public List<UserGroup> getByConditions(Map<String, Object> params) throws Exception ;
	
	public UserGroup getById(int id) throws Exception ;
	
	public void insert(UserGroup bean)  throws Exception;

	public int update(UserGroup bean) throws Exception;
	
	public void delete(int id) throws Exception ;
	
	public List<UserGroup> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;

	public List<UserGroup> getUserGroupByUserId(Integer userId) throws Exception ;
}
