package com.jshpsoft.controller.commonSetting;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.Department;
import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.Stock;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;
import com.jshpsoft.websocket.SystemWebSocketHandler;

/**
 * 用户设置Controller
* @author  fengql 
* @date 2016年9月13日 下午5:23:12
 */
@Controller
@RequestMapping("/commonSetting/userSetting")
public class UserSettingController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private UserService userService;
	
	@Bean
    public SystemWebSocketHandler systemWebSocketHandler() {
        return new SystemWebSocketHandler();
    }
	
	/**
	 * 用户设置页面
	* @author  fengql 
	* @date 2016年9月13日 下午5:24:13 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/userSetting/index");		
		//TODO
		//systemWebSocketHandler().sendMessageToUser("1", new TextMessage(9 + ""));
		return mv;		
	}

	/**
	 * 获取部门的下拉数据--以树形结构展示
	* @author  fengql 
	* @date 2016年9月14日 上午9:25:40 
	* @parameter  
	* @return  list[id、name-名称]
	 */
	@RequestMapping(value = "/getDepartmentList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getDepartmentList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<Department> list = commonService.getDepartmentList(params);
			
			result.put("data", list);			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}	 
		return result;
	}
	
	/**
	 * 获取上级id
	* @author  fengql 
	* @date 2016年9月14日 上午9:27:48 
	* @parameter  
	* @return   list [id-id号、name-姓名、departmentName-部门]
	 */
	@RequestMapping(value = "/getParent",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getParent(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<User> list = userService.getByConditions(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取仓库列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午11:16:12 
	* @parameter  
	* @return	List [ id-id号、name-名称 ]
	 */
	@RequestMapping(value = "/getStockList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getStockList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<Stock> list = commonService.getStockList(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取角色列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午11:16:12 
	* @parameter  
	* @return	List [ id-id号、name-名称 ]
	 */
	@RequestMapping(value = "/getRoleList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getRoleList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<Role> list = commonService.getRoleList();
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取用户列表数据 
	* @author  fengql 
	* @date 2016年9月14日 上午9:29:40 
	* @parameter  params [ searchInfo-查询条件、departmentId-部门id、driverFlag-是否是司机（N-普通员工，Y-司机）
	* 					    pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return      {
	 * 					records:[  id-id号、workNo-工号、name-姓名、departmentName-部门、title-职务、brithday-出生日期、sex-性别、telephone-电话号码、mobile-手机号码、
	* 					  			shortMobile-集团短号、address-家庭地址、idCard-身份证号、hiredate-入职时间、signmentTime-合同签订日期、salary-工资、driverFlag-是否是司机、
	* 					  			discountLimit-折现上限、discountPoint-折扣点、certificate-从业资格证书、stockName-仓库名称、parentName-上级姓名
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<User> pager = userService.getPageData(params);
			pager.setFrontParams(params.get("sEcho"));
			
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存用户信息   密码需要默认设置：123123
	* @author  fengql 
	* @date 2016年9月14日 上午9:50:40 
	* @parameter  bean [  workNo-工号、name-姓名、departmentId-部门id、title-职务、brithday-出生日期、sex-性别、telephone-电话号码、mobile-手机号码、
	* 					  shortMobile-集团短号、address-家庭地址、idCard-身份证号、hiredate-入职时间、signmentTime-合同签订日期、salary-工资、driverFlag-是否是司机、
	* 					  discountLimit-折现上限、discountPoint-折扣点、certificate-从业资格证书、stockId-仓库id、parentId-上级id、roleId-角色id
	*					]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody User bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			userService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取用户详细信息-用于修改
	* @author  fengql 
	* @date 2016年9月14日 上午9:55:40 
	* @parameter  id-id号
	* @return	  bean [  id-id号、workNo-工号、name-姓名、departmentId-部门id、title-职务、brithday-出生日期、sex-性别、telephone-电话号码、mobile-手机号码、
	* 					  shortMobile-集团短号、address-家庭地址、id_card-身份证号、hiredate-入职时间、signmentTime-合同签订日期、salary-工资、
	* 					  driverFlag-是否是司机、discountLimit-折现上限、discountPoint-折扣点、certificate-从业资格证书、stockId-仓库id、
	* 					  parentId-上级id、roleId-角色id、password-密码(不显示，用于修改保存)
	* 					]
	 */
	@RequestMapping(value = "/getDetailData/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetailData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			User bean = userService.getById(id);
			
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 修改用户信息  
	* @author  fengql 
	* @date 2016年9月14日 上午9:57:40 
	* @parameter  bean [  id-id号、workNo-工号、name-姓名、departmentId-部门id、title-职务、brithday-出生日期、sex-性别、telephone-电话号码、mobile-手机号码、
	* 					  shortMobile-集团短号、address-家庭地址、idCard-身份证号、hiredate-入职时间、signmentTime-合同签订日期、salary-工资、driverFlag-是否是司机、
	* 					  discountLimit-折现上限、discountPoint-折扣点、certificate-从业资格证书、stockId-仓库id、parentId-上级id、roleId-角色id、password-密码
	* 					]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody User bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			userService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除用户信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月14日 上午10:10:40  
	* @parameter  id-id号
	* @return
	 */
	@RequestMapping(value = "/delete/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "删除失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			userService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 根据部门编号，获取用户信息列表数据
	 * @author  army.liu 
	 * @date 2016年9月21日 下午2:02:43 
	 * @parameter  
	 * {
	 * 	departmentId-部门id
	 * }
	 * @return	list [id-id号、name-姓名]
	 */
	@RequestMapping(value = "/getUserListByDepartmentId/{departmentId}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getUserListByDepartmentId(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String departmentId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("departmentId", departmentId);
			List<User> list = userService.getByConditions(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 密码重置
	* @author  fengql 
	* @date 2016年10月19日 上午9:09:12 
	* @parameter  params[ id号(整型)、password-新密码(字符串) ]
	* @return
	 */
	@RequestMapping(value = "/passwordReset",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> passwordReset(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "密码重置失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			userService.passwordReset(params, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "密码重置失败："+e.getMessage());		
		}		
		return result;
	}
}
