package com.jshpsoft.controller.commonSetting;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

/**
 * 个人资料Controller
* @author  fengql 
* @date 2016年10月9日 下午3:05:20
 */
@Controller
@RequestMapping("/commonSetting/personalData")
public class PersonalDataController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private UserService userService;

	/**
	 * 个人资料页面
	* @author  fengql 
	* @date 2016年10月9日 下午3:05:53 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/personalData/index");		
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
	 * 获取个人资料详细信息--前台判断哪些可进行编辑修改
	* @author  fengql 
	* @date 2016年9月14日 上午9:55:40 
	* @parameter  
	* @return	  bean [  id-id号、workNo-工号、name-姓名、departmentId-部门id、title-职务、brithday-出生日期、sex-性别、telephone-电话号码、mobile-手机号码、
	* 					  shortMobile-集团短号、address-家庭地址、id_card-身份证号、hiredate-入职时间、signmentTime-合同签订日期、salary-工资、
	* 					  driverFlag-是否是司机、discountLimit-折现上限、discountPoint-折扣点、certificate-从业资格证书、stockId-仓库id、
	* 					  parentId-上级id、roleId-角色id、password-密码(不显示，用于修改保存)
	* 					]
	 */
	@RequestMapping(value = "/getPersonalData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getPersonalData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Integer id = CommonUtil.getUserIdFromSession(request);//获取登录者的id 
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
	
}
