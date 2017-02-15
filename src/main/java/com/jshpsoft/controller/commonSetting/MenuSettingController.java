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

import com.jshpsoft.domain.Menu;
import com.jshpsoft.service.MenuService;

/**菜单设置
 * @author  ww 
 * @date 2016年9月27日 下午1:20:44
 */
@Controller
@RequestMapping("/commonSetting/menuSetting")
public class MenuSettingController {
	//@Autowired  
	//private CommonService commonService;
	
	@Autowired
	private MenuService menuService;
	
	/**
	 * 菜单页面
	 * @author  ww 
	 * @date 2016年9月27日 下午1:31:10
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/menuSetting/index");		
		return mv;		
	}

	/**
	 * 得到菜单数据
	 * @author  ww 
	 * @date 2016年9月27日 下午1:31:53
	 * @parameter  
	 * @return
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
			//Map<String, Object> params = new HashMap<String, Object>();
			//params.put("delFlag", Constants.DelFlag.N);
			List<Menu> list = menuService.getMenuList();
			
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
	 * 根据id获取菜单信息
	 * @author  ww 
	 * @date 2016年9月27日 下午1:33:42
	 * @parameter id
	 * @return
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
			Menu menu = menuService.getById(id);
			result.put("data", menu);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 保存 菜单信息
	 * @author  ww 
	 * @date 2016年9月27日 下午1:38:42
	 * @parameter bean[name,url,order_id,parent_id,mark]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Menu menu)throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			menuService.insert(menu);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 修改保存菜单信息
	 * @author  ww 
	 * @date 2016年9月27日 下午2:10:01
	 * @parameter  bean[id,name,url,order_id,parent_id,mark]
	 * @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Menu menu) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			menuService.update(menu);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 删除菜单信息
	 * @author  ww 
	 * @date 2016年9月27日 下午2:11:51
	 * @parameter  
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
			//Map<String, Object> params = new HashMap<String, Object>();
			//params.put("id", id);
			menuService.delete(id);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}
}
