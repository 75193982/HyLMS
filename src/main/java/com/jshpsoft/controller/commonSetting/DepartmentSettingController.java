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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.Department;
import com.jshpsoft.service.DepartmentService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;

/**
 * 部门设置
 * @author  ww 
 * @date 2016年9月27日 上午9:11:16
 */
@Controller
@RequestMapping("/commonSetting/departmentSetting")
public class DepartmentSettingController {
	
	//@Autowired  
	//private CommonService commonService;
	
	@Autowired  
	private DepartmentService departmentService;
	
	/**
	 * 部门设置页面
	 * @author  ww 
	 * @date 2016年9月27日 上午9:12:40
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/departmentSetting/index");		
		return mv;		
	}
	
	/**
	 * 得到部门信息
	 * @author  ww 
	 * @date 2016年9月27日 上午9:15:04
	 * @parameter  
	 * @return list
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getListData(HttpServletRequest request, 
	HttpServletResponse response,
	HttpSession session) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("code", "");
			params.put("name", "");
			params.put("delFlag", Constants.DelFlag.N);
			List<Department> list = departmentService.getByConditions(params);
			
			result.put("data", list);			
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}

	/**
	 * 根据id获取部门
	 * @author  ww 
	 * @date 2016年9月27日 上午9:49:19
	 * @parameter  id
	 * @return bean[code,name,parentId,orderId,mark,leaderId-部门负责人id,leaderName-部门负责人]
	 */
	@RequestMapping(value = "/getDetailData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDetailData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("id") int id) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Department department = departmentService.getById(id);
			result.put("data", department);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
				return result;
		
	}
	
	/**
	 * 保存部门信息
	 * @author  ww 
	 * @date 2016年9月27日 上午10:17:14
	 * @parameter  bean[code,name,parentId,orderId,mark,leaderId-部门负责人id]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Department department)throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));
			department.setInsertUser(userId);
			departmentService.insert(department);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 修改部门信息
	 * @author  ww 
	 * @date 2016年9月27日 上午10:58:01
	 * @parameter  bean[id,code,name,parentId,orderId,mark,leaderId-部门负责人id]
	 * @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Department department) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));
			department.setUpdateUser(userId);
			departmentService.update(department);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
		
	}
	
	/**
	 * 逻辑删除
	 * @author  ww 
	 * @date 2016年9月27日 上午11:15:44
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/delete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete (HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("id") int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));
			params.put("updateUser",userId);
			params.put("id", id);
			departmentService.delete(params);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}
	
}
