package com.jshpsoft.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.RoleMapper;
import com.jshpsoft.dao.RoleMenusMapper;
import com.jshpsoft.dao.RoleUserGroupsMapper;
import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.RoleMenus;
import com.jshpsoft.domain.RoleUserGroups;
import com.jshpsoft.service.RoleService;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年9月27日 下午2:25:09
 */
@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Autowired RoleMapper roleMapper;
	
	@Autowired RoleMenusMapper roleMenusMapper;
	
	@Autowired RoleUserGroupsMapper roleUserGroupsMapper;
	
	@Override
	public Role getById(int id) throws Exception {
		return roleMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="插入角色信息,角色菜单信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insert(Role bean) throws Exception {
		if( null == bean ){
			throw new RuntimeException("角色信息为空");
		}
		roleMapper.insert(bean);//保存角色
		//保存角色菜单
		List<RoleMenus> list = bean.getMenusList();
		if(null != list && list.size() >0)
		{
			for(int i = 0;i<list.size();i++)
			{
				RoleMenus roleMenu = list.get(i);
				roleMenu.setRoleId(bean.getId());
				roleMenusMapper.insert(roleMenu);
			}
		}
		
		//保存用户组
		List<RoleUserGroups> ugs = bean.getUserGroupsList();
		if(null != ugs && ugs.size() >0)
		{
			for(int i = 0;i<ugs.size();i++)
			{
				RoleUserGroups roleMenu = ugs.get(i);
				roleMenu.setRoleId(bean.getId());
				roleUserGroupsMapper.insert(roleMenu);
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="修改角色信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int update(Role bean) throws Exception {
		roleMapper.update(bean);
		//先删除角色菜单，再保存
		roleMenusMapper.delete(bean.getId());
		List<RoleMenus> list = bean.getMenusList();
		if(null != list && list.size() >0)
		{
			for(int i = 0;i<list.size();i++)
			{
				RoleMenus roleMenu = list.get(i);
				roleMenu.setRoleId(bean.getId());
				roleMenusMapper.insert(roleMenu);
			}
		}
		
		//先删除用户组菜单，再保存
		roleUserGroupsMapper.deleteByRoleId(bean.getId());
		List<RoleUserGroups> ugs = bean.getUserGroupsList();
		if(null != ugs && ugs.size() >0)
		{
			for(int i = 0;i<ugs.size();i++)
			{
				RoleUserGroups roleMenu = ugs.get(i);
				roleMenu.setRoleId(bean.getId());
				roleUserGroupsMapper.insert(roleMenu);
			}
		}
		
		return 0;
	}

	@Override
	@SystemServiceLog(description="删除角色信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void delete(int id) throws Exception {
		roleMapper.delete(id);
		roleMenusMapper.delete(id);
		roleUserGroupsMapper.deleteByRoleId(id);
	}

	@Override
	public List<Role> getRoleList() throws Exception {
		return roleMapper.getRoleList();
	}

	@Override
	public Pager<Role> getPageData(Map<String, Object> params) throws Exception {
		String pageSize;
		try {
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		} catch (Exception e) {
			throw new RuntimeException("参数缺失或不正确");
		}
		List<Role> list = roleMapper.getPageList(params);
		int totalCount = roleMapper.getPageTotalCount(params);
		Pager<Role> pager = new Pager<Role>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

	@Override
	public String getRoleByUserId(Integer userId) throws Exception {
		String roleType="";
		List<Role> roleList = roleMapper.getRoleByUserId(userId);
		if(null != roleList && roleList.size()>0){
			for(int i=0;i<roleList.size();i++){
				Role role = roleList.get(i);
				if(role.getName().equals("仓管员")){
					roleType = "01";
					break;
				}else if(role.getName().equals("驾驶员")){
					roleType = "02";
					break;
				}else{
					roleType = "03";
				}
			}
		}
		return roleType;
	}

	@Override
	public List<RoleUserGroups> getRoleUserGroupsByRoleId(int id) throws Exception {
		return roleUserGroupsMapper.getByRoleId(id) ;
	}

	@Override
	public List<Role> getByConditions(Map<String, Object> params)
			throws Exception {
		return roleMapper.getByConditions(params);
	}

	

}
