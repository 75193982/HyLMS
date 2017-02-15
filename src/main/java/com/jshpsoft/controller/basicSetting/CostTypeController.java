package com.jshpsoft.controller.basicSetting;

import java.io.IOException;
import java.util.HashMap;
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

import com.jshpsoft.domain.CostType;
import com.jshpsoft.service.CostTypeService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 费用类型管理
 * @author  ww 
 * @date 2016年12月7日 上午9:02:11
 */
@Controller
@RequestMapping("/basicSetting/costType")
public class CostTypeController {
	
	@Autowired
	private CostTypeService costTypeService;
	/**
	 * 页面 
	 * @author  ww 
	 * @date 2016年12月7日 上午9:04:49
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/basicSetting/costType/index");		
		return mv;		
	}
	
	/**
	 * 分页数据列表
	 * @author  ww 
	 * @date 2016年12月7日 上午9:16:04
	 * @parameter
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		type-类型  0-公司,1-车队 、name-名称
	 * }  
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、type-类型、name-名称、mark-备注、insertTime、insertUser、updateTime、updateUser、delFlag 
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
			Pager<CostType> pager = costTypeService.getPageData(params);
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
	 * @date 2016年12月7日 上午9:20:03
	 * @parameter  
	 * bean [ 
	 * 			id(修改传)、type-类型    0-公司,1-车队、name-名称、mark-备注
	 * 						
	 * 		]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody CostType bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			costTypeService.save(bean, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 根据id获取bean
	 * @author  ww 
	 * @date 2016年12月7日 上午9:21:42
	 * @parameter  id
	 * @return bean[id、type-类型、name-名称、mark-备注、insertTime、insertUser、updateTime、updateUser、delFlag ]
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
			CostType bean = costTypeService.getById(id);
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
	 * @date 2016年12月7日 上午9:24:09
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
			costTypeService.delete(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
}
