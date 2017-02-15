package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.RoleUserGroups;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年9月27日 下午2:21:47
 */
public interface RoleService {

	public List<Role> getRoleList() throws Exception ;
	
	public Role getById(int id) throws Exception ;
	
	public void insert(Role bean)  throws Exception;

	public int update(Role bean) throws Exception;
	
	public void delete(int id) throws Exception ;
	
	public Pager<Role> getPageData(Map<String, Object> params)  throws Exception;
	
	/**
	 * 根据用户id获取角色
	* @author  fengql 
	* @date 2016年11月3日 下午3:59:16 
	* @parameter  
	* @return
	 */
	public String getRoleByUserId(Integer userId) throws Exception;

	/**
	 * @Description: 根据角色id，获取信息
	 * @author army.liu 
	 * @param @param id
	 * @param @return    设定文件
	 * @return List<RoleUserGroups>    返回类型
	 * @throws
	 * @see
	 */
	public List<RoleUserGroups> getRoleUserGroupsByRoleId(int id) throws Exception;
	
	public List<Role> getByConditions(Map<String, Object> params) throws Exception;
}
