package com.jshpsoft.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.MenuMapper;
import com.jshpsoft.domain.Menu;
import com.jshpsoft.service.MenuService;

/**
 * @author  ww 
 * @date 2016年9月27日 下午1:36:56
 */
@Service("menuService")
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuMapper menuMapper;
	
	@Override
	public Menu getById(int id) throws Exception {
		return menuMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="插入菜单信息")
	public void insert(Menu bean) throws Exception {
		menuMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="修改菜单信息")
	public int update(Menu bean) throws Exception {
		menuMapper.update(bean);
		return 0;
	}

	@Override
	@SystemServiceLog(description="删除菜单信息")
	public void delete(int id) throws Exception {

		menuMapper.delete(id);
	}

	@Override
	public List<Menu> getMenuList() throws Exception {
		List<Menu> menuList = menuMapper.getMenuList();
		if( null != menuList && menuList.size() > 0 ){
			for(int i=0; i < menuList.size(); i++){
				Menu menu = menuList.get(i);
				Menu parent = menuMapper.getById(menu.getParentId());
				if( null != parent ){
					menuList.get(i).setParentName(parent.getName());
				}
			}
		}
		return menuList;
	}

	@Override
	@SystemServiceLog(description="获取用户的菜单列表")
	public List<Menu> getMenuListData(Integer userId) throws Exception {
		return menuMapper.getUserMenuList(userId);
	}

}
