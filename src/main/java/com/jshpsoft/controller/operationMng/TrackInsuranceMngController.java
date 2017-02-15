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

import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.domain.TrackInsurancePayLog;
import com.jshpsoft.service.TrackInsuranceMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 保费管理Controller
* @author  fengql 
* @date 2016年10月20日 下午1:07:19
 */
@Controller
@RequestMapping("/operationMng/trackInsuranceMng")
public class TrackInsuranceMngController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private TrackInsuranceMngService trackInsuranceMngService;
	
	/**
	 * 出险管理页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/reportIndex",method=RequestMethod.GET)		
	public ModelAndView reportIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackInsuranceMng/reportIndex");		
		return mv;		
	}

	/**
	 * 保费管理页面
	* @author  fengql 
	* @date 2016年10月9日 下午5:18:11 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackInsuranceMng/index");		
		return mv;		
	}

	/**
	 * 获取货运车号信息--用于查询条件、新增(参加保险)
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter  
	* @return	list [ no-车牌号、driverId-驾驶员id  ]
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
			params.put("type", "0");//车头
			List<Track> list = commonService.getTrackList(params);
			
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
	 * 获取保费列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ type-类型(String)、insuranceType、carNumber-货运车牌号(String)、insuranceBillNo-保单号(String,模糊查询)、status-状态(String)、
	* 						startInTime-插入开始时间(String)、endInTime-插入结束时间(String) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、type-类型、carNumber-货运车牌号、driverId-驾驶员id、insuranceBillNo-保单号、startTime-保险开始时间、endTime-保险结束时间、
	 * 								amount-总金额、balance-未支付金额(不显示)、status-状态 、noticeTime-提醒时间、mark-备注、insertTime-插入时间 、updateTime-更新时间  、
	 * 								reportTime-出险时间, surveyMobile-保险公司勘察员联系方式, materialCompleteFlag-材料是否齐全, materialMark-缺少材料备注
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
			Pager<TrackInsurance> pager = trackInsuranceMngService.getPageData(params);
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
	 * 获取保单信息--用于新增(报保险)
	 * @author  fengql 
	 * @date 2016年10月9日 下午2:36:12 
	 * @parameter  params [ carNumber-货运车牌号(String) ] 必传
	 * @return	bean [ carNumber-货运车牌号、driverId-驾驶员id 、insuranceBillNo-保单号、startTime-保险开始时间、endTime-保险结束时间 、reportTime-出险时间, surveyMobile-保险公司勘察员联系方式, materialCompleteFlag-材料是否齐全, materialMark-缺少材料备注]
	 */
	@RequestMapping(value = "/getInsuranceBean",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getInsuranceBean(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("status", Constants.InsuranceStatus.SUBMIT);//已提交
			TrackInsurance bean = trackInsuranceMngService.getInsuranceBean(params);
			
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
	 * 保存保费信息--是否有明细根据type确定：参加保险有，报保险没有
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ type-类型(String)、carNumber-货运车牌号(String)、driverId-驾驶员id(int)、insuranceBillNo-保单号(String)、startTime-保险开始时间(date)、
	* 					 endTime-保险结束时间(date)、amount-总金额(double)、noticeTime-提醒时间(double)、mark-备注 (String)、
	* 					 reportTime-出险时间, surveyMobile-保险公司勘察员联系方式, materialCompleteFlag-材料是否齐全, materialMark-缺少材料备注
	* 					insuranceCompany-保险公司     insuranceType
	* 
	 * 					  detailList [ insuranceName-险种名称(String)、amount-金额(double)、mark-备注(String) ]
	 * 				   ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackInsurance bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackInsuranceMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取保费详细信息-用于修改、查看;展示哪些路径、是否有明细根据type确认
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int)  必传
	* @return	  bean [ id-id号、type-类型、carNumber-货运车牌号、driverId-驾驶员id、insuranceBillNo-保单号、startTime-保险开始时间、endTime-保险结束时间、
	 * 					  amount-总金额、status-状态、noticeTime-提醒时间、mark-备注 、invoiceAttachPath-发票附件路径、insuranceBillPath-保单路径、
	 * 					  payLogPath-付款记录路径、accidentReportPath-事故认定书路径、insertUser插入人 、insertTime-插入时间 、
	 * 					  updateUser-更新人、updateTime-更新时间 、reportTime-出险时间, surveyMobile-保险公司勘察员联系方式, materialCompleteFlag-材料是否齐全, materialMark-缺少材料备注
	 * 						insuranceCompany-保险公司     insuranceType
	 * 					  detailList [ insuranceName-险种名称、amount-金额、mark-备注 ]
	 * 					  insurancePayLogList{[id,insuranceNo-保单号,amount-支付金额,mark-备注,insertTime-支付时间,insertUser-支付人]}
	 * 				   ]
	 */
	@RequestMapping(value = "/getDetail/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			TrackInsurance bean = trackInsuranceMngService.getById(id);
			
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
	 * 修改保费信息--是否有明细根据type确定：参加保险有，报保险没有
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ id-id号(int)、type-类型(String)、carNumber-货运车牌号(String)、driverId-驾驶员id(int)、insuranceBillNo-保单号(String)、startTime-保险开始时间(date)、
	* 					  endTime-保险结束时间(date)、amount-总金额(double)、noticeTime-提醒时间(double)、mark-备注 (String)
	* 						insuranceCompany-保险公司     insuranceType
	 * 					  detailList [ insuranceName-险种名称(String)、amount-金额(double)、mark-备注(String)、reportTime-出险时间, surveyMobile-保险公司勘察员联系方式, materialCompleteFlag-材料是否齐全, materialMark-缺少材料备注 ]
	 * 				   ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackInsurance bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackInsuranceMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 修改所有的扫描件上传地址--没有的传''
	* @author  fengql 
	* @date 2016年10月19日 下午3:42:50 
	* @parameter  params[ id号(int)、invoiceAttachPath-发票附件路径(String)、insuranceBillPath-保单路径(String)、
	 * 					  payLogPath-付款记录路径(String)、accidentReportPath-事故认定书路径(String) ]
	* @return
	 */
	@RequestMapping(value = "/updateFilePath",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> updateFilePath(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackInsurance bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "更新失败");
		
		try{
			trackInsuranceMngService.updateFilePath(bean,request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "更新失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除保费信息--更新逻辑删除键标志
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
			trackInsuranceMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 提交保费
	* @author  fengql 
	* @date 2016年10月20日 下午3:31:04 
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
			trackInsuranceMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 支付参加保险费用
	* @author  fengql 
	* @date 2016年10月20日 下午4:36:41 
	* @parameter  bean [ amount-金额(double)、mark-备注(String) ]
	* @return
	 */
	@RequestMapping(value = "/payInsurance",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> payInsurance(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackInsurancePayLog bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "支付失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			bean.setType(Constants.InsurancePayType.OUT);//支付参加保险费用
			
			trackInsuranceMngService.savePayLog(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "支付失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 报保险的索赔费用
	* @author  fengql 
	* @date 2016年10月20日 下午4:40:09 
	* @parameter  bean [ insuranceId-保险表id(int)、insuranceNo-保单号(String)、amount-金额(double)、mark-备注(String) ]
	* @return
	 */
	@RequestMapping(value = "/claimPay",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> claimPay(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackInsurancePayLog bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "索赔失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			bean.setType(Constants.InsurancePayType.IN);//报保险的赔付费用
			
			trackInsuranceMngService.savePayLog(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "索赔失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 打印数据查询
	* @author  fengql 
	* @date 2016年10月21日 下午3:46:36 
	* @parameter  params [ insuranceType-类型(String)、carNumber-货运车牌号(String)、insuranceBillNo-保单号(String,模糊查询)、
	* 					   startInTime-插入开始时间(String)、endInTime-插入结束时间(String)  ]  没有值的传''
	* 
	* @return	list [ id-id号、type-类型、carNumber-货运车牌号、driverId-驾驶员id、insuranceBillNo-保单号、startTime-保险开始时间、endTime-保险结束时间、
	* 					amount-总金额、status-状态 、noticeTime-提醒时间、mark-备注、insertTime-插入时间、insertUser-插入人、updateTime-更新时间  、updateUser-更新人、
	* 					reportTime-出险时间, surveyMobile-保险公司勘察员联系方式, materialCompleteFlag-材料是否齐全, materialMark-缺少材料备注
	*   			 ]
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
			List<TrackInsurance> list = trackInsuranceMngService.getPrintData(params);
				
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
	 * 导出数据-财务部
	* @author  fengql 
	* @date 2016年10月19日 下午1:12:25 
	* @parameter  params [ insuranceType-类型(String)、carNumber-货运车牌号(String)、insuranceBillNo-保单号(String,模糊查询)、
	* 					   startInTime-插入开始时间(String)、endInTime-插入结束时间(String)  ]  没有值的传''
	* 					 
	* @return	list [ type-类型、carNumber-货运车牌号、driverId-驾驶员id、insuranceBillNo-保单号、startTime-保险开始时间、endTime-保险结束时间、amount-总金额、
	* 					status-状态 、noticeTime-提醒时间、mark-备注、insertTime-插入时间、insertUser-插入人、updateTime-更新时间  、updateUser-更新人、
	* 					reportTime-出险时间, surveyMobile-保险公司勘察员联系方式, materialCompleteFlag-材料是否齐全, materialMark-缺少材料备注
	*   			 ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("insuranceType") String insuranceType,
			@RequestParam("carNumber") String carNumber,
			@RequestParam("insuranceBillNo") String insuranceBillNo,
			@RequestParam("startInTime") String startInTime,
			@RequestParam("endInTime") String endInTime
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("insuranceType", insuranceType);
		params.put("carNumber", carNumber);
		params.put("insuranceBillNo", insuranceBillNo);
		params.put("startInTime", startInTime);
		params.put("endInTime", endInTime);
		
		Map<String, Object> formatData = trackInsuranceMngService.getExportData(params);

		String fileName = "货运车保费Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
	/**
	 * 保费支付查询页面
	* @author  fengql 
	* @date 2016年10月9日 下午5:18:11 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/payLog",method=RequestMethod.GET)		
	public ModelAndView payLog(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackInsuranceMng/payLog");		
		return mv;		
	}
	
	/**
	 * 获取保费支付列表数据  类型(0,1)
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ type-类型(下拉有两个选项0、1，若都不选则传'0,1',String)、startInTime-插入开始时间(String)、endInTime-插入结束时间(String)
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、insuranceNo-保单号、amount-金额、mark-备注、insertUser-插入人 、insertTime-插入时间  ]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getPayListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getPayListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<TrackInsurancePayLog> pager = trackInsuranceMngService.getPayPageData(params);
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
	 * 查看保费支付记录对应的明细  类型(2)
	* @author  fengql 
	* @date 2016年10月20日 下午4:49:28 
	* @parameter  id-id号(父类id)(int) 必传
	* @return	list [ id-id号、insuranceNo-保单号、amount-金额、mark-备注、insertUser-插入人 、insertTime-插入时间 ]
	 */
	@RequestMapping(value = "/getPayDetailList/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getPayDetailList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<TrackInsurancePayLog> list = trackInsuranceMngService.getPayDetailList(id);
			
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
	 * 支付接口
	 * @author  ww 
	 * @date 2016年12月9日 上午9:38:34
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/zhiFu/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> zhiFu(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackInsuranceMngService.zhiFu(id,oper);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
}
