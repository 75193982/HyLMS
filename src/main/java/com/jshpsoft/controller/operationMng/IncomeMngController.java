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

import com.jshpsoft.domain.AttachMoneyLog;
import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.service.IncomeMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 收入管理Controller
* @author  fengql 
* @date 2016年10月25日 上午9:37:37
 */
@Controller
@RequestMapping("/operationMng/incomeMng")
public class IncomeMngController {
	
	@Autowired  
	private IncomeMngService incomeMngService;
	
	@Autowired  
	private CommonService commonService;
	
	/**
	 * 收入管理页面
	* @author  fengql 
	* @date 2016年10月25日 上午9:39:27 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/incomeMng/index");		
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
	* @date 2016年9月20日 下午2:06:43 
	* @parameter  
	* @return	List [ id-id号、brandName-名称 ]
	 */
	@RequestMapping(value = "/getCarBrandList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarBrandList(HttpServletRequest request, 
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
	 * 获取收入管理数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ supplierId-供应商id(String)、brand-品牌(String)、waybillDate-下单日期(String)、scheduleDate-装运日期(String)、
	* 						scheduleBillNo-调度单号(String)、waybillStatus-运单状态(String)    没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、supplierName-供应商、brand-品牌、model-车型、vin-车架号、waybillDate-下单日期、waybillNo-运单号、carNumber-装运车号、scheduleDate-装运日期、
	 * 								scheduleBillNo-调度单号、startAddress-出发地、targetProvince-目的省、targetCity-目的地、count-台数、distance-公里数、price-结算单价、
	 * 								balancePrice-结算运费、bargePrice-驳板费、farePrice-加价运费、otherDeduct-其他扣除、sumPrice-最终费用、waybillStatus-运单状态
	 * 								balanceFlag:是否能对账标志：Y可以N不可以]
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
			//状态:1,2,3  类型 0,1
			params.put("statusIn", Constants.WaibillStatus.UNREVIEW.getValue() + "," + Constants.WaibillStatus.UNRECEIPT.getValue() + "," + Constants.WaibillStatus.FINISHED.getValue() );
			params.put("typeIn", Constants.WaybillType.SPC+ "," +Constants.WaybillType.ESC);
			
			Pager<BalanceCar> pager = incomeMngService.getPageData(params);
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
	 * 获取当前条件的总金额
	* @author  fengql 
	* @date 2016年10月25日 上午10:15:12 
	* @parameter  params [supplierId-供应商id(String)、brand-品牌(String)、waybillDate-下单日期(String)、scheduleDate-装运日期(String)、
	* 						scheduleBillNo-调度单号(String)、waybillStatus-运单状态(String)]  没有值的传''
	* 
	* @return	sumPrice--总金额
	 */
	@RequestMapping(value = "/getSumPrice",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getSumPrice(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			//状态:1,2,3  类型 0,1
			params.put("statusIn", Constants.WaibillStatus.UNREVIEW.getValue() + "," + Constants.WaibillStatus.UNRECEIPT.getValue() + "," + Constants.WaibillStatus.FINISHED.getValue() );
			params.put("typeIn", Constants.WaybillType.SPC+ "," +Constants.WaybillType.ESC);
			
			double sumPrice = incomeMngService.getSumPrice(params);
				
			result.put("data", sumPrice);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存额外计费
	* @author  fengql 
	* @date 2016年10月25日 上午9:58:43 
	* @parameter  bean [ carStockId-商品车id(int)、chargeType-计费类型(int)、amount-金额(double)、mark-备注(String)  ]   
	* 					 chargeType:0加价运费1其他扣除
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody AttachMoneyLog bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			bean.setAttachMold(Constants.attachMold.INCOME);//收入
			incomeMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 查看额外计费信息
	* @author  fengql 
	* @date 2016年10月25日 上午10:04:39 
	* @parameter  carStockId-商品车id(int)  chargeType-计费类型  必传
	* @return	list [ id-id号、amount-金额、mark-备注、insertUser-插入人 、insertTime-插入时间 ]
	 */
	@RequestMapping(value = "/getAttachDetail",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAttachDetail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("attachMold", Constants.attachMold.INCOME);
			
			List<AttachMoneyLog> list = incomeMngService.getAttachDetail(params);
			
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
	 * 删除额外计费数据-更新逻辑删除标志
	* @author  fengql 
	* @date 2016年10月25日 上午10:12:42 
	* @parameter  id-id号(额外计费信息的id)(int)  必传
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
			incomeMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 打印数据
	* @author  fengql 
	* @date 2016年10月25日 上午10:15:12 
	* @parameter  params [supplierId-供应商id(String)、brand-品牌(String)、waybillDate-下单日期(String)、scheduleDate-装运日期(String)、
	* 						scheduleBillNo-调度单号(String)、waybillStatus-运单状态(String)]  没有值的传''
	* 
	* @return	list [ id-id号、supplierName-供应商、brand-品牌、model-车型、vin-车架号、waybillDate-下单日期、waybillNo-运单号、carNumber-装运车号、scheduleDate-装运日期、
	 * 					scheduleBillNo-调度单号、startAddress-出发地、targetProvince-目的省、targetCity-目的地、count-台数、distance-公里数、price-结算单价、
	 * 					balancePrice-结算运费、bargePrice-驳板费、farePrice-加价运费、otherDeduct-其他扣除、sumPrice-最终费用、waybillStatus-运单状态 ]
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
			//状态:1,2,3  类型 0,1
			params.put("statusIn", Constants.WaibillStatus.UNREVIEW.getValue() + "," + Constants.WaibillStatus.UNRECEIPT.getValue() + "," + Constants.WaibillStatus.FINISHED.getValue() );
			params.put("typeIn", Constants.WaybillType.SPC+ "," +Constants.WaybillType.ESC);
			
			List<BalanceCar> list = incomeMngService.getPrint(params);
				
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
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月25日 上午10:15:12 
	* @parameter  params [ supplierId-供应商id(String)、brand-品牌(String)、waybillDate-下单日期(String)、scheduleDate-装运日期(String)、
	* 						scheduleBillNo-调度单号(String)、waybillStatus-运单状态(String)]  没有值的传''
	* 
	* @return	list [ supplierName-供应商、brand-品牌、model-车型、vin-车架号、waybillDate-下单日期、waybillNo-运单号、carNumber-装运车号、scheduleDate-装运日期、
	 * 					scheduleBillNo-调度单号、startAddress-出发地、targetProvince-目的省、targetCity-目的地、count-台数、distance-公里数、price-结算单价、
	 * 					balancePrice-结算运费、bargePrice-驳板费、farePrice-加价运费、otherDeduct-其他扣除、sumPrice-最终费用、waybillStatus-运单状态 ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("supplierId") String supplierId,
			@RequestParam("brand") String brand,
			@RequestParam("waybillDate") String waybillDate,
			@RequestParam("scheduleDate") String scheduleDate,
			@RequestParam("scheduleBillNo") String scheduleBillNo,
			@RequestParam("waybillStatus") String waybillStatus
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("supplierId", supplierId);
		params.put("brand", brand);
		params.put("waybillDate", waybillDate);
		params.put("scheduleDate", scheduleDate);
		params.put("scheduleBillNo", scheduleBillNo);
		params.put("waybillStatus", waybillStatus);
		
		//状态:1,2,3  类型 0,1
		params.put("statusIn", Constants.WaibillStatus.UNREVIEW.getValue() + "," + Constants.WaibillStatus.UNRECEIPT.getValue() + "," + Constants.WaibillStatus.FINISHED.getValue() );
		params.put("typeIn", Constants.WaybillType.SPC+ "," +Constants.WaybillType.ESC);
		
		Map<String, Object> formatData = incomeMngService.getExportData(params);

		String fileName = "收入管理Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
	/**
	 * 执行对账--暂时没用
	* @author  fengql 
	* @date 2016年11月4日 下午1:50:29 
	* @parameter  id-运单id(int) 必传
	* @return
	 */
	@RequestMapping(value = "/balance/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> balance(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "对账失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			incomeMngService.balance(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "对账失败："+e.getMessage());		
		}		
		return result;
	}
	
	
}
