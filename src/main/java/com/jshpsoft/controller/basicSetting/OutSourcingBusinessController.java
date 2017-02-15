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
import com.jshpsoft.domain.SupplierBusiness;
import com.jshpsoft.service.OutSourcingBusinessService;
import com.jshpsoft.service.OutSourcingService;
import com.jshpsoft.service.SupplierBusinessService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 承运商（外协单位）品牌设置
 * @author  ww 
 * @date 2016年11月26日 下午4:37:35
 */
@Controller
@RequestMapping("/basicSetting/outSourcingBusiness")
public class OutSourcingBusinessController {
	
	@Autowired  
	private OutSourcingBusinessService outSourcingBusinessService;
	
	@Autowired  
	private SupplierBusinessService supplierBusinessService;
	
	@Autowired  
	private OutSourcingService outSourcingService;
	
	private int oid = 0;//当前供应商id
	
	@RequestMapping(value = "/index/{outSourcingId}",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable int outSourcingId) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/outSourcingBusiness/index");
		mv.addObject("outSourcingId",outSourcingId);
		oid = outSourcingId;
		return mv;		
	}
	
	/**
	 * 获取承运商品牌设置数据
	 * @author  ww 
	 * @date 2016年12月3日 上午8:58:52
	 * @parameter  params [ supplierId-供应商id
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、outSourcingId、outSourcingName-承运商名称、supplierId、supplierName-供应商名称、
	 * 					brandName-品牌、accountType-结账方式、balanceType-结算模式、
	 * 					updateTime-更新时间、updateUserName-更新人、delFlag]
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
			Pager<OutSourcingBusiness> pager = outSourcingBusinessService.getPageData(params);
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
	 * 获取供应商的品牌
	 * @author  ww 
	 * @date 2017年1月16日 下午1:36:17
	 * @parameter  params{ supplierId-供应商id}
	 * @return list{bean[id-id号、supplierId、supplierName-供应商名称、brandName-品牌、accountType-结账方式、balanceType-结算模式、insertTime-插入时间、insertUser-插入人、delFlag]}
	 */
	@RequestMapping(value = "/getSupplierBusinessData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSupplierBusinessData(HttpServletRequest request, 
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
	 * 得到可选择的承运商(不包括当前)
	 * @author  ww 
	 * @date 2017年1月16日 下午1:59:35
	 * @parameter  
	 * @return list{bean[id,name-承运商名称]}
	 */
	@RequestMapping(value = "/getSelectOutSourcingData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSelectOutSourcingData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("currentId", oid);
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
	 * 保存、修改保存
	 * @author  ww 
	 * @date 2016年12月3日 上午9:02:57
	 * @parameter  OutSourcingBusiness[
	 * 				id-设置id(id没有传空''),outSourcingId--承运商id,supplierId--供应商id,brandName-品牌,accountType--结账方式,balanceType--结算模式,filePath--地址,oids-承运商ids,逗号隔开
	 * 				]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody OutSourcingBusiness bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			outSourcingBusinessService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 根据id获取承运商品牌设置数据
	 * @author  ww 
	 * @date 2016年12月3日 上午9:01:09
	 * @parameter  id
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
			OutSourcingBusiness bean = outSourcingBusinessService.getById(id);
			
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
	 * 删除
	 * @author  ww 
	 * @date 2016年12月3日 上午9:04:08
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
			outSourcingBusinessService.delete(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 设置价格后保存（结账方式，结算模式，价格导入）
	 * @author  ww   
	 * @date 2016年12月5日 下午1:22:18
	 * @parameter 
	 * 				OutSourcingBusiness[
	 * 				id-设置id(id没有传空''),outSourcingId--承运商id,supplierId--供应商id,brandName-品牌,accountType--结账方式,balanceType--结算模式,filePath--地址,oids-承运商ids,逗号隔开
	 * 				]
	 * 	
	 * @return
	 */
	/*@RequestMapping(value = "/siteSave",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> siteSave(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody OutSourcingBusiness bean) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String oper = CommonUtil.getOperId(request);
			outSourcingBusinessService.siteSave(request, bean,oper);
			result.put("code", 200);
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
	}*/
	
}
