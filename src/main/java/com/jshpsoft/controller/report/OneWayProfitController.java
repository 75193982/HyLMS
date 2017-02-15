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

import com.jshpsoft.domain.OneWayProfit;
import com.jshpsoft.service.OneWayProfitService;
import com.jshpsoft.util.POIUtil;

/**
 * 单程利润计算表
 * @author  ww 
 * @date 2017年1月9日 上午11:20:42
 */
@Controller
@RequestMapping("/reportMng/oneWayProfit")
public class OneWayProfitController {
	
	@Autowired  
	private OneWayProfitService oneWayProfitService;
	
	/**
	 * 单程利润表
	 * @author  ww 
	 * @date 2017年1月9日 下午12:54:43
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/oneWayProfit/index");		
		return mv;		
	}
	
	/**
	 * 单程利润表数据(供应商计算费用-承运商计算费用)
	 * @author  ww 
	 * @date 2017年1月9日 下午12:55:12
	 * @parameter  params{
	 * 		scheduleBillNo-调度单号、sendTimeStart-装运开始时间、sendTimeEnd-装运结束时间、carNumber-装运车号、driverName-驾驶员
	 * }
	 * @return list{
	 * 		[id-调度单id、scheduleBillNo-调度单号、sendTime-装运日期、carNumber-车号、driverName-驾驶员、amount-台数、receiveMoney-应收运费(供应商费用)、onWayMoney-在途费用(承运商费用)]
	 * }
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST)
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
			List<OneWayProfit> list = oneWayProfitService.getListData(params);
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
	 * 导出
	 * @author  ww 
	 * @date 2017年1月11日 上午10:06:57
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/exportData",method=RequestMethod.POST)
	@ResponseBody
	public void exportData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("scheduleBillNo") String scheduleBillNo,
			@RequestParam("sendTimeStart") String sendTimeStart,
			@RequestParam("sendTimeEnd") String sendTimeEnd,
			@RequestParam("carNumber") String carNumber,
			@RequestParam("driverName") String driverName
			) throws Exception {
		
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("scheduleBillNo", scheduleBillNo);
			params.put("sendTimeStart", sendTimeStart);
			params.put("sendTimeEnd", sendTimeEnd);
			params.put("carNumber", carNumber);
			params.put("driverName", driverName);
			
			Map<String, Object> formatData = oneWayProfitService.getExportData(params);
			
			String fileName = "单程利润计算表Excel";
			String fileExtend = "xls";
			POIUtil.exportToExcel(request, response, formatData, fileName,
					fileExtend);
	}

}
