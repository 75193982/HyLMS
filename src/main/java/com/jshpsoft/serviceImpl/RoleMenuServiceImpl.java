package com.jshpsoft.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.RoleMenusMapper;
import com.jshpsoft.domain.RoleMenus;
import com.jshpsoft.service.RoleMenuService;

/**
 * @author  ww 
 * @date 2016年9月27日 下午2:24:39
 */
@Service("roleMenuService")
public class RoleMenuServiceImpl implements RoleMenuService {

	@Autowired RoleMenusMapper roleMenuMapper;
	
	@Override
	public List<RoleMenus> getByRoleId(int roleId) throws Exception {
		return roleMenuMapper.getByRoleId(roleId);
	}

	@Override
	@SystemServiceLog(description="插入角色菜单信息")
	public void insert(RoleMenus bean) throws Exception {
		roleMenuMapper.insert(bean);

	}

	@Override
	@SystemServiceLog(description="删除角色菜单信息")
	public void delete(int roleId) throws Exception {
		roleMenuMapper.delete(roleId);
	}

}
