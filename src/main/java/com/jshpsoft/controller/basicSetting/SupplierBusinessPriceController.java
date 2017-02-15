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

import com.jshpsoft.domain.SupplierBusinessPrice;
import com.jshpsoft.service.SupplierBusinessPriceService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/** 价格信息管理
 * @author  ww 
 * @date 2016年11月25日 上午9:52:01
 */
@Controller
@RequestMapping("/basicSetting/supplierBusinessPrice")
public class SupplierBusinessPriceController {
	
	@Autowired  
	private SupplierBusinessPriceService supplierBusinessPriceService;
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年11月25日 上午9:53:07
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/supplierBusinessPrice/index");		
		return mv;		
	}
	
	/**
	 * 得到价格信息列表
	 * @author  ww 
	 * @date 2016年11月25日 上午9:53:58
	 * @parameter  params [ supplierId-供应商id、businessId-品牌id 
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[  id-id号、supplierId-供应商id、businessId-品牌id、libName-库区、startAddress-始发地、
	 * 								endProvince-目的省、endAddress-目的地、
	* 					  			price-价格、distance-公里、carType-车型、insertTime-插入时间、insertUser、updateTime、updateUser、
	* 								delFlag、supplierName-供应商名称、brandName-品牌名称
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 *
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
			Pager<SupplierBusinessPrice> pager = supplierBusinessPriceService.getPageData(params);
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
	 * 根据id得到数据
	 * @author  ww 
	 * @date 2016年11月25日 上午10:34:30
	 * @parameter  [  id-id、supplierId-供应商id、businessId-品牌id、libName-库区、startAddress-始发地、
	 * 								endProvince-目的省、endAddress-目的地、
	* 					  			price-价格、distance-公里、carType-车型
	* 							]
	 * @return
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
			SupplierBusinessPrice bean = supplierBusinessPriceService.getById(id);
			
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
	 * 保存 （id为空）     修改（id不为空）
	 * @author  ww 
	 * @date 2016年11月25日 上午10:30:44
	 * @parameter  [  id-id、supplierId-供应商id、businessId-品牌id、libName-库区、startAddress-始发地、
	 * 								endProvince-目的省、endAddress-目的地、
	* 					  			price-价格、distance-公里、carType-车型
	* 							]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody SupplierBusinessPrice bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			supplierBusinessPriceService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除
	 * @author  ww 
	 * @date 2016年11月25日 上午10:33:22
	 * @parameter  id
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
			supplierBusinessPriceService.delete(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年11月25日 上午9:53:07
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/supplierBusinessPrice/adminIndex");		
		return mv;		
	}
	
}
