package com.jshpsoft.controller.operationMng;

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

import com.jshpsoft.domain.CarDamageFeedback;
import com.jshpsoft.service.CarDamageFeedbackMngService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 折损反馈管理Controller
 * @author  army.liu 
 */
@Controller
@RequestMapping("/operationMng/carDamageFeedbackMng")
public class CarDamageFeedbackMngController {
	
	@Autowired  
	private CarDamageFeedbackMngService carDamageFeedbackMngService;
	
	/**
	 * 折损反馈管理页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/carDamageFeedbackMng/index");		
		return mv;		
	}
	
	/**
	 * 获取收支列表数据
	 * @author  army.liu 
	 * @parameter  params 
	 * {
	 * 		carShopId-4S店id
	 * 
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * }
	 * @return
	 * {
	 * 		records [ id-id号、transportTime-装运时间、carType-车型、carShopId-4S店id、carShopName-4S店名称、linkMobile-联系方式、mark-备注、status-状态、insertUser-插入人、insertUserName-插入人名称、insertTime-插入时间 ]
	 * 		totalCounts -总记录数
	 * 		totalPages -总页数
	 * 		pageSize -页大小
	 * 		frontParams -前台带过来的参数，不动返回回去的
	 * }
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
			params.put("insertUser", CommonUtil.getUserIdFromSession(request));
			Pager<CarDamageFeedback> pager = carDamageFeedbackMngService.getPageData(params);
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
	 * 保存收支信息
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		 id-id号、transportTime-装运时间、carType-车型、carShopId-4S店id、linkMobile-联系方式、mark-备注
	 * }
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarDamageFeedback bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carDamageFeedbackMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取信息-用于修改
	 * @author  army.liu 
	 * @parameter  id-id号(int) 必传
	 * @return	  bean [ id-id号、transportTime-装运时间、carType-车型、carShopId-4S店id、carShopName-4S店名称、linkMobile-联系方式、mark-备注、status-状态、insertUser-插入人、insertUserName-插入人名称、insertTime-插入时间]
	 */
	@RequestMapping(value = "/getDetail/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			CarDamageFeedback bean = carDamageFeedbackMngService.getById(id);
			
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
	 * 修改收支信息
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		 id-id号、transportTime-装运时间、carType-车型、carShopId-4S店id、linkMobile-联系方式、mark-备注
	 * }
	 * @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarDamageFeedback bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carDamageFeedbackMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除信息--更新逻辑删除键标志
	 * @author  army.liu 
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
			carDamageFeedbackMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 提交信息
	 * @author  army.liu 
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
		result.put("msg", "删除失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carDamageFeedbackMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

}
