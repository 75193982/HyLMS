package com.jshpsoft.controller.basicSetting;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.service.StockService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;

/**
 * 全局配置管理Controller
 * @author  army.liu 
 */
@Controller
@RequestMapping("/basicSetting/configMng")
public class ConfigMngController {
	
	@Autowired  
	private StockService stockService;
	
	@Autowired  
	private CommonService commonService;
	
	/**
	 * 全局配置页面
	 * @author  army.liu 
	 * @parameter  
	 * @return{
	 * 		fastScheduleUseProcess-快速调度是否使用流程，Y-使用，N-不使用
	 * }
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/configMng/index");		
		
		//获取当前的快速调度配置信息
		try {
			String configValue = commonService.getConfigValue(0, Constants.BasicConfigName.FAST_SCHEDULE_USE_PROCESS);
			mv.addObject("fastScheduleUseProcess", configValue);
			
			String distance = commonService.getConfigValue(0, Constants.BasicConfigName.DRIVER_SALARY_DISTANCE_LIMIT);
			mv.addObject("distance", distance);
			
			String price = commonService.getConfigValue(0, Constants.BasicConfigName.DRIVER_SALARY_DISTANCE_PRICE);
			mv.addObject("price", price);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mv;		
	}

	/**
	 * 保存配置信息
	 * @author  army.liu 
	 * @parameter  {
	 * 		fastScheduleUseProcess-快速调度是否使用流程，Y-使用，N-不使用
	 * }
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, String>params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String fastScheduleUseProcess = params.get("fastScheduleUseProcess");
			if( StringUtils.isEmpty(fastScheduleUseProcess) ){
				result.put("msg", "fastScheduleUseProcess参数不能为空");	
				return result;
			}
			int oper = CommonUtil.getUserIdFromSession(request);
			commonService.setConfigValue(Constants.BasicConfigName.FAST_SCHEDULE_USE_PROCESS, fastScheduleUseProcess.trim(), oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存驾驶员的里程补贴配置信息
	 * @author  army.liu 
	 * @parameter  {
	 * 		distance-补贴公里数
	 * 		price-每公里补贴数
	 * }
	 * @return
	 */
	@RequestMapping(value = "/saveForDriverDistance",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> saveForDriverDistance(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, String>params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String distance = params.get("distance");
			if( StringUtils.isEmpty(distance) ){
				result.put("msg", "distance参数不能为空");	
				return result;
			}
			String price = params.get("price");
			if( StringUtils.isEmpty(price) ){
				result.put("msg", "price参数不能为空");	
				return result;
			}
			int oper = CommonUtil.getUserIdFromSession(request);
			commonService.setConfigValue(Constants.BasicConfigName.DRIVER_SALARY_DISTANCE_LIMIT, distance.trim(), oper);
			commonService.setConfigValue(Constants.BasicConfigName.DRIVER_SALARY_DISTANCE_PRICE, price.trim(), oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
}
