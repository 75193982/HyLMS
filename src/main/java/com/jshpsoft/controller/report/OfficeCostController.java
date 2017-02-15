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

import com.jshpsoft.domain.CostApply;
import com.jshpsoft.service.OfficeCostService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;

/**
 * 办公费用报表
* @author  fengql 
* @date 2017年1月13日 上午10:56:25
 */
@Controller
@RequestMapping("/reportMng/officeCost")
public class OfficeCostController {
	
	@Autowired  
	private OfficeCostService officeCostService;
	
	/**
	 * 办公费用报表页面
	* @author  fengql 
	* @date 2017年1月13日 上午10:56:45 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/OfficeCost/index");
		return mv;		
	}
	
	/**
	 * 获取办公费用报表
	* @author  fengql 
	* @date 2017年1月13日 上午10:59:45 
	* @parameter  params [ applyDate-月份(默认为当前月,必传)]   
	* 
	* @return	list[ typeName-归集项目、departmentName-归属部门、amount-本月金额、sumAmount-累计金额   ]
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
			params.put("costStatus", Constants.CostApplyForOfficeStatus.FINISH + "," +Constants.CostApplyForOfficeStatus.HEXIAO);//5,6
			params.put("costReStatus", Constants.CostApplyReturnForOfficeStatus.FINISH);//5
			List<CostApply> list = officeCostService.getReportData(params);
			
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
	 * 导出办公费用报表
	 * @author  fengql 
	 * @date 2017年1月13日 上午11:29:45 
	 * @parameter  params [ applyDate-月份(默认为当前月,必传)] 
	 * 
	 * @return	list[ typeName-归集项目、departmentName-归属部门、amount-本月金额、sumAmount-累计金额   ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("applyDate") String applyDate
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("applyDate", applyDate);
		params.put("costStatus", Constants.CostApplyForOfficeStatus.FINISH + "," +Constants.CostApplyForOfficeStatus.HEXIAO);//5,6
		params.put("costReStatus", Constants.CostApplyReturnForOfficeStatus.FINISH);//5
		
		Map<String, Object> formatData = officeCostService.getExportReport(params);

		String fileName = "办公费用报表Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
}
