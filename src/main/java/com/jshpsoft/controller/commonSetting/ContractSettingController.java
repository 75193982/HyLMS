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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.Contract;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.ContractService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 合同设置Controller
* @author  fengql 
* @date 2016年9月14日 上午10:19:08
 */
@Controller
@RequestMapping("/commonSetting/contractSetting")
public class ContractSettingController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private UserService userService;
	
	@Autowired  
	private ContractService contractService;
	
	/**
	 * 合同设置页面
	* @author  fengql 
	* @date 2016年9月14日 上午10:21:23 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("commonSetting/contractSetting/index");		
		return mv;		
	}

	/**
	 * 根据类型获取main_id  
	* @author  fengql 
	* @date 2016年9月14日 上午10:24:38 
	* @parameter  type-0-员工合同，1-外协单位合同(String) 必传
	* @return     list [id、name-姓名/名称]
	 */
	@RequestMapping(value = "/getMainIdList/{type}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getMainIdList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String type
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			
			if(type.equals("0")){//员工
				List<User> list = userService.getByConditions(params);
				result.put("data", list);	
			}else{//外协单位
				List<OutSourcing> list = commonService.getOutSourcingList(params);
				result.put("data", list);
			}
						
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}	 
		return result;
	}
	
	/**
	 * 获取合同列表数据
	* @author  fengql 
	* @date 2016年9月14日 上午10:32:27 
	* @parameter params [  type-类型(0-员工合同，1-外协单位合同)(String,必传)、code-合同编码(String,模糊查询)、startTime-开始时间yyyy-MM-dd(String)、
	* 						endTime-结束时间yyyy-MM-dd(String)、status-状态(0-生效中，1-已到期)(String)  没有值传''
	* 					    pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return	  {
	 * 					records:[  id-id号、type-类型、code-合同编码、mainName-主体名称、startTime-开始时间、endTime-结束时间、status-状态、
	* 					  			mark-备注、noticeTime-到期提醒时间、filePath-扫描件上传地址
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
			Pager<Contract> pager = contractService.getPageData(params);
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
	 * 保存合同信息
	* @author  fengql 
	* @date 2016年9月14日 上午10:50:40 
	* @parameter  bean [  type-类型(String)、code-合同编码(String)、mainId-主体编号(int)、startTime-开始时间(date)、endTime-结束时间(date)、
	* 						mark-备注(String)、noticeTime-到期提醒时间(date)、filePath-扫描件上传地址(String)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Contract bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			contractService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取合同信息-用于修改
	* @author  fengql 
	* @date 2016年9月14日 上午10:55:40 
	* @parameter  id-id号(int) 必传
	* @return	  bean [  id-id号、type-类型、code-合同编码、mainId-主体编号、startTime-开始时间、endTime-结束时间、
	* 						mark-备注、noticeTime-到期提醒时间、filePath-扫描件上传地址、status-状态 ]
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
			Contract bean = contractService.getById(id);
			
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
	 * 修改合同信息
	* @author  fengql 
	* @date 2016年9月14日 上午10:57:40 
	* @parameter  bean [  id-id号(int)、type-类型(String)、code-合同编码(String)、mainId-主体编号(int)、startTime-开始时间(date)、endTime-结束时间(date)、
	* 						mark-备注(String)、noticeTime-到期提醒时间(date)、filePath-扫描件上传地址(String) 、status-状态(String)]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Contract bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			contractService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除合同信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月14日 上午11:10:40  
	* @parameter  id-id号(int) 必传
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
			String oper = CommonUtil.getOperId(request);//操作员
			contractService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 提交合同
	 * @author  army.liu 
	 * @date 2016年9月14日 上午11:10:40  
	 * @parameter  id-id号(int) 必传
	 * @return
	 */
	@RequestMapping(value = "/submit/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			contractService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 修改扫描件上传地址
	* @author  fengql 
	* @date 2016年10月19日 下午3:42:50 
	* @parameter  params[ id号(int)、filePath-地址(String) ]
	* @return
	 */
	@RequestMapping(value = "/updateFilePath",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> updateFilePath(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "更新失败");
		
		try{
			contractService.updateFilePath(params,request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "更新失败："+e.getMessage());		
		}		
		return result;
	}
}
