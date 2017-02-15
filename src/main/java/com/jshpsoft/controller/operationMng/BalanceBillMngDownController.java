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
import com.jshpsoft.service.BalanceBillMngDownService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 对账管理Controller  下游
* @author  fengql 
* @date 2016年11月4日 下午2:35:59
 */
@Controller
@RequestMapping("/operationMng/balanceBillMngDown")
public class BalanceBillMngDownController {
	
	@Autowired  
	private BalanceBillMngDownService balanceBillMngDownService;
	
	/**
	 * 对账管理页面
	* @author  fengql 
	* @date 2016年11月4日 下午2:36:33 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/balanceBillMngDown/index");		
		return mv;		
	}

	/**
	 * 获取对账列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ startTime-调度开始时间(String)、endTime-调度结束时间(String)、outSourcingId-外协单位id(String)、
	* 						scheduleBillNo-调度单号(String)、status-状态:0新建1已确认(String,传0或1)  所有条件不填或不选传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、carTrackName-车队名称、scheduleBillNo-调度单号、carCount-台数、balanceAmount-结算总金额、
	 * 								status-状态、insertTime-调度时间、verifyTime-确认时间  ]
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
			params.put("type", Constants.BalanceBillType.DOWN);//1下游对账
			Pager<BalanceBill> pager = balanceBillMngDownService.getPageData(params);
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
	* @return	  bean [ id-id号、carCount-台数(不能修改)、transportAmount-驳运费用、oilAmount-总油费、oilBalanceRatio-油费结算比率、
	* 						balanceAmount-结算总金额 、mark-备注 ]
	* 					注意：驳运费用*油费结算比率/100=总油费,驳运费用+总油费=结算总金额  
	* 
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
			BalanceBill bean = balanceBillMngDownService.getById(id);
			
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
	* @return	  bean [ carTrackName-车队名称、scheduleBillNo-调度单号、carCount-台数、transportAmount-驳运费用、oilAmount-总油费、balanceAmount-结算总金额
	* 					 scheduleList [  id-id号(不显示)、carShopId-4S店编号、carShopName-4S店名称、mark-调度内容、amount-数量、status-状态0-未完成，1-已完成
	* 								            注意：当carShopId为空时，为二手车
	* 									carList [	id-id号(不显示)、waybillNo-运单原始编号、brand-品牌、model-车型、vin-车架号、color-颜色、
	* 					 							engineNo-发动机号、insertTime-入库时间  
	* 											]
	* 								]
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
			BalanceBill bean = balanceBillMngDownService.getDetailPrintData(id);
			
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
	 * 修改对账信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:31:01 
	* @parameter  bean [ id-id号(int)、carCount-台数(int)、transportAmount-驳运费用(Double)、oilAmount-总油费(Double)、
	* 					  oilBalanceRatio-油费结算比率(int)、balanceAmount-结算总金额(Double)、mark-备注(String) ]
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
			balanceBillMngDownService.update(bean, oper);
			
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
			balanceBillMngDownService.sure(id, oper);
			
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
	* @parameter  params [ startTime-调度开始时间(String)、endTime-调度结束时间(String)、outSourcingId-外协单位id(String)、
	* 						scheduleBillNo-调度单号(String)、status-状态:0新建1已确认(String,传0或1) ]  所有条件不填或不选传''
	* 
	* @return		list [ carTrackName-车队名称、scheduleBillNo-调度单号、carCount-台数、balanceAmount-结算总金额、
	 * 						status-状态、insertTime-调度时间、verifyTime-确认时间  ]
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
			params.put("type", Constants.BalanceBillType.DOWN);//1下游对账
			List<BalanceBill> list = balanceBillMngDownService.getPrint(params);
				
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
	* @parameter  params [ startTime-调度开始时间(String)、endTime-调度结束时间(String)、outSourcingId-外协单位id(String)、
	* 						scheduleBillNo-调度单号(String)、status-状态:0新建1已确认(String,传0或1) ]  所有条件不填或不选传''
	* 
	* @return		list [ carTrackName-车队名称、scheduleBillNo-调度单号、carCount-台数、balanceAmount-结算总金额、
	 * 						status-状态、insertTime-调度时间、verifyTime-确认时间  ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam("outSourcingId") String outSourcingId,
			@RequestParam("scheduleBillNo") String scheduleBillNo,
			@RequestParam("status") String status
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("outSourcingId", outSourcingId);
		params.put("scheduleBillNo", scheduleBillNo);
		params.put("status", status);
		
		params.put("type", Constants.BalanceBillType.DOWN);//1下游对账
		Map<String, Object> formatData = balanceBillMngDownService.getExportData(params);

		String fileName = "下游对账信息Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
}
