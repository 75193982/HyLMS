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

import com.jshpsoft.domain.BalancePriceSetting;
import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.service.BalancePriceMngService;
import com.jshpsoft.service.CarBrandService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 结算价格管理Controller
* @author  fengql 
* @date 2016年9月20日 下午2:03:14
 */
@Controller
@RequestMapping("/basicSetting/balancePriceMng")
public class BalancePriceMngController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private BalancePriceMngService balancePriceMngService;
	
	@Autowired  
	private CarBrandService carBrandService;
	
	/**
	 * 结算价格管理页面
	* @author  fengql 
	* @date 2016年9月20日 下午2:04:20 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/balancePriceMng/index");		
		return mv;		
	}
	
	/**
	 * 获取供应商列表信息
	* @author  fengql 
	* @date 2016年9月20日 下午2:06:43 
	* @parameter  
	* @return	List [ id-id号、name-名称 ]
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
			List<Supplier> list = commonService.getBasicSuppliersList(params);
			
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
	 * 获取品牌列表信息
	* @author  fengql 
	* @date 2016年10月8日 下午2:29:34 
	* @parameter  
	* @return	List [ id-id号、brandName-名称 ]
	 */
	@RequestMapping(value = "/getBrandList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getBrandList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<CarBrand> list = commonService.getCarBrandList(params);
			
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
	 * 根据品牌id获取所有的车型
	* @author  fengql 
	* @date 2016年9月20日 下午2:09:29 
	* @parameter  id-品牌id(int)  必传
	* @return	  list[carType-车型]
	 */
	@RequestMapping(value = "/getCarTypeList/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getCarTypeList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<CarBrand> list = carBrandService.getCarTypeList(id);
			
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
	 * 获取结算价格列表数据
	* @author  fengql 
	* @date 2016年9月20日 下午2:17:36 
	* @parameter  params [ supplierId-供应商id(int)、brand-品牌(String)、carType-车型(String)   非必传,没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return	 	{
	 * 					records:[  id-id号、supplierName-供应商名称、brand-品牌、carType-车型、price-单价、
	* 					  			outSourcingPrice-外协单位结算价格、insertTime-插入时间、insertUser-插入人
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
			Pager<BalancePriceSetting> pager = balancePriceMngService.getPageData(params);
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
	 * 保存结算价格信息
	* @author  fengql 
	* @date 2016年9月20日 下午2:27:21 
	* @parameter  bean [  supplierId-供应商id(int)、brand-品牌(String)、carType-车型(String)、price-单价(double)、
	* 					  outSourcingPrice-外协单位结算价格(double)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody BalancePriceSetting bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			balancePriceMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取结算价格详细信息-用于修改
	* @author  fengql 
	* @date 2016年9月20日 下午2:28:33 
	* @parameter  id-id号(int)  必传
	* @return	  bean [  id-id号、supplierId-供应商id、brand-品牌、carType-车型、price-单价、
	* 					  outSourcingPrice-外协单位结算价格
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
			BalancePriceSetting bean = balancePriceMngService.getById(id);
			
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
	 * 修改结算价格信息
	* @author  fengql 
	* @date 2016年9月20日 下午2:29:39 
	* @parameter  bean [  id-id号(int)、supplierId-供应商id(int)、brand-品牌(String)、carType-车型(String)、price-单价(double)、
	* 					  outSourcingPrice-外协单位结算价格(double)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody BalancePriceSetting bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			balancePriceMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除结算价格信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月20日 下午2:31:58 
	* @parameter  id-id号(int)  必传
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
			balancePriceMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
}
