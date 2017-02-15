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

import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.SupplierBusiness;
import com.jshpsoft.service.CarBrandService;
import com.jshpsoft.service.SupplierBusinessService;
import com.jshpsoft.service.SupplierService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;
/**
 * 汽车品牌管理Controller
* @author  fengql 
* @date 2016年9月21日 上午10:07:01
 */
@Controller
@RequestMapping("/basicSetting/carBrandMng")
public class CarBrandMngController {
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private CarBrandService carBrandService;
	
	@Autowired  
	private SupplierBusinessService supplierBusinessService;
	
	@Autowired  
	private SupplierService supplierService;
	
	/**
	 * 汽车品牌管理页面
	* @author  fengql 
	* @date 2016年9月21日 上午10:10:01
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/carBrandMng/index");
		return mv;		
	}

	/**
	 * 获取汽车品牌列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ brandName-品牌(String,模糊 查询)、carType-车型 (String,模糊 查询) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、supplierName-供应商名称、brandName-品牌、carType-车型、mark-备注、insertTime-插入时间、insertUser-插入人、billType-结账方式、 settlementType-结算模式 ]
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
			Pager<CarBrand> pager = carBrandService.getPageData(params);
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
	 * 保存汽车品牌信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ brandName-品牌(String)、carType-车型(String)、mark-备注(String) ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarBrand bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			bean.setPy(commonService.getPyCode(bean.getBrandName()));
			bean.setWb(commonService.getWbCode(bean.getBrandName()));
			carBrandService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取汽车品牌详细信息-用于修改
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01 
	* @parameter  id-id号(int)  必传
	* @return	  bean [  id-id号、brandName-品牌、carType-车型、mark-备注  ]
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
			CarBrand bean = carBrandService.getById(id);
			
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
	 * 修改汽车品牌信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:31:01 
	* @parameter  bean [ id-id号(int)、brandName-品牌(String)、carType-车型(String)、mark-备注(String) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarBrand bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		bean.setPy(commonService.getPyCode(bean.getBrandName()));
		bean.setWb(commonService.getWbCode(bean.getBrandName()));
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carBrandService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除汽车品牌信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月21日 上午10:35:01
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
			carBrandService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
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
	 * 设置保存（结账方式，结算模式，价格导入）
	 * @author  ww 
	 * @date 2016年11月24日 下午1:22:18
	 * @parameter  params[id-品牌设置id,supplierId--供应商id,brandId--品牌设置id,billType--结账方式,settlementType--结算模式,filePath--地址]
	 * @return
	 */
	@RequestMapping(value = "/siteSave",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> siteSave(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String oper = CommonUtil.getOperId(request);
			carBrandService.siteSave(request, params,oper);
			result.put("code", 200);
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
	}
	
	/**
	 * 获取供应商的品牌列表信息
	 * @author  army.liu 
	 * @parameter  
	 * {
	 * 		supplierId-供应商id
	 * }
	 * @return
	 * {
	 * 		[
	 * 			id-id号
	 * 			supplier_id-供应商id
	 *			brandName-品牌名称 
	 * 		]
	 * }
	 * 
	 */
	@RequestMapping(value = "/getAllBrandsForSupplier",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAllBrandForSupplier(HttpServletRequest request, 
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
	 * 获取下拉供应商
	 * @author  ww 
	 * @date 2016年11月26日 下午4:02:00
	 * @parameter  
	 * @return
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
	
}
