package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.Menu;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.UserRoles;
import com.jshpsoft.util.Pager;

/**
 * 用户service
 * @author Administrator
 *
 */
public interface UserService {

	public void registerUser(User user) throws Exception;
	
	public List<User> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取用户信息-分页
	 * @author  fengql 
	 * @date 2016年9月26日 上午10:03:50 
	 * @parameter  
	 * @return
	 */
	public Pager<User> getPageData(Map<String, Object> params) throws Exception;
	
	public List<User> validateLogin(String mobile, String password) throws Exception;
	
	/**
	 * 保存用户数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(User bean, String oper) throws Exception;
	
	/**
	 * 根据id获取User
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public User getById(Integer id) throws Exception;
	
	/**
	 * 更新用户数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(User bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;

	/**
	 * 更新用户token
	 * @param user
	 */
	public void updateToken(User user) throws Exception;

	/**
	 * 用户token检查
	 * @param token
	 * @param request 
	 * @return
	 * @throws Exception
	 */
	public boolean validateToken(String token, HttpServletRequest request) throws Exception;

	/**
	 * 密码重置
	* @author  fengql 
	* @date 2016年10月19日 上午9:10:14 
	* @parameter  
	* @return
	 */
	public void passwordReset(Map<String, Object> params, String oper) throws Exception;

	/**
	 * 
	 * @Description: 用户token检查
	 * @author army.liu 
	 * @param @param token
	 * @param @return    设定文件
	 * @return boolean    返回类型
	 * @throws
	 * @see
	 */
	public boolean validateToken(String token) throws Exception;

	/**
	 * 获取用户菜单
	* @author  fengql 
	* @date 2016年11月11日 下午5:31:01 
	* @parameter  
	* @return
	 */
	public List<Menu> getUserMenuList(Integer userId) throws Exception;
	
	/**
	 * 得到手机端用户菜单
	 * @author  ww 
	 * @date 2016年11月21日 下午5:09:17
	 * @parameter  
	 * @return
	 */
	public List<Menu> getUserMenuListForApp(Integer userId) throws Exception;

	/**
	 * @Description: 获取通讯录的用户列表
	 * @author army.liu 
	 * @param @param params
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return Pager<User>    返回类型
	 * @throws
	 * @see
	 */
	public Pager<User> getPageDataForIntAddBook(Map<String, Object> params) throws Exception;

	/**
	 * @Description: 保存驾驶员信息
	 * @author army.liu 
	 * @param @param bean
	 * @param @param oper
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void saveForDriver(User bean, String oper, HttpServletRequest req) throws Exception;
	
	/**
	 * 获取角色人员信息
	 * @author  ww 
	 * @date 2016年12月28日 下午4:40:22
	 * @parameter  
	 * @return
	 */
	public List<UserRoles> getUserRolesList(Map<String, Object> params) throws Exception;
	
}
