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

import com.jshpsoft.domain.ItemType;
import com.jshpsoft.service.ItemTypeService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 项目类型管理Controller
 * @author  fengql 
 * @date 2016年9月21日 上午10:07:01
 */
@Controller
@RequestMapping("/basicSetting/itemTypeMng")
public class ItemTypeMngController {
	
	@Autowired
	private ItemTypeService itemTypeService;
	
	/**
	 * 项目类型管理页面
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:10:01
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/itemTypeMng/index");		
		return mv;		
	}

	/**
	 * 获取项目类型列表数据
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:13:01
	 * @parameter
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		name -项目名称
	 * 		type -项目类型
	 * }
	 * 
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-id号、name-项目类型名称、type-收支类型：0-支出，1-收入，2-无 （借款单，收款单，请假单）、insert_time-插入时间、insert_user-插入人 
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
			Pager<ItemType> pager = itemTypeService.getPageData(params);
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
	 * 保存项目类型信息
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:17:01 
	 * @parameter 
 	 * {
 	 * 		id-主键、type-项目类型、name-项目名称 
 	 * }
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ItemType bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			int operId = CommonUtil.getUserIdFromSession(request);
			itemTypeService.save(bean, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取项目类型详细信息-用于修改
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:27:01
	 * @parameter  id-id号
	 * {
	 *   	id-id号
	 * }
	 * @return
 	 * {
 	 * 		id-id号、name-项目名称、type-项目类型
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
			
			ItemType bean =itemTypeService.getById(id);
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
	 * 删除项目类型信息--更新逻辑删除键标志
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:35:01
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
			itemTypeService.delete(id, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取所有的项目类型下拉列表
	 * @author  fengql 
	 * @date 2016年9月21日 上午10:13:01
	 * @parameter
	 * {
	 * }
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : [
	 * 					id-id号、name-项目类型名称、type-收支类型：0-支出，1-收入，2-无 （借款单，收款单，请假单）、insert_time-插入时间、insert_user-插入人 
	 * 			   ]
	 * }  
	 */
	@RequestMapping(value = "/getAllData",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getAllData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			
			List<ItemType> data = itemTypeService.getAllData();
			
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
