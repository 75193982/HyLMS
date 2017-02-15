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
import com.jshpsoft.domain.User;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 内部通讯录Controller
* @author  fengql 
* @date 2016年10月9日 下午3:00:32
 */
@Controller
@RequestMapping("/commonSetting/intAddBook")
public class IntAddBookController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private UserService userService;
	
	/**
	 * 内部通讯录页面
	* @author  fengql 
	* @date 2016年10月9日 下午3:01:06 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/intAddBook/index");		
		return mv;		
	}
	
	/**
	 * 获取部门的下拉数据-用作查询条件
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
	 * 获取通讯录列表数据 
	* @author  fengql 
	* @date 2016年9月14日 上午9:29:40 
	* @parameter  params [ searchInfo-查询条件、departmentId-部门id
	* 					    pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return      {
	 * 					records:[  id-id号、workNo-工号、name-姓名、departmentName-部门、title-职务、brithday-出生日期、sex-性别、
	 * 								telephone-电话号码、mobile-手机号码、shortMobile-集团短号、address-家庭地址
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
			int userId = CommonUtil.getUserIdFromSession(request);
			params.put("userId", userId);
			Pager<User> pager = userService.getPageDataForIntAddBook(params);
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
	
}
