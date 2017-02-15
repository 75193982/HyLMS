package com.jshpsoft.controller.operationMng;

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

import com.jshpsoft.domain.BalanceBill;
import com.jshpsoft.service.BalanceBillMngUpService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 对账管理Controller  上游
* @author  fengql 
* @date 2016年11月4日 下午2:35:59
 */
@Controller
@RequestMapping("/operationMng/balanceBillMngUp")
public class BalanceBillMngUpController {
	
	@Autowired  
	private BalanceBillMngUpService balanceBillMngUpService;
	
	/**
	 * 对账管理页面
	* @author  fengql 
	* @date 2016年11月4日 下午2:36:33 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/balanceBillMngUp/index");		
		return mv;		
	}

	/**
	 * 获取对账列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ startTime-插入开始时间(String)、endTime-插入结束时间(String)、supplierId-供应商id(String)、
	* 						waybillNo-运单号(String)、status-状态:0新建1已确认(String,传0或1)  所有条件不填或不选传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、supplierName-供应商、waybillNo-运单号、brand-品牌、carCount-台数、distance-公里数、balanceType-结算方式、
	 * 								balanceAmount-结算总金额、status-状态、insertTime-运单插入时间、verifyTime-确认时间  ]
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
			params.put("type", Constants.BalanceBillType.UP);//0上游对账
			Pager<BalanceBill> pager = balanceBillMngUpService.getPageData(params);
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
	 * 获取对账详细信息-用于编辑
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [ id-id号、carCount-台数、distance-公里数、balanceType-结算方式、balanceAmount-结算总金额 、mark-备注 ]
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
			BalanceBill bean = balanceBillMngUpService.getById(id);
			
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
	 * 获取对账详细信息-用于查看打印
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [ supplierName-供应商、waybillNo-运单号、carCount-台数、distance-公里数、balanceAmount-结算总金额  
	* 					 detailList [ brand-品牌、model-车型、color-颜色、vin-车架号、engineNo-发动机号  ]
	* 					]
	 */
	@RequestMapping(value = "/getDetailPrintData/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetailPrintData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			BalanceBill bean = balanceBillMngUpService.getDetailPrintData(id);
			
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
	 * 获取结算总金额
	* @author  fengql 
	* @date 2016年11月4日 下午3:38:16 
	* @parameter  params [ id-id号(int)、carCount-台数(int)、distance-公里数(int)、balanceType-结算方式(String,传0、1、2) ] 所有的条件必传，不可为空
	* @return	data-结算总金额(Double)
	 */
	@RequestMapping(value = "/getAmount",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAmount(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Double amount = balanceBillMngUpService.getAmount(params);
			
			result.put("data", amount);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 修改对账信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:31:01 
	* @parameter  bean [ id-id号(int)、carCount-台数(int)、distance-公里数(int)、balanceType-结算方式(String,传0、1、2)、
	* 					 balanceAmount-结算总金额(Double)、mark-备注(String) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody BalanceBill bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			balanceBillMngUpService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 确认对账信息
	* @author  fengql 
	* @date 2016年11月4日 下午3:36:13 
	* @parameter  id-id号(int) 必传
	* @return
	 */
	@RequestMapping(value = "/sure/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> sure(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "确认失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			balanceBillMngUpService.sure(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "确认失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 打印列表
	* @author  fengql 
	* @date 2016年11月4日 下午3:47:43 
	* @parameter  params [ startTime-插入开始时间(String)、endTime-插入结束时间(String)、supplierId-供应商id(String)、
	* 						waybillNo-运单号(String)、status-状态:0新建1已确认(String) ]  所有条件不填或不选传''
	* 
	* @return		list [ supplierName-供应商、waybillNo-运单号、brand-品牌、carCount-台数、distance-公里数、balanceType-结算方式、
	 * 					   balanceAmount-结算总金额、status-状态、insertTime-运单插入时间、verifyTime-确认时间  ]
	 */
	@RequestMapping(value = "/getPrint",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getPrint(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("type", Constants.BalanceBillType.UP);//0上游对账
			List<BalanceBill> list = balanceBillMngUpService.getPrint(params);
				
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
	 * 导出列表
	* @author  fengql 
	* @date 2016年11月4日 下午3:47:43 
	* @parameter  params [ startTime-插入开始时间(String)、endTime-插入结束时间(String)、supplierId-供应商id(String)、
	* 						waybillNo-运单号(String)、status-状态:0新建1已确认(String) ]  所有条件不填或不选传''
	* 
	* @return		list [ supplierName-供应商、waybillNo-运单号、brand-品牌、carCount-台数、distance-公里数、balanceType-结算方式、
	 * 					   balanceAmount-结算总金额、status-状态、insertTime-运单插入时间、verifyTime-确认时间  ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam("supplierId") String supplierId,
			@RequestParam("waybillNo") String waybillNo,
			@RequestParam("status") String status
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("supplierId", supplierId);
		params.put("waybillNo", waybillNo);
		params.put("status", status);
		
		params.put("type", Constants.BalanceBillType.UP);//0上游对账
		Map<String, Object> formatData = balanceBillMngUpService.getExportData(params);

		String fileName = "上游对账信息Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
}
