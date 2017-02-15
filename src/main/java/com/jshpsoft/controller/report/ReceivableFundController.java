package com.jshpsoft.controller.report;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.ContactFunds;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.service.ContactFundsService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 供应商应收款Controller
* @author  fengql 
* @date 2017年1月9日 下午3:19:34
 */
@Controller
@RequestMapping("/reportMng/receivableFund")
public class ReceivableFundController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private ContactFundsService contactFundsService;
	
	/**
	 * 供应商款项主页面
	* @author  fengql 
	* @date 2017年1月9日 下午3:21:17 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/receivableFund/index");
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
	 * 获取供应商款项列表
	* @author  fengql 
	* @date 2017年1月9日 下午3:25:17 
	* @parameter  params [ businessId-供应商id(String)、fundDateStart-开始日期、fundDateEnd-结束日期、fundType-类型、status-状态(String)    没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、businessName-供应商、fundDate-账款日期、fundType-款项类型(0应收款1实收款)、cashAmount-现金金额、oilAmount-油卡金额、
	 * 								amount-总金额、status-状态、mark-备注 ]
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
			params.put("businessType", Constants.ContactFundsType.GYS);//业务类型：0供应商
			Pager<ContactFunds> pager = contactFundsService.getPageData(params);
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
	 * 获取供应商款项列表--打印
	 * @author  fengql 
	 * @date 2017年1月9日 下午3:25:17 
	 * @parameter  params [ businessId-供应商id(String)、fundDateStart-开始日期、fundDateEnd-结束日期、fundType-类型、status-状态(String)    没有值传''
	 * 					 ]
	 * 
	 * @return	list[ businessName-供应商、fundDate-账款日期、fundType-款项类型(0应收款1实收款)、cashAmount-现金金额、oilAmount-油卡金额、
	 * 				  amount-总金额、status-状态、mark-备注]
	 */
	@RequestMapping(value = "/getPrintData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getPrintData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("businessType", Constants.ContactFundsType.GYS);//业务类型：0供应商
			List<ContactFunds> list = contactFundsService.getPrintData(params);
			
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
	 * 导出供应商款项列表
	 * @author  fengql 
	 * @date 2017年1月9日 下午3:25:17 
	 * @parameter  params [ businessId-供应商id(String)、fundDateStart-开始日期、fundDateEnd-结束日期、fundType-类型、status-状态(String)    没有值传''
	 * 					 ]
	 * 
	 * @return	list[ businessName-供应商、fundDate-账款日期、fundType-款项类型(0应收款1实收款)、cashAmount-现金金额、oilAmount-油卡金额、
	 * 				  amount-总金额、status-状态、mark-备注]
	 */
	@RequestMapping(value = "/getExportData", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void getExportData(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("businessId") String businessId,
			@RequestParam("fundDateStart") String fundDateStart,
			@RequestParam("fundDateEnd") String fundDateEnd,
			@RequestParam("fundType") String fundType,
			@RequestParam("status") String status
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("businessId", businessId);
		params.put("fundDateStart", fundDateStart);
		params.put("fundDateEnd", fundDateEnd);
		params.put("fundType", fundType);
		params.put("status", status);
		
		params.put("businessType", Constants.ContactFundsType.GYS);//业务类型：0供应商
		
		Map<String, Object> formatData = contactFundsService.getRecExportData(params);

		String fileName = "供应商往来款Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}

	/**
	 * 保存或修改保存款项信息
	* @author  fengql 
	* @date 2017年1月10日 下午1:36:34 
	* @parameter  bean [ id-id号(新增时不传)、businessId-供应商id、fundDate-账款日期、fundType-款项类型(0应收款1实收款)、cashAmount-现金金额、oilAmount-油卡金额、
	 * 					amount-总金额(=现金+油卡)、mark-备注 ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody ContactFunds bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			
			bean.setBusinessType(Constants.ContactFundsType.GYS);//业务类型：0供应商
			contactFundsService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 获取款项详细信息--用于修改
	* @author  fengql 
	* @date 2017年1月10日 下午1:46:57 
	* @parameter   id-id号(int)  必传
	* @return   bean [ id-id号、businessId-供应商id、fundDate-账款日期、fundType-款项类型(0应收款1实收款)、cashAmount-现金金额、oilAmount-油卡金额、
	 * 					amount-总金额(=现金+油卡)、mark-备注 ]
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
			ContactFunds bean = contactFundsService.getById(id);
			
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
	 * 删除款项信息--更新删除逻辑标志
	* @author  fengql 
	* @date 2017年1月10日 下午1:48:31 
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
			contactFundsService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 提交款项信息
	* @author  fengql 
	* @date 2017年1月10日 下午1:48:31 
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
			contactFundsService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 供应商应收款报表页面
	* @author  fengql 
	* @date 2017年1月11日 上午10:19:33 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/reportIndex",method=RequestMethod.GET)		
	public ModelAndView reportIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/receivableFund/reportIndex");
		return mv;		
	}
	
	/**
	 * 获取供应商应收款报表
	* @author  fengql 
	* @date 2017年1月9日 下午3:25:17 
	* @parameter  params [ fundDate-账款日期(默认为当前月,必传)、businessId-供应商id(String,没有值传'') ]   
	* 
	* @return	list[ businessName-供应商、allAmount-应收运费、giveAmount-实收运费、(allAmount-giveAmount)-应收余额   ]
	 */
	@RequestMapping(value = "/getReportData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getReportData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("businessType", Constants.ContactFundsType.GYS);//业务类型：0供应商
			params.put("status", Constants.ContactFundsStatus.SUBMIT);
			List<ContactFunds> list = contactFundsService.getReportData(params);
			
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
	 * 导出供应商应收款报表
	 * @author  fengql 
	 * @date 2017年1月9日 下午3:25:17 
	 * @parameter  params [ fundDate-账款日期(默认为当前月,必传)、businessId-供应商id(String,没有值传'') ]   
	 * 
	 * @return	list [ businessName-供应商、allAmount-应收运费、giveAmount-实收运费、(allAmount-giveAmount)-应收余额   ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("fundDate") String fundDate,
			@RequestParam("businessId") String businessId
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("fundDate", fundDate);
		params.put("businessId", businessId);
		params.put("businessType", Constants.ContactFundsType.GYS);//业务类型：0供应商
		params.put("status", Constants.ContactFundsStatus.SUBMIT);
		
		Map<String, Object> formatData = contactFundsService.getRecExportReport(params);

		String fileName = "应收往来款Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
}
