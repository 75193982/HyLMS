package com.jshpsoft.test.controller.operationMng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarStockMangeService;
import com.jshpsoft.util.Constants;

public class CarStockMangeControllerTest {

	/**
	 * 获取新建状态运单
	* @author  fengql 
	* @date 2016年10月10日 下午4:25:29 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testqueryWaybill() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CarStockMangeService carStockMangeService = (CarStockMangeService) context.getBean("carStockMangeService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", Constants.WaibillStatus.NEW.getValue());
		params.put("delFlag", Constants.DelFlag.N);
		List<Waybill> list = carStockMangeService.getWaybillNo(params);
		System.out.println("QQQQQ"+ list.get(2).getWaybillNo());
		
	}
	
	
	
}
