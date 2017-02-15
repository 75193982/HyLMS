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

import com.jshpsoft.domain.Duty;
import com.jshpsoft.service.DutyService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 岗位管理Controller
 * @author  army.liu 
 */
@Controller
@RequestMapping("/basicSetting/dutyMng")
public class DutyMngController {
	
	@Autowired
	private DutyService dutyService;
	
	/**
	 * 岗位管理页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/dutyMng/index");		
		return mv;		
	}

	/**
	 * 获取岗位列表数据
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
	 * 								id-id号、name-岗位名称、salaryType-类型：0-月薪，1-年薪、salary-基本工资、insert_time-插入时间、insert_user-插入人 
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
			Pager<Duty> pager = dutyService.getPageData(params);
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
	 * 保存岗位信息
	 * @author  army.liu 
	 * @parameter 
 	 * {
 	 * 		id-主键、salaryType-类型、name-岗位名称 、salary-基本工资（double）
 	 * }
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Duty bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			dutyService.save(bean, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取岗位详细信息-用于修改
	 * @author  army.liu 
	 * @parameter
	 * {
	 *   	id-id号
	 * }
	 * @return
 	 * {
 	 * 		id-主键、salaryType-类型、name-岗位名称 、salary-基本工资（double）
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
			
			Duty bean = dutyService.getById(id);
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
	 * 删除岗位信息
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
			dutyService.delete(id, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取所有的岗位下拉列表
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
	 * 					id-id号、name-岗位名称、salaryType-类型：0-月薪，1-年薪、salary-基本工资、insert_time-插入时间、insert_user-插入人 
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
			List<Duty> data = dutyService.getByConditions(params);
			
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
