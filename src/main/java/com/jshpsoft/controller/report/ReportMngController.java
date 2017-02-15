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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.ReportForSchedulebill;
import com.jshpsoft.domain.ReportForWaybill;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 报表查询管理Controller
 * @author army.liu 
 */
@Controller
@RequestMapping("/reportMng")
public class ReportMngController {
	
	@Autowired  
	private CommonService commonService;
	
	/**
	 * 承运商运费列表页面
	 * @author army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/outSourcingCost/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/outSourcingCost/index");
		return mv;		
	}

	/**
	 * 获取承运商运费列表数据
	 * @author  army.liu  
	 * @parameter  {
	 * 						outSourcingId-承运商id、startWaybillSendTime-下单开始时间、endWaybillSendTime-下单结束时间、startScheduleSendTime-装运开始时间、endScheduleSendTime-装运结束时间、carNumber-装运车号、调度单号-scheduleBillNo、
	 * 						startAddress-始发地、targetProvince-目的省、targetCity-目的地、carShopId-4S店id
	 * 
     * 						pageStartIndex -页开始索引
     * 						pageSize -页大小
     * 						sEcho -前台带过来的参数，不动返回回去的
	 * 				}
	 * 
	 * @return		{
	 * 					records:[ 
	 * 						stockId-仓库id、waybillId、waybillNo、carShopId、carShopName-4S店名称、supplierId、supplierName-供应商名称、startAddress、targetProvince、targetCity、waybillSendTime-下单时间、waybillStatus-运单状态、carStockId、carType、brand、model、vin、carInStockTime-入库时间、carPrice-二手车价格、carStatus-商品车状态、
	 * 						scheduleBillNo、scheduleSendTime-装运日期、carNumber、driverId、outSourcingId-承运商id、outSourcingName-承运商名称、scheduleStatus-调度单状态、scheduleApplyUserId-调度员id、transportCost-承运商运费
	 * 					]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/outSourcingCost/getListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
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
			Pager<ReportForSchedulebill> pager = commonService.getReportForSchedulebillPageData(params);
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
	 * 导出
	 * @author  army.liu 
	 * @parameter {
	 * 		 		outSourcingId-承运商id、startWaybillSendTime-下单开始时间、endWaybillSendTime-下单结束时间、startScheduleSendTime-装运开始时间、endScheduleSendTime-装运结束时间、carNumber-装运车号、调度单号-scheduleBillNo、
	 * 				startAddress-始发地、targetProvince-目的省、targetCity-目的地、carShopId-4S店id
	 * 			  }
	 * @return {
	 * 				[
	 * 					stockId-仓库id、waybillId、waybillNo、carShopId、carShopName-4S店名称、supplierId、supplierName-供应商名称、startAddress、targetProvince、targetCity、waybillSendTime-下单时间、waybillStatus-运单状态、carStockId、carType、brand、model、vin、carInStockTime-入库时间、carPrice-二手车价格、carStatus-商品车状态、
	 * 					scheduleBillNo、scheduleSendTime-装运日期、carNumber、driverId、outSourcingId-承运商id、outSourcingName-承运商名称、scheduleStatus-调度单状态、scheduleApplyUserId-调度员id、transportCost-承运商运费
	 * 				]
	 * 		   }
	 */
	@RequestMapping(value = "/outSourcingCost/export", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> export(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam String outSourcingId,
			@RequestParam String startWaybillSendTime,
			@RequestParam String endWaybillSendTime,
			@RequestParam String startScheduleSendTime,
			@RequestParam String endScheduleSendTime,
			@RequestParam String carNumber,
			@RequestParam String scheduleBillNo,
			@RequestParam String startAddress,
			@RequestParam String targetProvince,
			@RequestParam String targetCity,
			@RequestParam String carShopId
			) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("outSourcingId", outSourcingId);
			params.put("startWaybillSendTime", startWaybillSendTime);
			params.put("endWaybillSendTime", endWaybillSendTime);
			params.put("startScheduleSendTime", startScheduleSendTime);
			params.put("endScheduleSendTime", endScheduleSendTime);
			params.put("carNumber", carNumber);
			params.put("scheduleBillNo", scheduleBillNo);
			params.put("startAddress", startAddress);
			params.put("targetProvince", targetProvince);
			params.put("targetCity", targetCity);
			params.put("carShopId", carShopId);
			Map<String, Object> formatData = commonService.getReportForSchedulebillExportData(params);
			String fileName = "承运商运费";
			String fileExtend = "xls";
			POIUtil.exportToExcel(request, response, formatData, fileName, fileExtend);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "导出失败："+e.getMessage());	
		}
		return result;
		
	}

	/**
	 * 获取打印及合计数据
	 * @author army.liu 
	 * @parameter {
	 * 		 		outSourcingId-承运商id、startWaybillSendTime-下单开始时间、endWaybillSendTime-下单结束时间、startScheduleSendTime-装运开始时间、endScheduleSendTime-装运结束时间、carNumber-装运车号、调度单号-scheduleBillNo、
	 * 				startAddress-始发地、targetProvince-目的省、targetCity-目的地、carShopId-4S店id
	 * 			  }
	 * @return {
	 * 			data：
	 * 				[
	 * 					stockId-仓库id、waybillId、waybillNo、carShopId、carShopName-4S店名称、supplierId、supplierName-供应商名称、startAddress、targetProvince、targetCity、waybillSendTime-下单时间、waybillStatus-运单状态、carStockId、carType、brand、model、vin、carInStockTime-入库时间、carPrice-二手车价格、carStatus-商品车状态、
	 * 					scheduleBillNo、scheduleSendTime-装运日期、carNumber、driverId、outSourcingId-承运商id、outSourcingName-承运商名称、scheduleStatus-调度单状态、scheduleApplyUserId-调度员id、transportCost-承运商运费
	 * 				]
	 * 			totalCount-台数
	 * 			totalTransportCost-运费
	 * 		   }
	 */
	@RequestMapping(value = "/outSourcingCost/print",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> print(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			List<ReportForSchedulebill> list = commonService.getReportForSchedulebill(params);
			double amount = 0;
			if( null != list && list.size() > 0 ){
				for(int i=0; i<list.size(); i++){
					//获取商品的驳运运费：不包含其他费用
					double transportCost = list.get(i).getTransportCost();
					amount += transportCost;
					
				}
			}
			result.put("data", list);
			result.put("totalCount", list.size());
			result.put("totalTransportCost", CommonUtil.formatDouble(amount));
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 4S店驳运列表页面
	 * @author army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/carShopTransport/index",method=RequestMethod.GET)		
	public ModelAndView carShopTransport(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/carShopTransport/index");
		return mv;		
	}
	
	/**
	 * 获取4S店驳运列表数据
	 * @author  army.liu  
	 * @parameter  {
	 * 						carShopId-4S店id、运单号-waybillNo、startWaybillSendTime-下单开始时间、endWaybillSendTime-下单结束时间、model-车型、vin-车架号
	 * 
	 * 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 				}
	 * 
	 * @return		{
	 * 					records:[ 
	 * 						carShopId、carShopName-4S店名称、waybillNo、waybillSendTime-下单时间、waybillStatus-运单状态、carStockId、carType-车的类型、brand、model-车型、vin-车架号、carInStockTime-入库时间、carStatus-商品车状态：1-待运，2-已运
	 * 					]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/carShopTransport/getListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarShopTransportListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<ReportForWaybill> pager = commonService.getReportForWaybillPageData(params);
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
	 * 4S店驳运导出
	 * @author  army.liu 
	 * @parameter {
	 * 						carShopId-4S店id、运单号-waybillNo、startWaybillSendTime-下单开始时间、endWaybillSendTime-下单结束时间、model-车型、vin-车架号
	 * 			  }
	 * @return {
	 * 				[
	 * 						carShopId、carShopName-4S店名称、waybillNo、waybillSendTime-下单时间、waybillStatus-运单状态、carStockId、carType-车的类型、brand、model-车型、vin-车架号、carInStockTime-入库时间、carStatus--商品车状态：1-待运，2-已运
	 * 				]
	 * 		   }
	 */
	@RequestMapping(value = "/carShopTransport/export", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> exportCarShopTransport(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam String waybillNo,
			@RequestParam String startWaybillSendTime,
			@RequestParam String endWaybillSendTime,
			@RequestParam String model,
			@RequestParam String vin,
			@RequestParam String carShopId
			) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("waybillNo", waybillNo);
			params.put("startWaybillSendTime", startWaybillSendTime);
			params.put("endWaybillSendTime", endWaybillSendTime);
			params.put("model", model);
			params.put("vin", vin);
			params.put("carShopId", carShopId);
			Map<String, Object> formatData = commonService.getReportForWaybillExportData(params);
			String fileName = "4S店驳运";
			String fileExtend = "xls";
			POIUtil.exportToExcel(request, response, formatData, fileName, fileExtend);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "导出失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 获取4S店驳运打印及合计数据
	 * @author army.liu 
	 * @parameter {
	 * 						carShopId-4S店id、运单号-waybillNo、startWaybillSendTime-下单开始时间、endWaybillSendTime-下单结束时间、model-车型、vin-车架号
	 * 			  }
	 * @return {
	 * 				data:
	 * 				[
	 * 						carShopId、carShopName-4S店名称、waybillNo、waybillSendTime-下单时间、waybillStatus-运单状态、carStockId、carType-车的类型、brand、model-车型、vin-车架号、carInStockTime-入库时间、carStatus--商品车状态：1-待运，2-已运	
	 * 				]
	 * 				totalCount-台数
	 * 				unFinished-未完成
	 * 				hasFinished-已完成
	 * 		   }
	 */
	@RequestMapping(value = "/carShopTransport/print",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> printCarShopTransport(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			List<ReportForWaybill> list = commonService.getReportForWaybill(params);
			int unFinished = 0;
			if( null != list && list.size() > 0 ){
				for(int i=0; i<list.size(); i++){
					if( Constants.CarStatus.HASIN.equals(list.get(i).getCarStatus()) ){
						unFinished++;
					}
					
				}
			}
			int hasFinished = list.size()- unFinished;
			result.put("data", list);
			result.put("totalCount", list.size());
			result.put("unFinished", unFinished);
			result.put("hasFinished", hasFinished);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
}
