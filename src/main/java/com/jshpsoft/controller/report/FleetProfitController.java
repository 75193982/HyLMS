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

import com.jshpsoft.domain.FleetProfitYM;
import com.jshpsoft.service.FleetProfitService;
import com.jshpsoft.util.POIUtil;

/**
 * 车队利润表
 * @author  ww 
 * @date 2017年1月11日 上午10:50:32
 */
@Controller
@RequestMapping("/reportMng/fleetProfit")
public class FleetProfitController {
	
	@Autowired  
	private FleetProfitService fleetProfitService;
	
	/**
	 * 主页面
	 * @author  ww 
	 * @date 2017年1月11日 下午12:35:40
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("reportMng/fleetProfit/index");		
		return mv;		
	}
	
	/**
	 * 获取数据
	 * @author  ww 
	 * @date 2017年1月11日 下午12:38:23
	 * @parameter  params{sendTime-装运时间}
	 * @return bean
	 * 		[
	 * 		monthProfit
	 * 			[
	 * 				 车队运费总收入:	incomeSum-车队运费总收入、carIncome-主营收入（商品车）、shCarIncome-二手车及其他、insuranceIncome-保险赔款
	 * 				 车队运费成本 ：  costSum-车队运费成本、driverCost-驾驶员报销、lukatong-鲁卡通、insuranceCost-保险分摊、carRepairCost-大车维修包月费、
	 * 				driverPay-驾驶员工资、officePay-车队办公人员工资、tireCost-轮胎费用、FleetCost-车队费用、rentCost-场地租金、
	 * 				trailerCost-挂车年审、erWeiCost-二维、oilCardCost-油卡折现成本
	 * 			]
	 * 		yearProfit
	 * 			[
	 * 				车队运费总收入:incomeSum-车队运费总收入、carIncome-主营收入（商品车）、shCarIncome-二手车及其他、insuranceIncome-保险赔款
	 * 				 车队运费成本 ：  costSum-车队运费成本、driverCost-驾驶员报销、lukatong-鲁卡通、insuranceCost-保险分摊、carRepairCost-大车维修包月费、
	 * 				driverPay-驾驶员工资、officePay-车队办公人员工资、tireCost-轮胎费用、FleetCost-车队费用、rentCost-场地租金、
	 * 				trailerCost-挂车年审、erWeiCost-二维、oilCardCost-油卡折现成本
	 * 			]
	 * 		]
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
			List<FleetProfitYM> list = fleetProfitService.getListData(params);
			/*FleetProfitYM ym = new FleetProfitYM();
			FleetProfit fp = new FleetProfit();
			fp.setCarIncome(100);
			ym.setMonthProfit(fp);*/
			result.put("data", list.get(0));
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
	 * @date 2017年1月11日 下午12:41:59
	 * @parameter  params{sendTime-装运时间}
	 * @return
	 */
	@RequestMapping(value = "/exportData",method=RequestMethod.POST)
	@ResponseBody
	public void exportData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("sendTime") String sendTime
			) throws Exception {
		
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("sendTime", sendTime);
			
			Map<String, Object> formatData = fleetProfitService.getExportData(params);
			
			String fileName = "车队利润表Excel";
			String fileExtend = "xls";
			POIUtil.exportToExcel(request, response, formatData, fileName,
					fileExtend);
	}

}
