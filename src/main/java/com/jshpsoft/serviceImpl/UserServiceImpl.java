package com.jshpsoft.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.DepartmentMapper;
import com.jshpsoft.dao.MenuMapper;
import com.jshpsoft.dao.OutSourcingMapper;
import com.jshpsoft.dao.RoleMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.dao.UserRolesMapper;
import com.jshpsoft.domain.Department;
import com.jshpsoft.domain.Menu;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.UserRoles;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("userService")
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserMapper userMapper;

	@Autowired
	private UserRolesMapper userRoleMapper;
	
	@Autowired
	private MenuMapper menuMapper;
	
	@Autowired
	private DepartmentMapper deartmentMapper;
	
	@Autowired
	private RoleMapper roleMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private OutSourcingMapper outSourcingMapper;

	@Override
	@SystemServiceLog(description="插入用户信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void registerUser(User bean) throws Exception {
		bean.setInsertTime(new Date());
		bean.setDelFlag("N");
		userMapper.insert(bean);
		
		//int i = 1/ 0;
	}
	
	@Override
	@SystemServiceLog(description="查询用户信息")
	public List<User> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return userMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="用户登录校验")
	public List<User> validateLogin(String mobile, String password)
			throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mobile", mobile);
		params.put("password", password);
		params.put("delFlag", Constants.DelFlag.N);
		return userMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询用户列表信息")
	public Pager<User> getPageData(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		params.put("delFlag", Constants.DelFlag.N);
		List<User> list = userMapper.getPageList(params);
		if(null!=list && list.size()>0){
			for(int i=0;i<list.size();i++){
				list.get(i).setPassword(null);
				
			}
		}
		int totalCount = userMapper.getPageTotalCount(params);
		
		Pager<User> pager = new Pager<User>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增用户信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(User bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("用户信息为空");
		}
		
		//验证该手机号是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mobile", bean.getMobile());
		params.put("delFlag", Constants.DelFlag.N);
		List<User> users = userMapper.getByConditions(params);
		if(null !=users && users.size()>0){
			throw new RuntimeException("该用户(手机号)已存在，请检查");
		}
		
		//插入用户表
		bean.setPassword( commonService.getConfigValue(0,Constants.BasicConfigName.DEFAULT_PASSWORD) );//初始密码
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		userMapper.insert(bean);
		
		//插入用户角色关系表
		String RoleId = bean.getRoleId();
		String[] roleIds = RoleId.split(",");
		if(roleIds.length > 0)
		{
			for(int i = 0;i<roleIds.length;i++)
			{
				UserRoles userRoles = new UserRoles();
				userRoles.setUserId(bean.getId());
				userRoles.setRoleId(Integer.parseInt(roleIds[i]));
				userRoleMapper.insert(userRoles);
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="根据id获取用户明细")
	public User getById(Integer id) throws Exception {
		User user = userMapper.getById(id);
		List<UserRoles> userRoles = userRoleMapper.getByUserId(id);
		if( null != userRoles && userRoles.size() > 0)
		{
			String s = "";
			String name = "";
			for(int i = 0;i<userRoles.size();i++)
			{
				s += userRoles.get(i).getRoleId()+",";
				Role role =  roleMapper.getById(userRoles.get(i).getRoleId());
				if(null != role)
				{
					name += role.getName()+",";
				}
			}
			s = s.substring(0, s.length()-1);
			name = name.substring(0,name.length()-1);
			user.setRoleId(s);
			user.setRoleName(name);
		}
		
		//承运商名称
		int outSourcingId = user.getOutSourcingId();
		if( 0 != outSourcingId ){
			OutSourcing os = outSourcingMapper.getById(outSourcingId);
			if( null != os ){
				user.setOutSourcingName(os.getName());
				
			}
		}
		
		return user;
	}

	@Override
	@SystemServiceLog(description="更新用户信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(User bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("用户信息为空");
		}
		
		//验证该手机号是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mobile", bean.getMobile());
		params.put("delFlag", Constants.DelFlag.N);
		List<User> users = userMapper.getByConditions(params);
		if(null !=users && users.size()>0 && (int)users.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该用户(手机号)已存在，请检查");
		}
		
		//更新用户数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		userMapper.update(bean);
		
		//更新用户角色关系
		List<UserRoles> userRoles = userRoleMapper.getByUserId(bean.getId());
		if( null == userRoles)
		{
			String RoleId = bean.getRoleId();
			String[] roleIds = RoleId.split(",");
			if(roleIds.length > 0)
			{
				for(int i = 0;i<roleIds.length;i++)
				{
					UserRoles ur = new UserRoles();
					ur.setUserId(bean.getId());
					ur.setRoleId(Integer.parseInt(roleIds[i]));
					userRoleMapper.insert(ur);
				}
			}
		}else{
			userRoleMapper.delete(bean.getId());
			String RoleId = bean.getRoleId();
			String[] roleIds = RoleId.split(",");
			if(roleIds.length > 0)
			{
				for(int i = 0;i<roleIds.length;i++)
				{
					UserRoles ur = new UserRoles();
					ur.setUserId(bean.getId());
					ur.setRoleId(Integer.parseInt(roleIds[i]));
					userRoleMapper.insert(ur);
				}
			}
				
		}
		
	}

	@Override
	@SystemServiceLog(description="删除用户信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		userMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="更新用户token")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateToken(User user) throws Exception  {
		userMapper.update(user);
	}

	@Override
	@SystemServiceLog(description="检查用户token")
	public boolean validateToken(String token, HttpServletRequest req) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("token", token);
		params.put("delFlag", Constants.DelFlag.N);
		List<User> users = userMapper.getByConditions(params);
		if(null !=users && users.size()>0){
			User user = users.get(0);
			String createToken = CommonUtil.createToken(user.getMobile());
			if( createToken.equals(token) ){
				CommonUtil.addUserToSession(req, user);//添加app用户到session中
				return true;
			}
		}

		return false;
	}
	
	@Override
	@SystemServiceLog(description="检查用户token接口")
	public boolean validateToken(String token) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("token", token);
		params.put("delFlag", Constants.DelFlag.N);
		List<User> users = userMapper.getByConditions(params);
		if(null !=users && users.size()>0){
			User user = users.get(0);
			String createToken = CommonUtil.createToken(user.getMobile());
			if( createToken.equals(token) ){
				return true;
			}
		}
		
		return false;
	}

	@Override
	@SystemServiceLog(description="重置用户密码")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void passwordReset(Map<String, Object> params, String oper) throws Exception {
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		userMapper.updateById(params);
	}

	@Override
	public List<Menu> getUserMenuList(Integer userId) throws Exception {
		//获取角色为"手机端已开发功能"的菜单
		String roleName = Constants.roleName.MOBILE_DEVELOP;
		List<Menu> rMList = menuMapper.getRoleMenuList(roleName);
		
		if(null != rMList && rMList.size()>0 ){
			//获取当前用户的角色菜单
			List<Menu> list = menuMapper.getUserMenuList(userId);
			if(null != list && list.size()>0 ){
				for(int i=0;i<rMList.size();i++){
					Menu rMenu = rMList.get(i);
					rMenu.setFlag("N");
					
					for(int j=0;j<list.size();j++){
						Menu menu = list.get(j);
						if(rMenu.getId()==menu.getId()){
							rMenu.setFlag("Y");
							break;
						}
					}
					
				}
			}
			
		}
	
		return rMList;
	}

	@Override
	@SystemServiceLog(description="查询用户列表信息")
	public Pager<User> getPageDataForIntAddBook(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		params.put("delFlag", Constants.DelFlag.N);
		List<User> list = userMapper.getPageListForIntAddBook(params);
		if(null!=list && list.size()>0){
			for(int i=0;i<list.size();i++){
				list.get(i).setPassword("");
			}
		}
		int totalCount = userMapper.getPageTotalCountForIntAddBook(params);
		
		Pager<User> pager = new Pager<User>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	public void saveForDriver(User bean, String oper, HttpServletRequest req) throws Exception {
		Integer userId = bean.getId();
		
		User old = userMapper.getById(userId);
		//附件处理
		String idCardFilePath = bean.getIdCardFilePath();
		String certificateFilePath = bean.getCertificateFilePath();
		if( ( null == old && StringUtils.isNotEmpty(idCardFilePath) ) || (null != old && !idCardFilePath.equals( old.getIdCardFilePath() ) ) ){
			String newFilePath = commonService.reStoreFile( Constants.UploadType.IDCARD, idCardFilePath , req);
			bean.setIdCardFilePath( newFilePath );
		}
		if( ( null == old && StringUtils.isNotEmpty(certificateFilePath) ) || ( null != old && !certificateFilePath.equals( old.getCertificateFilePath() )  )){
			String newFilePath = commonService.reStoreFile( Constants.UploadType.CERTIFICATE, certificateFilePath , req);
			bean.setCertificateFilePath( newFilePath );
		}
		
		if( null != userId && 0 != userId ){
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			userMapper.update(bean);
			
		}else{//新增
			//部门：获取名为驾驶员的部门id
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("name", commonService.getConfigValue(0,Constants.BasicConfigName.DRIVER_DEPARTMENT_DEFAULT_NAME) );
			List<Department> departmentList = deartmentMapper.getByConditions(params);
			if( null != departmentList && departmentList.size() == 1 ){
				bean.setDepartmentId(departmentList.get(0).getId());
			}
			
			//角色：获取名为驾驶员的角色id
			params.put("name", commonService.getConfigValue(0,Constants.BasicConfigName.DRIVER_ROLE_DEFAULT_NAME) );
			List<Role> roleList = roleMapper.getByConditions(params);
			if( null != roleList && roleList.size() == 1 ){
				bean.setRoleId(String.valueOf(roleList.get(0).getId()));
			}
			
			bean.setInsertTime(new Date());
			bean.setInsertUser(oper);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setDriverFlag(Constants.DriverFlag.Y);
			userMapper.insert(bean);
			
		}
				
	}

	@Override
	public List<Menu> getUserMenuListForApp(Integer userId) throws Exception {
		//获取角色为"手机端已开发功能"的菜单
				String roleName = Constants.roleName.MOBILE_DEVELOP;
				List<Menu> rMList = menuMapper.getRoleMenuListForApp(roleName);
				List<Menu> ids = new ArrayList<Menu>();
				if(null != rMList && rMList.size()>0 ){
					//获取当前用户的角色菜单
					List<Menu> list = menuMapper.getUserMenuList(userId);
					if(null != list && list.size()>0 ){
						for(int i=0;i<rMList.size();i++){
							Menu rMenu = rMList.get(i);
							if(null == rMenu.getUrl() || "".equals(rMenu.getUrl().trim()))
							{
								for(int k=0;k<rMList.size();k++)
								{
									Menu m2  = rMList.get(k);
									if(null == m2.getUrl() || "".equals(m2.getUrl().trim()))
									{
										if(rMenu.getId().equals(m2.getParentId()))
										{
											ids.add(m2);
										}
									}
								}
							}
							rMenu.setFlag("N");
							
							for(int j=0;j<list.size();j++){
								Menu menu = list.get(j);
								if(rMenu.getId().equals(menu.getId())){
									rMenu.setFlag("Y");
									break;
								}
							}
							
						}
					}
					
					if(null != ids && ids.size() > 0)
					{
						for(int j = 0;j<ids.size();j++)
						{
							for(int i=0;i<rMList.size();i++)
							{
								if(ids.get(j).getId().equals(rMList.get(i).getParentId()))
								{
									rMList.get(i).setParentId(ids.get(j).getParentId());
								}
								rMList.remove(ids.get(j));
							}
						}
					}
					
				}
				
				/*for(int i = 0;i<rMList.size();i++)
				{
					System.out.println(rMList.get(i).getName()+rMList.get(i).getParentId());
				}*/
				return rMList;
	}

	@Override
	public List<UserRoles> getUserRolesList(Map<String, Object> params)
			throws Exception {
		
		return userRoleMapper.getByConditions(params);
	}
	
	
}
