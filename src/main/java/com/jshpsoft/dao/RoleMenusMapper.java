package com.jshpsoft.dao;

import java.util.List;

import com.jshpsoft.domain.RoleMenus;

/**
 * @author  ww 
 * @date 2016年9月27日 下午1:12:38
 */
public interface RoleMenusMapper {
	
	/**
	 * 根据角色id得到相关联的角色菜单表信息
	 * @author  ww 
	 * @date 2016年9月27日 下午3:15:28
	 * @parameter  
	 * @return
	 */
	public List<RoleMenus> getByRoleId(int id) throws Exception ;
	
	/**
	 * 插入角色菜单表信息
	 * @author  ww 
	 * @date 2016年9月27日 下午3:16:01
	 * @parameter  
	 * @return
	 */
	public void insert(RoleMenus bean)  throws Exception;

	//public int update(RoleMenus bean) throws Exception;
	
	/**
	 * 根据角色id 删除相关联的角色菜单信息
	 * @author  ww 
	 * @date 2016年9月27日 下午3:16:36
	 * @parameter  
	 * @return
	 */
	public void delete(int id) throws Exception ;

}
