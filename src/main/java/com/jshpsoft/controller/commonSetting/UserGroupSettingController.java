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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.UserGroup;
import com.jshpsoft.service.UserGroupService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 用户组设置Controller
 * @author  army.liu 
 * @date 2016年9月30日 
 */
@Controller
@RequestMapping("/commonSetting/userGroupSetting")
public class UserGroupSettingController {
	
	@Autowired 
	private UserGroupService userGroupService;//用户组
	
	/**
	 * 用户组设置页面
	 * @author  army.liu 
	 * @date 2016年9月30日 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/userGroupSetting/index");		
		return mv;		
	}

	/**
	 * 获取用户组列表数据
	 * @author  army.liu 
	 * @date 2016年9月30日 
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 
	 * 		name-用户组名称
	 * }
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、name-用户组名称、mark-备注、orderId-排序值、userIds-用户编号，多个,分割 、userNames-用户名称，多个,分割 
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception 
	{ 
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("delFlag", Constants.DelFlag.N);
			Pager<UserGroup> pager = userGroupService.getPageData(params);
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
	 * 根据id获取用户组信息
	 * @author  army.liu 
	 * @date 2016年10月9日 上午10:52:49
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getDetailData/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getRoleById(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@PathVariable("id") int id
			) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			UserGroup bean = userGroupService.getById(id);
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
	}
	
	/**
	 * 保存用户组信息   
	 * @author  army.liu 
	 * @date 2016年9月30日 
	 * @parameter   bean [ 
	 * 						name-用户组名称、mark-备注、orderId-排序值、userIds-用户编号，多个,分割
	 * 				]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody UserGroup bean
			) throws Exception 
	{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			userGroupService.insert(bean, CommonUtil.getUserIdFromSession(request)+"" );
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 修改用户组信息
	 * @author  army.liu
	 * @date 2016年9月30日 
	 * @parameter  bean [  id-id号、name-用户组名称、mark-备注、orderId-排序值、userIds-用户编号，多个,分割、userNames-用户名称，多个,分割
	 * 
	 * 					]
	 * @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody UserGroup bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			userGroupService.update(bean, CommonUtil.getUserIdFromSession(request)+"" );
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 删除用户组信息
	 * @author  army.liu
	 * @date 2016年9月30日  
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/delete/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@PathVariable("id") int id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "删除失败");
		
		try{
			userGroupService.delete(id, CommonUtil.getUserIdFromSession(request)+"" );
			result.put("code", "200");
			result.put("msg", "成功");
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取所有的用户组列表数据
	 * @author army.liu 
	 * @date 2016年9月30日 
	 * @parameter	id
	 * @return
	 */
	@RequestMapping(value = "/getAll",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getUserGroupListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable("roleId") int roleId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			List<UserGroup> list = userGroupService.getAll();
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}
		return result;
		
	}
}
