package com.jshpsoft.controller.operationMng;

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

import com.jshpsoft.domain.CostApply;
import com.jshpsoft.domain.CostType;
import com.jshpsoft.domain.Department;
import com.jshpsoft.service.CostApplyService;
import com.jshpsoft.service.CostTypeService;
import com.jshpsoft.service.DepartmentService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;


/**
 * 费用申请管理
 * @author  ww 
 * @date 2016年12月7日 上午11:04:02
 */
@Controller
@RequestMapping("/operationMng/costApply")
public class CostApplyController {
	
	@Autowired
	private CostApplyService costApplyService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private CostTypeService costTypeService;
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年12月7日 上午11:05:56
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/operationMng/costApply/index");		
		return mv;		
	}
	
	/**
	 * 得到部门下拉
	 * @author  ww 
	 * @date 2016年12月7日 下午12:37:48
	 * @parameter  
	 * @return list{
	 * 	id、code、name、parentId、orderId、mark、
	 * }
	 */
	@RequestMapping(value = "/getDeptList", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDeptList(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			params.put("parentFlag", "Y");
			List<Department> list = departmentService.getByConditions(params);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 得到费用类型下拉
	 * @author  ww 
	 * @date 2016年12月7日 下午12:46:37
	 * @parameter  
	 * @return list
	 * {
	 * 		id、type、name、mark、
	 * }
	 */
	@RequestMapping(value = "/getCostTypeList", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCostTypeList(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Map<String,Object> params = new HashMap<String, Object>();
			List<CostType> list = costTypeService.getByConditions(params);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 获取分页数据列表
	 * @author  ww 
	 * @date 2016年12月7日 上午11:06:31
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		type-类型id 、name-名称,startTime-申请时间开始,endTime-结束,departmentId-申请部门
	 * }  
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、type-费用类型id、departmentId、applyUserId、applyTime、name-名称、amount、startTime、endTime、
	 * 							mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、typeName-费用类型名称、
	 * 							departmentName-申请部门名称、applyUserName-申请人名称
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
		
		try {
			params.put("insertUser", CommonUtil.getOperId(request));
			Pager<CostApply> pager = costApplyService.getPageData(params);
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		
		return result;
		
	}
	
	
	/**
	 * 保存、更新
	 * @author  ww 
	 * @date 2016年12月7日 上午11:20:12
	 * @parameter 
	 * bean [ 
	 * 			id(修改传)、type-费用类型id、 departmentId-申请部门id、applyUserId-申请人id、
	 * 			applyTime-申请时间、name-名称、amount、startTime、endTime、mark-备注
	 * 		] 
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody CostApply bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			costApplyService.save(bean, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 根据id查询详情
	 * @author  ww 
	 * @date 2016年12月7日 上午11:24:50
	 * @parameter  id
	 * @return
	 * bean:[
	 * 								id、type-费用类型id、departmentId、applyUserId、applyTime、name-名称、amount、startTime、endTime、
	 * 							mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、typeName-费用类型名称、
	 * 							departmentName-申请部门名称、applyUserName-申请人名称
	 * 							]
	 */
	@RequestMapping(value = "/getById/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getById(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			CostApply bean = costApplyService.getById(id);
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
	 * 删除
	 * @author  ww 
	 * @date 2016年12月7日 上午11:25:46
	 * @parameter  id
	 * @return 
	 */
	@RequestMapping(value = "/delete/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			costApplyService.delete(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 提交
	 * @author  ww 
	 * @date 2016年12月7日 下午1:30:57
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/submit/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			costApplyService.submit(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年12月10日 上午11:22:29
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/operationMng/costApply/adminIndex");		
		return mv;		
	}
	
	/**
	 * 管理员查看接口
	 * @author  ww 
	 * @date 2016年12月10日 上午9:44:59
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		type-类型id 、name-名称,startTime-申请时间开始,endTime-结束,departmentId-申请部门
	 * }  
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、type-费用类型id、departmentId、applyUserId、applyTime、name-名称、amount、startTime、endTime、
	 * 							mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、typeName-费用类型名称、
	 * 							departmentName-申请部门名称、applyUserName-申请人名称
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * } 
	 */
	@RequestMapping(value = "/getAdminListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getAdminListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Pager<CostApply> pager = costApplyService.getPageData(params);
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		
		return result;
		
	}
	
}
