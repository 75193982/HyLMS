package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.UserGroup;
import com.jshpsoft.util.Pager;

/**
 * @author army.liu
 * @date 2016年9月27日 下午2:21:47
 */
public interface UserGroupService {
	
	public UserGroup getById(int id) throws Exception ;
	
	public void insert(UserGroup bean, String operId)  throws Exception;

	public int update(UserGroup bean, String operId) throws Exception;
	
	public void delete(int id, String operId) throws Exception ;
	
	public Pager<UserGroup> getPageData(Map<String, Object> params)  throws Exception;
	
	/**
	 * @Description: 获取所有的用户组列表
	 * @author army.liu 
	 * @param @return    设定文件
	 * @return List<UserGroup>    返回类型
	 * @throws
	 * @see
	 */
	public List<UserGroup> getAll() throws Exception;
}
