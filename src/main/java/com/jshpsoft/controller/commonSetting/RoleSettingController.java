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

import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.RoleMenus;
import com.jshpsoft.domain.RoleUserGroups;
import com.jshpsoft.domain.UserGroup;
import com.jshpsoft.service.RoleMenuService;
import com.jshpsoft.service.RoleService;
import com.jshpsoft.service.UserGroupService;
import com.jshpsoft.util.Pager;

/**
 * 角色设置Controller
* @author  ww 
* @date 2016年9月30日 
 */
@Controller
@RequestMapping("/commonSetting/roleSetting")
public class RoleSettingController {
	
	//@Autowired  
	//private CommonService commonService;
	
	@Autowired 
	private RoleService roleService;//角色
	
	@Autowired 
	private RoleMenuService roleMenuService;//角色菜单
	
	@Autowired 
	private UserGroupService userGroupService;
	
	/**
	 * 角色设置页面
	* @author  ww 
	* @date 2016年9月30日 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/roleSetting/index");		
		return mv;		
	}

	/**
	 * 获取父类id
	* @author  ww 
	* @date 2016年9月30日  
	* @parameter  
	* @return	list [id-id号、name-角色名称]
	 */
	@RequestMapping(value = "/getParent",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getParent(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<Role> list = roleService.getRoleList();
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
	 * 获取角色列表数据
	* @author  ww 
	* @date 2016年9月30日 
	* @parameter  
	* {
	* 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		name-角色名称、mark-备注、orderId-排序值、parentId-上级角色
	* }
	* @return
	* {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、name-角色名称、mark-备注、orderId-排序值、parentId-上级角色 
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
		
		try{
			Pager<Role> pager = roleService.getPageData(params);
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
	 * 根据id获取角色信息
	 * @author  ww 
	 * @date 2016年10月9日 上午10:52:49
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getRoleById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getRoleById(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestParam("id") int id
			) throws Exception
			{
				Map<String, Object> result = new HashMap<String, Object>();
				result.put("code", "300");
				result.put("msg", "获取失败");
				
				try {
					Role role = roleService.getById(id);
					List<RoleUserGroups> list = roleService.getRoleUserGroupsByRoleId(id);
					if(null != list && list.size() > 0)
					{
						for(int i = 0;i<list.size();i++)
						{
							if(null != list.get(i).getUserGroupId())
							{
								UserGroup ug = userGroupService.getById(list.get(i).getUserGroupId());
								list.get(i).setUserGroupName(ug.getName());
							}
						}
					}
					role.setUserGroupsList(list);
					result.put("data", role);
					result.put("code", "200");
					result.put("msg", "成功");
				} catch (Exception e) {
					e.printStackTrace();
					result.put("msg", "获取失败："+e.getMessage());	
				}
				return result;
			}
	
	/**
	 * 根据角色id得到角色选择菜单列表数据
	 * @author  ww 
	 * @date 2016年9月30日 
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/getRoleMenuListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getRoleMenuListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestParam("id") int id
			) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			List<RoleMenus> list = roleMenuService.getByRoleId(id);
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
	 * 根据角色id得到角色群组列表
	 * @author  ww 
	 * @date 2016年11月17日 下午1:41:35
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getRoleUserGroupsListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getRoleUserGroupsListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestParam("id") int id
			) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			List<RoleUserGroups> list = roleService.getRoleUserGroupsByRoleId(id);
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
	 * 获取角色详细信息-用于修改
	* @author  ww 
	* @date 2016年9月30日 
	* @parameter  id-id号
	* @return	  bean [  id-id号、name-角色名称、mark-备注、orderId-排序值、parentId-父类id ]
	 */
	/*@RequestMapping(value = "/getDetailData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDetailData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("id") int id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Role role = roleService.getById(id);
			result.put("data", role);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}*/
	
	/**
	 * 保存角色菜单信息
	 * @author  ww 
	 * @date 2016年9月27日 下午3:42:10
	 * @parameter  bean[roleId,menuId]
	 * @return
	 */
	/*@RequestMapping(value = "/saveRoleMenu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveRoleMenu(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody RoleMenus bean
			) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			roleMenuService.insert(bean);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}*/
	
	/**
	 * 保存角色信息   
	* @author  ww 
	* @date 2016年9月30日 
	* @parameter   bean [ 
	* 						name-角色名称、mark-备注、orderId-排序值、parentId-父类id、
	* 						menusList{
	* 									[roleId、menuId]
	* 								 }-角色菜单
	* 						userGroupsList{
	* 									[roleId、userGroupId]
	* 								 }-角色菜单
	* 				]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Role role
			) throws Exception 
	{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			roleService.insert(role);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 修改角色菜单表(先删除表中role_id的数据，然后再插入数据)
	 * @author  ww 
	 * @date 2016年9月27日 下午3:47:03
	 * @parameter  bean[roleId,menuId]
	 * @return
	 */
	/*@RequestMapping(value = "/updateRoleMenu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateRoleMenu(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody RoleMenus bean
			) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try {
			roleMenuService.delete(bean.getRoleId());
			roleMenuService.insert(bean);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());	
		}
		return result;
	}*/
	
	/**
	 * 修改角色信息
	* @author  ww
	* @date 2016年9月30日 
	* @parameter  bean [  id-id号、name-角色名称、mark-备注、orderId-排序值、parentId-父类id 
	* 						menusList{
	* 									[roleId、menuId]
	* 								 }-角色菜单
	* 
	* 						userGroupsList{
	* 									[roleId、userGroupId]
	* 								 }-角色菜单
	* 
	* 					]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Role role
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			roleService.update(role);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}

	
	/**
	 * 根据角色id删除角色菜单
	 * @author  ww 
	 * @date 2016年9月27日 下午3:52:59
	 * @parameter  id
	 * @return
	 */
	/*@RequestMapping(value = "/deleteRoleMenu",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteRoleMenu(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("id") int id
			) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "删除失败");
		
		try {
			roleMenuService.delete(id);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());
		}
		return result;
		
	}*/
	
	/**
	 * 删除角色信息
	* @author  ww
	* @date 2016年9月30日  
	* @parameter  id
	* @return
	 */
	@RequestMapping(value = "/delete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("id") int id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "删除失败");
		
		try{
			roleService.delete(id);
			result.put("code", "200");
			result.put("msg", "成功");
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
}
