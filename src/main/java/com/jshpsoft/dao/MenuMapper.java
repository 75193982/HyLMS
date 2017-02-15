package com.jshpsoft.dao;

import java.util.List;

import com.jshpsoft.domain.Menu;

/** 菜单
 * @author  ww 
 * @date 2016年9月27日 下午1:34:48
 */
public interface MenuMapper {
	
	public List<Menu> getMenuList() throws Exception ;
	
	public Menu getById(int id) throws Exception ;
	
	public void insert(Menu bean)  throws Exception;

	public int update(Menu bean) throws Exception;
	
	public void delete(int id) throws Exception ;

	public List<Menu> getUserMenuList(Integer userId) throws Exception ;
	
	public List<Menu> getRoleMenuList(String roleName) throws Exception ;
	
	public List<Menu> getRoleMenuListForApp(String roleName) throws Exception;
	
	public List<Menu> getByParentId(Integer parentId) throws Exception;
}
