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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CostApply;
import com.jshpsoft.domain.CostApplyReturn;
import com.jshpsoft.service.CostApplyReturnService;
import com.jshpsoft.service.CostApplyService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 核销申请管理
 * @author  ww 
 * @date 2016年12月8日 上午11:18:28
 */
@Controller
@RequestMapping("/operationMng/costApplyReturn")
public class CostApplyReturnController {
	
	@Autowired
	private CostApplyReturnService costApplyReturnService;
	
	@Autowired
	private CostApplyService costApplyService;
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年12月8日 下午1:17:47
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/operationMng/costApplyReturn/index");		
		return mv;		
	}
	
	/**
	 * 获取申请单号下拉
	 * @author  ww 
	 * @date 2016年12月8日 下午1:28:15
	 * @parameter  
	 * @return
	 * list{
	 * 		bean[  id、billNo、type-费用类型id、departmentId、applyUserId、applyTime、name-名称、amount、startTime、endTime、
	 * 			mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、typeName-费用类型名称、
	 * 			departmentName-申请部门名称、applyUserName-申请人名称
	 * 		]
	 * 	
	 * }
	 */
	@RequestMapping(value = "/getCostApplyListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCostApplyListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("status", Constants.CostApplyForOfficeStatus.FINISH);
			List<CostApply> list = costApplyService.getByConditions(params);
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
	 * 根据申请单号获取申请详细数据
	 * @author  ww 
	 * @date 2016年12月8日 下午1:36:24
	 * @parameter  costApplyBillNo-申请单号
	 * @return 
	 *   bean[  id、billNo、type-费用类型id、departmentId、applyUserId、applyTime、name-名称、amount、startTime、endTime、
	 * 			mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、typeName-费用类型名称、
	 * 			departmentName-申请部门名称、applyUserName-申请人名称
	 * ]
	 */
	@RequestMapping(value = "/getCostApplyDeatilData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCostApplyDeatilData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestParam("costApplyBillNo") String costApplyBillNo) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("billNo", costApplyBillNo);
			List<CostApply> list = costApplyService.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				result.put("data", list.get(0));
				result.put("code", "200");
				result.put("msg", "成功");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		
		return result;
		
	}
	
	/**
	 * 获取分页数据
	 * @author  ww 
	 * @date 2016年12月8日 下午1:18:11
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		costApplyBillNo-申请单号,startTime-申请时间开始,endTime-结束,departmentId-申请部门
	 * }  
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、costApplyBillNo-申请单号、departmentId、applyUserId、applyTime、prepayAmount、realUseAmount、returnAmount、
	 * 							mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、
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
			Pager<CostApplyReturn> pager = costApplyReturnService.getPageData(params);
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
	 * @date 2016年12月8日 下午1:22:49
	 * @parameter 
	 * bean
	 * [
	 * 		id、costApplyBillNo-申请单号、departmentId、applyUserId、applyTime、prepayAmount、realUseAmount、returnAmount、
	 * 			mark-备注、
	 * 			
	 * ] 
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody CostApplyReturn bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			costApplyReturnService.save(bean, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}

	/**
	 * 根据id获取
	 * @author  ww 
	 * @date 2016年12月8日 下午1:24:27
	 * @parameter  id
	 * @return
	 *    bean [
	 * 				id、costApplyBillNo-申请单号、departmentId、applyUserId、applyTime、prepayAmount、realUseAmount、returnAmount、
	 * 				mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、
	 * 				departmentName-申请部门名称、applyUserName-申请人名称
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
			CostApplyReturn bean = costApplyReturnService.getById(id);
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
	 * @date 2016年12月8日 下午1:25:34
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
			costApplyReturnService.delete(id, operId);
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
	 * @date 2016年12月8日 下午1:26:00
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
			costApplyReturnService.submit(id, operId);
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
	 * @date 2016年12月10日 上午11:23:07
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/operationMng/costApplyReturn/adminIndex");		
		return mv;		
	}
	
	/**
	 * 管理员权限查看
	 * @author  ww 
	 * @date 2016年12月10日 上午9:46:40
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		costApplyBillNo-申请单号,startTime-申请时间开始,endTime-结束,departmentId-申请部门
	 * }  
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、costApplyBillNo-申请单号、departmentId、applyUserId、applyTime、prepayAmount、realUseAmount、returnAmount、
	 * 							mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag、
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
			Pager<CostApplyReturn> pager = costApplyReturnService.getPageData(params);
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
