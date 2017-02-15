package com.jshpsoft.controller.basicSetting;

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

import com.jshpsoft.domain.SalaryAllowanceType;
import com.jshpsoft.service.SalaryAllowanceTypeService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 津贴管理Controller
 * @author  army.liu 
 */
@Controller
@RequestMapping("/basicSetting/salaryAllowanceTypeMng")
public class SalaryAllowanceTypeMngController {
	
	@Autowired
	private SalaryAllowanceTypeService salaryAllowanceTypeService;
	
	/**
	 * 津贴管理页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/salaryAllowanceTypeMng/index");		
		return mv;		
	}

	/**
	 * 获取津贴列表数据
	 * @author  army.liu 
	 * @parameter
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 
	 * 		name -名称
	 * }
	 * 
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-id号、name-津贴名称、type-类型：0-补助，1-罚扣、insert_time-插入时间、insert_user-插入人 
	 * 								insertUserName-插入人名称
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }  
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST, headers={"Content-Type=application/json"})
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
			Pager<SalaryAllowanceType> pager = salaryAllowanceTypeService.getPageData(params);
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
	 * 保存津贴信息
	 * @author  army.liu 
	 * @parameter 
 	 * {
 	 * 		id-id号、name-津贴名称、type-类型：0-补助，1-罚扣
 	 * }
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody SalaryAllowanceType bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			salaryAllowanceTypeService.save(bean, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取津贴详细信息-用于修改
	 * @author  army.liu 
	 * @parameter
	 * {
	 *   	id-id号
	 * }
	 * @return
 	 * {
 	 * 		id-id号、name-津贴名称、type-类型：0-补助，1-罚扣
	 * }
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
			
			SalaryAllowanceType bean = salaryAllowanceTypeService.getById(id);
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
	 * 删除津贴信息
	 * @author  army.liu 
	 * @parameter
	 * {
	 *   id-id号
	 * }
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
			int operId = CommonUtil.getUserIdFromSession(request);
			salaryAllowanceTypeService.delete(id, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取所有的津贴下拉列表
	 * @author  army.liu 
	 * @parameter
	 * {
	 * 		name-模糊查询
	 * }
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : [
	 * 					id-id号、name-津贴名称、type-类型：0-补助，1-罚扣、insert_time-插入时间、insert_user-插入人 
	 * 			   ]
	 * }  
	 */
	@RequestMapping(value = "/getAllData",method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAllData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("delFlag", Constants.DelFlag.N);
			List<SalaryAllowanceType> data = salaryAllowanceTypeService.getByConditions(params);
			
			result.put("data", data);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
}
