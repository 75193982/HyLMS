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

import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.TransportPriceSetting;
import com.jshpsoft.service.SupplierService;
import com.jshpsoft.service.TransportPriceMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 驳板价格管理Controller
* @author  fengql 
* @date 2016年9月20日 下午2:03:14
 */
@Controller
@RequestMapping("/basicSetting/transportPriceMng")
public class TransportPriceMngController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private SupplierService supplierService;
	
	@Autowired  
	private TransportPriceMngService transportPriceMngService;
	
	/**
	 * 驳板价格管理页面
	* @author  fengql 
	* @date 2016年9月20日 下午2:04:20 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/transportPriceMng/index");		
		return mv;		
	}

	/**
	 * 获取供应商列表信息
	* @author  fengql 
	* @date 2016年9月20日 下午2:06:43 
	* @parameter  name-名称（模糊查询）
	* @return	List [ id-id号、name-名称 ]
	 */
	@RequestMapping(value = "/getSupplierList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSupplierList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String,Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
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
	 * 根据供应商获取所有的库
	* @author  fengql 
	* @date 2016年9月20日 下午2:09:29 
	* @parameter  supplierId-供应商id(int) 必传
	* @return	  list[stocks-库名]
	 */
	@RequestMapping(value = "/getSupplierStockList/{supplierId}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getSupplierStockList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer supplierId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<Supplier> list = supplierService.getSupplierStockList(supplierId);
			
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
	 * 获取驳板价格列表数据
	* @author  fengql 
	* @date 2016年9月20日 下午2:17:36 
	* @parameter  params [ supplierId-供应商id(int) 没有值传'',stock-库区名称，brandName-品牌名称
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return	    {
	 * 					records:[ id-id号、supplierName-供应商名称、stock-供应商库、brandName-供应商品牌、price-单价、insertTime-插入时间、insertUser-插入人  ]
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
			Pager<TransportPriceSetting> pager = transportPriceMngService.getPageData(params);
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
	 * 保存驳板价格信息
	* @author  fengql 
	* @date 2016年9月20日 下午2:27:21 
	* @parameter  bean [ supplierId-供应商id(int)、stock-供应商库(String)、brandName-供应商品牌(String)、price-单价(double) ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TransportPriceSetting bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			transportPriceMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取驳板价格详细信息-用于修改
	* @author  fengql 
	* @date 2016年9月20日 下午2:28:33 
	* @parameter  id-id号(int) 必传
	* @return	  bean [ id-id号、supplierId-供应商id、stock-供应商库、brandName-供应商品牌、price-单价 ]
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
			TransportPriceSetting bean = transportPriceMngService.getById(id);
			
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
	 * 修改驳板价格信息
	* @author  fengql 
	* @date 2016年9月20日 下午2:29:39 
	* @parameter  bean [ id-id号(int)、supplierId-供应商id(int)、stock-供应商库(String)、brandName-供应商品牌(String)、price-单价(double) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TransportPriceSetting bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			transportPriceMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除驳板价格信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月20日 下午2:31:58 
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
			transportPriceMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 管理员权限
	 * @author  ww 
	 * @date 2016年12月16日 下午2:55:26
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView loginAdmin(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/transportPriceMng/adminIndex");		
		return mv;		
	}
	

	
}
