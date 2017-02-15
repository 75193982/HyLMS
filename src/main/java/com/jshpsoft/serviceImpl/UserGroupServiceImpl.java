package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.UserGroupMapper;
import com.jshpsoft.dao.UserGroupUsersMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.UserGroup;
import com.jshpsoft.domain.UserGroupUsers;
import com.jshpsoft.service.UserGroupService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 用户组service
 * @author army.liu
 * @date 2016年9月27日 下午2:25:09
 */
@Service("userGroupService")
public class UserGroupServiceImpl implements UserGroupService {

	@Autowired UserGroupMapper userGroupMapper;
	
	@Autowired UserGroupUsersMapper userGroupUsersMapper;
	
	@Autowired UserMapper userMapper;
	
	@Override
	public UserGroup getById(int id) throws Exception {
		UserGroup bean = userGroupMapper.getById(id);
		if( null != bean ){
			List<UserGroupUsers> uguList = userGroupUsersMapper.getByUserGroupId(id);
			if( null != uguList && uguList.size()>0 ){
				String userNames = ""; 
				String userIds = ""; 
				for(int j=0; j<uguList.size(); j++){
					Integer userId = uguList.get(j).getUserId();
					User user = userMapper.getById( userId );
					if( null != user ){
						userNames += user.getName() + ";";
					}else{
						userNames += ";";
					}
					
					userIds += userId + ",";
					
				}
				bean.setUserNames(userNames);
				bean.setUserIds(userIds);
			}
			
		}
		
		return bean;
	}

	@Override
	@SystemServiceLog(description="插入用户组信息,用户组菜单信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void insert(UserGroup bean, String operId) throws Exception {
		if( null == bean ){
			throw new RuntimeException("用户组信息为空");
		}
		bean.setInsertTime(new Date());
		bean.setInsertUser(operId);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.N);
		userGroupMapper.insert(bean);//保存用户组
		
		String userIds = bean.getUserIds();
		if( StringUtils.isNotEmpty(userIds) ){
			String[] idArr = userIds.split(",");
			if( null != idArr && idArr.length > 0){
				for(int j=0; j<idArr.length; j++){
					if( StringUtils.isNotEmpty(idArr[j]) ){
						UserGroupUsers ugu = new UserGroupUsers();
						ugu.setUserGroupId( bean.getId() );
						ugu.setUserId( Integer.parseInt(idArr[j]) );
						userGroupUsersMapper.insert(ugu);
						
					}
					
				}
			}
			
		}

	}

	@Override
	@SystemServiceLog(description="修改用户组信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int update(UserGroup bean, String operId) throws Exception {
		UserGroup old = userGroupMapper.getById(bean.getId());
		if( null != old ){
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			userGroupMapper.update(bean);
			
			userGroupUsersMapper.delete(bean.getId());
			String userIds = bean.getUserIds();
			if( StringUtils.isNotEmpty(userIds) ){
				String[] idArr = userIds.split(",");
				if( null != idArr && idArr.length > 0){
					for(int j=0; j<idArr.length; j++){
						if( StringUtils.isNotEmpty(idArr[j]) ){
							UserGroupUsers ugu = new UserGroupUsers();
							ugu.setUserGroupId( bean.getId() );
							ugu.setUserId( Integer.parseInt(idArr[j]) );
							userGroupUsersMapper.insert(ugu);
							
						}
						
					}
				}
				
			}
			
		}
		return 0;
	}

	@Override
	@SystemServiceLog(description="删除用户组信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void delete(int id, String operId) throws Exception {
		UserGroup bean = userGroupMapper.getById(id);
		if( null != bean ){
			bean.setDelFlag(Constants.DelFlag.Y);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			userGroupMapper.update(bean);
		}
	}

	@Override
	public List<UserGroup> getAll() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("delFlag", Constants.DelFlag.N);
		return userGroupMapper.getByConditions(params);
	}

	@Override
	public Pager<UserGroup> getPageData(Map<String, Object> params) throws Exception {
		String pageSize;
		try {
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		} catch (Exception e) {
			throw new RuntimeException("参数缺失或不正确");
		}
		List<UserGroup> list = userGroupMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				List<UserGroupUsers> uguList = userGroupUsersMapper.getByUserGroupId(list.get(i).getId());
				if( null != uguList && uguList.size()>0 ){
					String userNames = ""; 
					for(int j=0; j<uguList.size(); j++){
						Integer userId = uguList.get(j).getUserId();
						User user = userMapper.getById( userId );
						if( null != user ){
							userNames += user.getName() + ";";
						}else{
							userNames += ";";
						}
						
					}
					list.get(i).setUserNames(userNames);
				}
				
				
			}
		}
		int totalCount = userGroupMapper.getPageTotalCount(params);
		Pager<UserGroup> pager = new Pager<UserGroup>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

}
