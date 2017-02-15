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
import com.jshpsoft.domain.OutSourcingBusiness;
import com.jshpsoft.domain.OutSourcingBusinessPrice;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.SupplierBusiness;
import com.jshpsoft.service.OutSourcingBusinessPriceService;
import com.jshpsoft.service.OutSourcingBusinessService;
import com.jshpsoft.service.OutSourcingService;
import com.jshpsoft.service.SupplierBusinessService;
import com.jshpsoft.service.SupplierService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 承运商（外协单位）价格信息管理
 * @author  ww 
 * @date 2016年11月26日 下午4:37:55
 */
@Controller
@RequestMapping("/basicSetting/outSourcingBusinessPrice")
public class OutSourcingBusinessPriceController {
	
	@Autowired  
	private OutSourcingBusinessPriceService outSourcingBusinessPriceService;
	
	@Autowired  
	private OutSourcingService outSourcingService;
	
	@Autowired  
	private OutSourcingBusinessService outSourcingBusinessService;
	
	@Autowired  
	private SupplierBusinessService supplierBusinessService;
	
	@Autowired  
	private SupplierService supplierService;
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年12月5日 上午9:21:12
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/outSourcingBusinessPrice/index");		
		return mv;		
	}

	/**
	 * 获取下拉承运商数据
	 * @author  ww 
	 * @date 2016年12月5日 上午9:31:34
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getOutSourcingList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
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
			List<OutSourcing> list = outSourcingService.getByConditions(params);
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
	 * 根据承运商获取库区下拉（查询时）
	 * @author  ww 
	 * @date 2017年1月5日 上午9:59:21
	 * @parameter  {outSourcingId --承运商id}
	 * @return [libName-库区]
	 */
	@RequestMapping(value = "/getLibsForOutSourcing",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getLibsForOutSourcing(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{

			List<OutSourcingBusinessPrice> list = outSourcingBusinessPriceService.getLib(params);
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
	 * 根据承运商获取所有的品牌下拉（查询时）
	 * @author  ww 
	 * @date 2017年1月18日 下午2:44:26
	 * @parameter   {outSourcingId --承运商id}
	 * @return [brandName-品牌]
	 */
	@RequestMapping(value = "/getBrandNameForQueryOutSourcing",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getBrandNameForQueryOutSourcing(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{

			List<OutSourcingBusiness> list = outSourcingBusinessService.getBrandNameByOs(params);
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
	 * 获取供应商的下拉
	 * @author  ww 
	 * @date 2017年1月17日 下午1:37:47
	 * @parameter  
	 * @return list{
	 * 				[id-id号、name-供应商名称...]
	 * 			}
	 */
	@RequestMapping(value = "/getSupplierList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSupplierList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<Supplier> list = supplierService.getByConditions(params);
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
	 *  获取供应商的品牌信息（新增、编辑时）
	 * @author  ww 
	 * @date 2016年12月5日 上午9:34:49
	 * @parameter  {
	 * 		supplierId-供应商id
	 * }
	 * @return list{
	 *			[id-id号
	 * 			supplier_id-供应商id
	 *			brandName-品牌名称 
	 * 		]
	 * }
	 */
	@RequestMapping(value = "/getAllBrandsForOutSourcing",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAllBrandForOutSourcing(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{

			List<SupplierBusiness> list = supplierBusinessService.getByConditions(params);
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
	 * 得到承运商价格信息列表
	 * @author  ww 
	 * @date 2016年12月5日 上午9:21:56
	 * @parameter  params [ outSourcingId-承运商id、libName-库区、brandName-品牌、supplierName-供应商名称、carType-车型、
	 * 						startAddress-始发地、endProvince-目的省、endAddress-目的地
	 * 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 					 ]
	 * 
	 * @return		{
	 * 					records:[  id-id号、outSourcingId-承运商id、businessId-品牌id、libName-库区、startAddress-始发地、
	 * 								endProvince-目的省、endAddress-目的地、
	 * 					  			price-价格、distance-公里、carType-车型、insertTime-插入时间、insertUser、updateTime、updateUser、
	 * 								delFlag、outSourcingName-承运商名称、brandName-品牌名称、supplierName-供应商名称
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
			Pager<OutSourcingBusinessPrice> pager = outSourcingBusinessPriceService.getPageData(params);
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
	 * 保存 （id为空）     修改（id不为空） 承运商价格信息
	 * @author  ww 
	 * @date 2016年12月5日 上午9:25:38
	 * @parameter  [  id-id、outSourcingId-承运商id、supplierId-供应商id、brandName-品牌、libName-库区、startAddress-始发地、
	 * 				endProvince-目的省、endAddress-目的地、
	* 				price-价格、distance-公里、carType-车型
	* 			]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody OutSourcingBusinessPrice bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			outSourcingBusinessPriceService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 根据id得到承运商价格数据
	 * @author  ww 
	 * @date 2016年12月5日 上午9:24:11
	 * @parameter  id
	 * @return [  id-id、outSourcingId-承运商id、supplierId-供应商id、brandName-品牌、libName-库区、startAddress-始发地、
	 * 								endProvince-目的省、endAddress-目的地、
	* 					  			price-价格、distance-公里、carType-车型
	* 							]
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
			OutSourcingBusinessPrice bean = outSourcingBusinessPriceService.getById(id);
			
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
	 * 删除承运商价格信息
	 * @author  ww 
	 * @date 2016年12月5日 上午10:33:22
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
			outSourcingBusinessPriceService.delete(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 查询系统-承运商价格  页面
	 * @author  ww 
	 * @date 2016年12月19日 上午9:48:11
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/outSourcingBusinessPrice/adminIndex");		
		return mv;		
	}
}
