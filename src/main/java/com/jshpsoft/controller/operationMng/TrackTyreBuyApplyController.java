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

import com.jshpsoft.domain.Department;
import com.jshpsoft.domain.TrackTyreBuyApply;
import com.jshpsoft.service.DepartmentService;
import com.jshpsoft.service.TrackTyreBuyApplyService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 轮胎采购申请管理
 * @author  ww 
 * @date 2016年12月10日 下午1:04:48
 */
@Controller
@RequestMapping("/operationMng/trackTyreBuyApply")
public class TrackTyreBuyApplyController {
	
	@Autowired
	private TrackTyreBuyApplyService trackTyreBuyApplyService;
	
	@Autowired
	private DepartmentService departmentService;
	
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年12月10日 下午1:36:10
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/operationMng/trackTyreBuyApply/index");		
		return mv;		
	}
	
	
	
	/**
	 * 得到部门下拉
	 * @author  ww 
	 * @date 2016年12月10日 下午1:36:32
	 * @parameter  
	 * @return
	 * list{
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
	 * 分页数据
	 * @author  ww 
	 * @date 2016年12月10日 下午1:37:35
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		billNo-采购单号,startTime-申请时间开始,endTime-结束,departmentId-申请部门
	 * }  
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、departmentId、applyUserId、type-类型、billNo-采购单号、brand-品牌、size-尺寸、sum-数量、price-价格、
	 * 							mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、departmentName-申请部门名称、applyUserName-申请人名称
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
			Pager<TrackTyreBuyApply> pager = trackTyreBuyApplyService.getPageData(params);
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
	 * @date 2016年12月10日 下午1:42:38
	 * @parameter  
	 * bean [ 
	 * 			id(修改传)、 departmentId-申请部门id、applyUserId-申请人id、type-类型、
	 * 			brand-品牌、size-尺寸、sum-数量、price-价格、mark-备注
	 * 		] 
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody TrackTyreBuyApply bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			trackTyreBuyApplyService.save(bean, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}

	/**
	 * 根据id获得bean
	 * @author  ww 
	 * @date 2016年12月10日 下午1:44:51
	 * @parameter  id
	 * @return
	 * bean[
	 * 			id、departmentId、applyUserId、type-类型、billNo-采购单号、brand-品牌、size-尺寸、sum-数量、price-价格、
	 * 			mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、departmentName-申请部门名称、applyUserName-申请人名称
	 * 		]
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
			TrackTyreBuyApply bean = trackTyreBuyApplyService.getById(id);
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
	 * @date 2016年12月10日 下午1:46:18
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
			trackTyreBuyApplyService.delete(id, operId);
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
	 * @date 2016年12月10日 下午1:46:52
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
			trackTyreBuyApplyService.submit(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 确认
	 * @author  ww 
	 * @date 2016年12月22日 上午9:53:06
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/sure/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> sure(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			trackTyreBuyApplyService.sure(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());	
		}
		return result;
		
	}
	
}
