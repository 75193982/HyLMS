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

import com.jshpsoft.domain.OtherContacts;
import com.jshpsoft.domain.OtherContactsLog;
import com.jshpsoft.service.OtherContactsService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 其他应付款Controller
* @author  fengql 
* @date 2017年1月9日 下午3:19:34
 */
@Controller
@RequestMapping("/reportMng/payableContacts")
public class PayableContactsController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private OtherContactsService otherContactsService;
	
	/**
	 * 其他应付款主页面
	* @author  fengql 
	* @date 2017年1月9日 下午3:21:17 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/payableContacts/index");
		return mv;		
	}
	
	/**
	 * 获取其他应付款列表
	* @author  fengql 
	* @date 2017年1月9日 下午3:25:17 
	* @parameter  params [ operTimeStart-借入开始日期(String)、operTimeEnd-借入结束日期(String)、operUser-经办人(模糊查询)、name-事由(模糊查询)、status-状态(String)    没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、operateUser-经办人、name-摘要、operateTime-借入时间、(startTime-endTime)-借款期限、noticeTime-提醒时间、amount-借入金额、ratio%-借款利息、
	 * 								totalAmount-本息合计、decreaseAmount-借款核减金额、decreaseTime-核减时间、actualAmount-实际应付、status-状态、mark-备注 ]
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
			params.put("type", Constants.OtherContactsType.OUT);//支出--应付款
			Pager<OtherContacts> pager = otherContactsService.getPageData(params);
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
	 * 获取其他应付款列表--打印
	 * @author  fengql 
	 * @date 2017年1月9日 下午3:25:17 
	 * @parameter  params [ operTimeStart-借入开始日期、operTimeEnd-借入结束日期、operUser-经办人(模糊查询)、name-事由(模糊查询)、status-状态(String)   没有值传''
	 * 					 ]
	 * 
	 * @return	list[ operateUser-经办人、name-摘要、operateTime-借入时间、(startTime-endTime)-借款期限、noticeTime-提醒时间、amount-借入金额、ratio%-借款利息、
	 * 					totalAmount-本息合计、decreaseAmount-借款核减金额、decreaseTime-核减时间、actualAmount-实际应付、status-状态、mark-备注]
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
			params.put("type", Constants.OtherContactsType.OUT);//支出--应付款
			List<OtherContacts> list = otherContactsService.getPrintData(params);
			
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
	 * 导出其他应付款列表
	 * @author  fengql 
	 * @date 2017年1月9日 下午3:25:17 
	 * @parameter  params [ operTimeStart-借入开始日期、operTimeEnd-借入结束日期、operUser-经办人(模糊查询)、name-事由(模糊查询)、status-状态(String)   没有值传''
	 * 					 ]
	 * 
	 * @return	list[ operateUser-经办人、name-摘要、operateTime-借入时间、(startTime-endTime)-借款期限、noticeTime-提醒时间、amount-借入金额、ratio%-借款利息、
	 * 				  	totalAmount-本息合计、decreaseAmount-借款核减金额、decreaseTime-核减时间、actualAmount-实际应付、status-状态、mark-备注]
	 */
	@RequestMapping(value = "/getExportData", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void getExportData(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("operTimeStart") String operTimeStart,
			@RequestParam("operTimeEnd") String operTimeEnd,
			@RequestParam("operUser") String operUser,
			@RequestParam("name") String name,
			@RequestParam("status") String status
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("operTimeStart", operTimeStart);
		params.put("operTimeEnd", operTimeEnd);
		params.put("operUser", operUser);
		params.put("name", name);
		params.put("status", status);
		
		params.put("type", Constants.OtherContactsType.OUT);//支出--应付款
		
		Map<String, Object> formatData = otherContactsService.getPayExportData(params);

		String fileName = "其他应付款Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}

	/**
	 * 保存或修改保存其他往来款信息
	* @author  fengql 
	* @date 2017年1月10日 下午1:36:34 
	* @parameter  bean [ id-id号(新增时不传)、operateUser-经办人、name-摘要、operateTime-借入时间、startTime-借款开始时间、endTime-借款结束时间、noticeTime-提醒时间、
	* 					amount-借入金额、ratio%-借款利息、totalAmount-本息合计、decreaseAmount-借款核减金额、decreaseTime-核减时间、
	* 					(totalAmount-decreaseAmount)actualAmount-实际应付、attachFilePath-附件路径、mark-备注 ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody OtherContacts bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			
			bean.setType(Constants.OtherContactsType.OUT);//支出--应付款
			otherContactsService.save(bean, oper, request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 获取往来款详细信息--用于修改、查看
	* @author  fengql 
	* @date 2017年1月10日 下午1:46:57 
	* @parameter   id-id号(int)  必传
	* @return   bean [ id-id号、operateUser-经办人、name-摘要、operateTime-借入时间、startTime-借款开始时间、endTime-借款结束时间、noticeTime-提醒时间、
	* 					amount-借入金额、ratio%-借款利息、totalAmount-本息合计、decreaseAmount-借款核减金额、decreaseTime-核减时间、
	* 					(totalAmount-decreaseAmount)actualAmount-实际应付、attachFilePath-附件路径、mark-备注 ]
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
			OtherContacts bean = otherContactsService.getById(id);
			
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
	 * 删除往来款信息--更新删除逻辑标志
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
			otherContactsService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 提交往来款信息
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
			otherContactsService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存应付款的核销记录
	* @author  fengql 
	* @date 2017年1月10日 下午1:36:34 
	* @parameter  bean [ otherContactId-应付款id、amount-金额、operateTime-核销时间、mark-备注 ]
	* @return
	 */
	@RequestMapping(value = "/saveLog",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> saveLog(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody OtherContactsLog bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			otherContactsService.saveLog(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取应付款的核销记录
	 * @author  fengql 
	 * @date 2017年1月10日 下午1:36:34 
	 * @parameter  otherContactId-应付款id
	 * @return		list [ amount-金额、operateTime-核销时间、mark-备注 ]
	 */
	@RequestMapping(value = "/getLogList/{otherContactId}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getLogList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer otherContactId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<OtherContactsLog> list = otherContactsService.getLogById(otherContactId);
			
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
	 * 其他应付款报表页面
	* @author  fengql 
	* @date 2017年1月11日 上午10:19:33 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/reportIndex",method=RequestMethod.GET)		
	public ModelAndView reportIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/payableContacts/reportIndex");
		return mv;		
	}
	
	
	/**
	 * 获取其他应付款报表
	* @author  fengql 
	* @date 2017年1月9日 下午3:25:17 
	* @parameter  params [ operateTime-借入日期(默认为当前月) 没有值传'' ]   
	* 
	* @return	list[ operateUser-经办人、name-摘要、totalAmount-借入总金额、decreaseAmount-核销总金额、actualAmount-余额  ]
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
			params.put("type", Constants.OtherContactsType.OUT);//支出-应付款
			params.put("statusIn", Constants.OtherContactsStatus.SUBMIT + "," + Constants.OtherContactsStatus.FINISH);
			List<OtherContacts> list = otherContactsService.getReportData(params);
			
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
	 * 导出其他应收款报表
	 * @author  fengql 
	 * @date 2017年1月9日 下午3:25:17 
	 * @parameter  params [ operateTime-借入日期(默认为当前月) 没有值传'' ]
	 * 
	 * @return	list[ operateUser-经办人、name-摘要、totalAmount-借入总金额、decreaseAmount-核销总金额、actualAmount-余额  ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("operateTime") String operateTime
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("operateTime", operateTime);
		params.put("type", Constants.OtherContactsType.OUT);//支出-应付款
		params.put("statusIn", Constants.OtherContactsStatus.SUBMIT + "," + Constants.OtherContactsStatus.FINISH);
		
		Map<String, Object> formatData = otherContactsService.getPayExportReport(params);

		String fileName = "其他应付款Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
}
