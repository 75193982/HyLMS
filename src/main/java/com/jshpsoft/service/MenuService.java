package com.jshpsoft.service;

import java.util.List;

import com.jshpsoft.domain.Menu;

/**
 * @author  ww 
 * @date 2016年9月27日 下午1:35:57
 */
public interface MenuService {
	
	public List<Menu> getMenuList() throws Exception ;
	
	public Menu getById(int id) throws Exception ;
	
	public void insert(Menu bean)  throws Exception;

	public int update(Menu bean) throws Exception;
	
	public void delete(int id) throws Exception ;

	/**
	 * 获取用户的菜单列表
	* @author  fengql 
	* @date 2016年10月31日 上午10:02:29 
	* @parameter  
	* @return
	 */
	public List<Menu> getMenuListData(Integer userId) throws Exception;
}
