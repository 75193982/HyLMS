package com.jshpsoft.test.controller.operationMng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.service.IncomeMngService;
import com.jshpsoft.util.Constants;

/**
 * 收入管理测试
* @author  fengql 
* @date 2016年10月28日 下午2:40:05
 */
public class IncomeMngControllerTest_old {

	@SuppressWarnings("resource")
	@Test
	public void testgetListData() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		IncomeMngService incomeMngService = (IncomeMngService) context.getBean("incomeMngService");
		
		//状态:2,3,4
		Map<String, Object> params = new HashMap<String, Object>();
		params.put( "statusIn", Constants.WaibillStatus.UNRECEIPT.getValue() + "," + 
					Constants.WaibillStatus.FINISHED.getValue() );
		
		List<BalanceCar> list = incomeMngService.getPrint(params);
		System.out.println(list.size());
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testexport() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		IncomeMngService incomeMngService = (IncomeMngService) context.getBean("incomeMngService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		//状态:2,3,4
		params.put( "statusIn", Constants.WaibillStatus.UNRECEIPT.getValue() + "," + 
					Constants.WaibillStatus.FINISHED.getValue() );
		
		Map<String, Object> formatData = incomeMngService.getExportData(params);
		System.out.println(formatData);

	}
	
}
