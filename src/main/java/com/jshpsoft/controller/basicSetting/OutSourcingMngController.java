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

import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.service.OutSourcingService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 外协单位管理Controller
 * @author  fengql 
 * @date 2016年9月20日 下午1:25:23
 */
@Controller
@RequestMapping("/basicSetting/outSourcingMng")
public class OutSourcingMngController {
	
	@Autowired  
	private OutSourcingService outSourcingService;
	
	@Autowired  
	private CommonService commonService;
	
	/**
	 * 外协单位管理页面
	* @author  fengql 
	* @date 2016年9月20日 下午1:29:00 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/outSourcingMng/index");		
		return mv;		
	}
	
	/**
	 * 获取承运商列表信息
	* @author  ww 
	* @date 2016年9月20日 下午2:06:43 
	* @parameter  name-名称（模糊查询）
	* @return	List [ id-id号、name-名称 ]
	 */
	@RequestMapping(value = "/getOutSourcingList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSupplierList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String,Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<OutSourcing> list = commonService.getOutSourcingList(params);
			
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
	 * 获取外协单位列表数据
	* @author  fengql 
	* @date 2016年9月20日 下午1:32:45 
	* @parameter  params [ name-名称(String,模糊查询)、needInvoiceFlag-是否需要提供发票(N否,Y是)(String)、invoiceOrder-开票方式(0票前,1票后)(String)  没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[  id-id号、name-名称、address-地址、linkUser-联系人、brithday-联系人出生日期、linkTelephone-电话号码、linkMobile-手机号码、
	* 					  			startTime-开始时间、endTime-结束时间、needInvoiceFlag-是否需要提供发票、invoiceOrder-开票方式,transportOilCostRatio-油费占运费比例
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
			Pager<OutSourcing> pager = outSourcingService.getPageData(params);
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
	 * 保存外协单位信息
	* @author  fengql 
	* @date 2016年9月20日 下午1:43:57 
	* @parameter  bean [  name-名称(String)、address-地址(String)、linkUser-联系人(String)、brithday-联系人出生日期(date)、linkTelephone-电话号码(String)、linkMobile-手机号码(String)、
	* 					  startTime-开始时间(date)、endTime-结束时间(date)、needInvoiceFlag-是否需要提供发票(String)、invoiceOrder-开票方式(String)、transportOilCostRatio-油费占运费比例(double)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody OutSourcing bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			outSourcingService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取外协单位详细信息-用于修改
	* @author  fengql 
	* @date 2016年9月20日 下午1:45:13 
	* @parameter  id-id号(int) 必传
	* @return	  bean [  id-id号、name-名称、address-地址、linkUser-联系人、brithday-联系人出生日期、linkTelephone-电话号码、linkMobile-手机号码、
	* 					  startTime-开始时间、endTime-结束时间、needInvoiceFlag-是否需要提供发票、invoiceOrder-开票方式，transportOilCostRatio-油费占运费比例
	* 					]
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
			OutSourcing bean = outSourcingService.getById(id);
			
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
	 * 修改外协单位信息
	* @author  fengql 
	* @date 2016年9月20日 下午1:46:52 
	* @parameter  bean [  id-id号(int)、name-名称(String)、address-地址(String)、linkUser-联系人(String)、brithday-联系人出生日期(date)、linkTelephone-电话号码(String)、linkMobile-手机号码(String)、
	* 					  startTime-开始时间(date)、endTime-结束时间(date)、needInvoiceFlag-是否需要提供发票(String)、invoiceOrder-开票方式(String)、transportOilCostRatio-油费占运费比例(double)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody OutSourcing bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			outSourcingService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除外协单位信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月20日 下午1:47:58 
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
			outSourcingService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 获取外协单位列表数据
	 * @author  fengql 
	 * @date 2016年9月20日 下午3:25:30 
	 * @parameter  
	 * @return	List [ id-id号、name-名称 ]
	 */
	@RequestMapping(value = "/getAll",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getOutSourcingList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<OutSourcing> list = commonService.getOutSourcingList(params);
			
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
	 * 承运商查询系统页面
	 * @author  ww 
	 * @date 2016年12月19日 上午9:47:01
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/outSourcingMng/adminIndex");		
		return mv;		
	}
	
}
