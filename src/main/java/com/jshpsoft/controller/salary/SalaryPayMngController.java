package com.jshpsoft.controller.salary;

import java.io.IOException;
import java.util.Date;
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

import com.jshpsoft.domain.SalaryPay;
import com.jshpsoft.domain.SalaryPayDetail;
import com.jshpsoft.service.SalaryPayService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;

/**
 * 工资管理Controller
 * @author  army.liu 
 */
@Controller
@RequestMapping("/financeManage/salaryPay")
public class SalaryPayMngController {
	
	@Autowired
	private SalaryPayService salaryPayService;
	
	@Autowired
	private CommonService commonService;
	
	/**
	 * 工资发放管理页面-所有人员
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("financeManage/salaryPay/index");
		
		mv.addObject("driverFlag", "N");
		return mv;		
	}
	
	/**
	 * 工资发放管理页面-驾驶员工资
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/indexForDriver",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("financeManage/salaryPay/indexForDriver");		
		
		mv.addObject("driverFlag", "Y");
		return mv;		
	}

//	/**
//	 * 获取工资发放记录列表数据
//	 * @author  army.liu 
//	 * @parameter
//	 * {
//	 * 		pageStartIndex -页开始索引
//	 * 		pageSize -页大小
//	 * 		sEcho -前台带过来的参数，不动返回回去的
//	 * 
//	 * 		name -名称
//	 * }
//	 * 
//	 * @return	
//	 * {
//	 * 		code 
//	 * 		msg
//	 * 		data : {
//	 * 					records:[
//	 * 								id-id号、salaryTime-工资归属时间、userCount-人数、amount-发放总金额、status-状态：0-新建，1-已发放、insert_time-插入时间、insert_user-插入人 
//	 * 								insertUserName-插入人名称、updateUserName-更新人名称、driverFlag-驾驶员工资发放标记
//	 * 							]
//	 * 					totalCounts -总记录数
//	 * 					totalPages -总页数
//	 * 					pageSize -页大小
//	 * 					frontParams -前台带过来的参数，不动返回回去的
//	 * 				}
//	 * }  
//	 */
//	@RequestMapping(value = "/getListData",method=RequestMethod.POST, headers={"Content-Type=application/json"})
//	@ResponseBody
//	public Map<String, Object> getListData(HttpServletRequest request, 
//			HttpServletResponse response,
//			HttpSession session,
//			@RequestBody Map<String, Object> params
//			) throws Exception {
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("code", "300");
//		result.put("msg", "获取失败");
//		
//		try{
//			Pager<SalaryPay> pager = salaryPayService.getPageData(params);
//			pager.setFrontParams(params.get("sEcho"));
//			
//			result.put("data", pager);
//			result.put("code", "200");
//			result.put("msg", "成功");
//			
//		}catch(Exception e){
//			e.printStackTrace();
//			result.put("msg", "获取失败："+e.getMessage());		
//		}		
//		return result;
//	}
	/**
	 * 获取工资发放记录列表数据
	 * @author  army.liu 
	 * @parameter
	 * {
	 * 		salaryTime-工资归属时间：格式yyyy-MM
	 * 		mark- 备注
	 * 		driverFlag-驾驶员工资标记：Y-驾驶员的工资发放，N-所有人员的工资发放
	 * }
	 * 
	 * @return	
	 * {
	 * 		code 
	 * 		msg
	 * 		data : [
	 * 					id-id号、salaryTime-工资归属时间：格式yyyy-MM、userCount-人数、amount-发放总金额、status-状态：0-新建，1-已发放、insert_time-插入时间、insert_user-插入人 
	 * 					insertUserName-插入人名称、updateUserName-更新人名称、driverFlag-驾驶员工资发放标记
 	 * 					detailList:[ ---工资发放详细信息
	 * 						id-id号、userId-用户id、departmentId-部门id、departmentName-部门名称、userName-用户名称、dutyName-岗位名称、
	 * 						salaryTime-工资归属时间、workDays-出勤天数、leaveDays-请假天数、basicSalary-基本工资、allowanceDistance-里程数、allowanceAmount-补助合计、fineAmount-罚扣合计、amount-应发合计
//	 * 						allowanceList:[ ---工资发放详细对应的补助信息 
//	 * 							salaryPayDetailId-工资发放详细id、type-类型：0-补助，1-罚扣、name-名称、amount-金额、mark-备注
//	 * 						]
	 * 					]
	 * 			   ]
	 * }  
	 */
	@RequestMapping(value = "/getAllListData",method=RequestMethod.POST, headers={"Content-Type=application/json"})
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
			params.put( "delFlag", Constants.DelFlag.N );
			List<SalaryPay> list = salaryPayService.getAllListData(params);
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
	 * 工资发放新增页面
	 * @author  army.liu 
	 * @parameter  
	 * @return{
	 * 		salaryTime-默认上个月：yyyy-MM
	 * }
	 */
	@RequestMapping(value = "/new/{id}/{driverFlag}",method=RequestMethod.GET)		
	public ModelAndView newPage(HttpServletRequest request, HttpServletResponse response,HttpSession session,
			@PathVariable int id,
			@PathVariable String driverFlag
			) throws Exception {
		ModelAndView mv = new ModelAndView("financeManage/salaryPay/new");	
		
		//默认上个月：yyyy-MM
		mv.addObject("salaryTime",  CommonUtil.format(CommonUtil.getLastYearMonthTime(new Date()), Constants.DATE_TIME_FORMAT_CUSTOM_5) );
		
		mv.addObject("id",id);
		
		mv.addObject("driverFlag", driverFlag);
		
		//获取配置信息：里程下限和单价
		String distance = commonService.getConfigValue(0, Constants.BasicConfigName.DRIVER_SALARY_DISTANCE_LIMIT);
		String price = commonService.getConfigValue(0, Constants.BasicConfigName.DRIVER_SALARY_DISTANCE_PRICE);
		mv.addObject("distance", distance);
		mv.addObject("price", price);
		
		return mv;		
	}
	
	/**
	 * 获取工资发放的新建模板信息
	 * @author  army.liu 
	 * @parameter
	 * {
	 *   	salaryTime-工资归属月份:yyyy-MM
	 * 		driverFlag-驾驶员工资标记：Y-驾驶员的工资发放，N-所有人员的工资发放
	 * }
	 * @return
 	 * {
 	 * 		code
 	 * 		data:[
	 * 			id-id号、userId-用户id、departmentId-部门id、departmentName-部门名称、userName-用户名称、dutyName-岗位名称、
	 * 			salaryTime-工资归属时间、workDays-出勤天数、leaveDays-请假天数、basicSalary-基本工资、allowanceDistance-里程数、allowanceAmount-补助合计、fineAmount-罚扣合计、amount-应发合计
	 * 		]
	 * }
	 */
	@RequestMapping(value = "/getTemplateData/{driverFlag}/{salaryTime}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetailData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String salaryTime,
			@PathVariable String driverFlag
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<SalaryPayDetail> list = salaryPayService.getTemplateData(driverFlag,salaryTime);
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
	 * 保存工资发放信息
	 * @author  army.liu 
	 * @parameter 
 	 * {
 	 * 		id-id号、salaryTime-工资归属时间：格式yyyy-MM、mark-备注
 	 * 		saveFlag-保存标记：Y-保存，N-发放
 	 * 		driverFlag-驾驶员的工资标记:Y-驾驶员，N-所有人
 	 * 
 	 * 		detailList:[ ---工资发放详细信息
	 * 			id-id号、userId-用户id、departmentId-部门id、departmentName-部门名称、userName-用户名称、dutyName-岗位名称、
	 * 			salaryTime-工资归属时间、workDays-出勤天数、leaveDays-请假天数、basicSalary-基本工资、allowanceDistance-里程数、allowanceAmount-补助合计、fineAmount-罚扣合计、
	 * 		]
 	 * }
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody SalaryPay bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			//保存
			int operId = CommonUtil.getUserIdFromSession(request);
			salaryPayService.save(bean, operId+"");
			
			//发放
			if( "N".equals( bean.getSaveFlag() ) ){
				salaryPayService.pay(bean.getId(), operId+"");
			}
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取工资发放的详细信息
	 * @author  army.liu 
	 * @parameter
	 * {
	 *   	id-id号
	 * }
	 * @return
 	 * {
 	 * 		id-id号、salaryTime-工资归属时间、userCount-人数、amount-发放总金额、status-状态：0-新建，1-已发放、mark-备注、driverFlag-驾驶员工资发放标记
 	 * 		detailList:[
	 * 			id-id号、userId-用户id、departmentId-部门id、departmentName-部门名称、userName-用户名称、dutyName-岗位名称、
	 * 			salaryTime-工资归属时间、workDays-出勤天数、leaveDays-请假天数、basicSalary-基本工资、allowanceDistance-里程数、allowanceAmount-补助合计、fineAmount-罚扣合计、amount-应发合计
	 * 		]
	 * }
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
			
			SalaryPay bean = salaryPayService.getByDetailInfo(id);
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
	 * 删除工资发放信息
	 * @author  army.liu 
	 * @parameter
	 * {
	 *   id-id号
	 * }
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
			int operId = CommonUtil.getUserIdFromSession(request);
			salaryPayService.delete(id, operId+"");
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 工资发放操作页面-导出汇总
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		salaryTime-工资归属时间：格式yyyy-MM
 	 * 		driverFlag-驾驶员的工资标记:Y-驾驶员，N-所有人
	 * }
	 * @return 
	 */
	@RequestMapping(value = "/exportTotal", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> exportCarShopTransport(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam String salaryTime,
			@RequestParam String driverFlag
			) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("salaryTime", salaryTime);
			params.put("driverFlag", driverFlag);
			params.put( "delFlag", Constants.DelFlag.N );
			Map<String, Object> formatData = salaryPayService.getAllListDataForExportData(params);
			String fileName = "工资发放汇总";
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
	 * 工资发放操作页面-导出某个工资发放的明细信息
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		id-工资发放id
	 * }
	 * @return 
	 */
	@RequestMapping(value = "/exportDetail", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> exportDetail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam Integer id
			) throws Exception{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try {
			Map<String, Object> formatData = salaryPayService.getByDetailInfoForExportData(id);
			String fileName = "工资发放明细";
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
	
	//------------------------------------------------------------------------------------个人的工资发放记录查询----------------------------------------------------------------------------------------------
	/**
	 * 个人工资发放记录查询页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/indexForPersonQuery",method=RequestMethod.GET)		
	public ModelAndView indexForPersonQuery(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("financeManage/salaryPay/indexForPersonQuery");		
		return mv;		
	}
	
	/**
	 * 获取个人的工资发放记录
	 * @author  army.liu 
	 * @parameter
	 * {
	 *   	userId-用户id
	 * }
	 * @return
 	 * {
 	 * 		code
 	 * 		data:[
	 * 			id-id号、userId-用户id、departmentId-部门id、departmentName-部门名称、userName-用户名称、dutyName-岗位名称、
	 * 			salaryTime-工资归属时间、workDays-出勤天数、leaveDays-请假天数、basicSalary-基本工资、allowanceAmount-补助合计、fineAmount-罚扣合计、amount-应发合计
	 * 		]
	 * }
	 */
	@RequestMapping(value = "/getLogs/{userId}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getLogs(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable String userId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("userId", userId);
			params.put("delFlag", Constants.DelFlag.N);
			params.put("status", Constants.SalaryPayStatus.PAY);//已发放
			List<SalaryPayDetail> list = salaryPayService.getDetailInfoForConditions(params);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		
		return result;
	}
	
	//------------------------------------------------------------------------------------查询系统中的工资发放查询----------------------------------------------------------------------------------------------
	/**
	 * 工资发放查询页面-驾驶员工资
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/indexForDriverQuery",method=RequestMethod.GET)		
	public ModelAndView indexForDriverQuery(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("financeManage/salaryPay/indexForDriverQuery");		
		return mv;		
	}
	
	/**
	 * 工资发放查询页面-所有人员
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/indexForQuery",method=RequestMethod.GET)		
	public ModelAndView indexForQuery(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("financeManage/salaryPay/indexForQuery");		
		return mv;		
	}
	
//	/**
//	 * 获取工资发放记录列表数据
//	 * @author  army.liu 
//	 * @parameter
//	 * {
//	 * 		salaryTime-工资归属时间：格式yyyy-MM
//	 * }
//	 * 
//	 * @return	
//	 * {
//	 * 		code 
//	 * 		msg
//	 * 		data : [
//	 * 					id-id号、salaryTime-工资归属时间：格式yyyy-MM、userCount-人数、amount-发放总金额、status-状态：0-新建，1-已发放、insert_time-插入时间、insert_user-插入人 
//	 * 					insertUserName-插入人名称、updateUserName-更新人名称
// 	 * 					detailList:[ ---工资发放详细信息
//	 * 						id-id号、userId-用户id、departmentId-部门id、departmentName-部门名称、userName-用户名称、dutyName-岗位名称、
//	 * 						salaryTime-工资归属时间、workDays-出勤天数、leaveDays-请假天数、basicSalary-基本工资、allowanceAmount-补助合计、fineAmount-罚扣合计、amount-应发合计
//	 * 			   ]
//	 * }  
//	 */
//	@RequestMapping(value = "/getAllListDataForQuery",method=RequestMethod.POST, headers={"Content-Type=application/json"})
//	@ResponseBody
//	public Map<String, Object> getAllListDataForQuery(HttpServletRequest request, 
//			HttpServletResponse response,
//			HttpSession session,
//			@RequestBody Map<String, Object> params
//			) throws Exception {
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("code", "300");
//		result.put("msg", "获取失败");
//		
//		try{
//			params.put( "delFlag", Constants.DelFlag.N );
//			params.put( "status", Constants.SalaryPayStatus.PAY);
//			List<SalaryPay> list = salaryPayService.getAllListData(params);
//			result.put("data", list);
//			result.put("code", "200");
//			result.put("msg", "成功");
//			
//		}catch(Exception e){
//			e.printStackTrace();
//			result.put("msg", "获取失败："+e.getMessage());		
//		}		
//		return result;
//	}
	
}
