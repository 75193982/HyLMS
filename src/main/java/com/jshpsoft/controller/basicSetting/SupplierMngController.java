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
import com.jshpsoft.domain.Stock;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.service.SupplierService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 供应商管理Controller
* @author  fengql 
* @date 2016年9月20日 下午1:25:23
 */
@Controller
@RequestMapping("/basicSetting/supplierMng")
public class SupplierMngController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private SupplierService supplierService;
	
	/**
	 * 供应商管理页面
	* @author  fengql 
	* @date 2016年9月20日 下午1:29:00 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/supplierMng/index");		
		return mv;		
	}

	/**
	 * 获取供应商列表数据
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
	* 					  			startTime-开始时间、endTime-结束时间、needInvoiceFlag-是否需要提供发票、invoiceOrder-开票方式、stocks-库
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
			Pager<Supplier> pager = supplierService.getPageData(params);
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
	 * 获取仓库列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午11:16:12 
	* @parameter  
	* @return	List [ id-id号、name-名称 ]
	 */
	@RequestMapping(value = "/getStockList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getStockList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<Stock> list = commonService.getStockList(params);
			
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
	 * 保存供应商信息
	* @author  fengql 
	* @date 2016年9月20日 下午1:43:57 
	* @parameter  bean [  name-名称(String)、address-地址(String)、linkUser-联系人(String)、brithday-联系人出生日期(date)、linkTelephone-电话号码(String)、linkMobile-手机号码(String)、
	* 					  startTime-开始时间(date)、endTime-结束时间(date)、needInvoice_flag-是否需要提供发票(String)、invoiceOrder-开票方式(String)、stocks-库(String)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Supplier bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			supplierService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取供应商详细信息-用于修改
	* @author  fengql 
	* @date 2016年9月20日 下午1:45:13 
	* @parameter  id-id号(int) 必传
	* @return	  bean [  id-id号、name-名称、address-地址、linkUser-联系人、brithday-联系人出生日期、linkTelephone-电话号码、linkMobile-手机号码、
	* 					  startTime-开始时间、endTime-结束时间、needInvoiceFlag-是否需要提供发票、invoiceOrder-开票方式、stocks-库
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
			Supplier bean = supplierService.getById(id);
			
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
	 * 修改供应商信息
	* @author  fengql 
	* @date 2016年9月20日 下午1:46:52 
	* @parameter  bean [  id-id号(int)、name-名称(String)、address-地址(String)、linkUser-联系人(String)、brithday-联系人出生日期(date)、linkTelephone-电话号码(String)、linkMobile-手机号码(String)、
	* 					  startTime-开始时间(date)、endTime-结束时间(date)、needInvoice_flag-是否需要提供发票(String)、invoiceOrder-开票方式(String)、stocks-库(String)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Supplier bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			supplierService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除供应商信息--更新逻辑删除键标志
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
			supplierService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * @Description: 获取结算价格设置
	 * @author army.liu 
	 * @param 
	 * {
	 * 		id-供应商id (int) 必传
	 * }
	 * @return
	 * {
	 * 		data :
	 * 		[
	 * 			id-主键
	 * 			price-价格
	 * 			outSourcingPrice-外协单位结算价格
	 * 			brand-品牌
	 * 			carType-车型
	 * 		]
	 * }
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/getBalanceSettingInfo/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getBalanceSettingInfo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable int id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "查询失败");
		
		try{
			List<BalancePriceSetting> list = supplierService.getBalanceSettingInfo( id );
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "查询失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * @Description: 保存结算价格设置
	 * @author army.liu 
	 * @param 
	 * {
	 * 		id-供应商id (int)
	 * 		balanceType-结算方式（0-单价模式，1-公里数模式、2-总价模式）(String)
	 * 		detail : 
	 * 		[
	 * 			prices-价格(double)
	 * 			outSourcingPrice-外协单位结算价格(double)
	 * 			brand-品牌(String)
	 * 			carType-车型(String)
	 * 
	 * 		]
	 * }
	 * @return
	 * {
	 * 		
	 * }
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/saveBalanceSetting",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> saveBalanceSetting(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Supplier bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			supplierService.saveBalanceSetting(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 供应商查询系统
	* @author  ww
	* @date 2016年12月17日 下午1:29:00 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminLogin(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/supplierMng/adminIndex");		
		return mv;		
	}
}
