package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.User;

/**
 * 用户设置dao
* @author  fengql 
* @date 2016年9月26日 上午10:47:11
 */
public interface UserMapper {

	public User getById(Integer id) throws Exception ;

	public List<User> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(User bean)  throws Exception;

	public int update(User bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<User> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	
	/**
	 * 获取分页数据-通讯录
	 * @return
	 * @throws Exception
	 */
	public List<User> getPageListForIntAddBook(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小-通讯录
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCountForIntAddBook(Map<String, Object> params) throws Exception;
}
