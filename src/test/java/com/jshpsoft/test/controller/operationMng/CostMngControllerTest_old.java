package com.jshpsoft.test.controller.operationMng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.service.CostMngService;
import com.jshpsoft.util.Constants;

/**
 * 成本管理测试
* @author  fengql 
* @date 2016年10月28日 下午3:10:18
 */
public class CostMngControllerTest_old {

	@SuppressWarnings("resource")
	@Test
	public void testgetListData() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CostMngService costMngService = (CostMngService) context.getBean("costMngService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		//状态:4,5
		params.put( "statusIn", Constants.ScheduleBillStatus.ONWAY + "," + Constants.ScheduleBillStatus.FINISH );
		
		List<BalanceCar> list = costMngService.getPrint(params);
		System.out.println(list.size());
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testexport() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CostMngService costMngService = (CostMngService) context.getBean("costMngService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		//状态:4,5
		params.put( "statusIn", Constants.ScheduleBillStatus.ONWAY + "," + Constants.ScheduleBillStatus.FINISH );
				
		Map<String, Object> formatData = costMngService.getExportData(params);
		System.out.println(formatData);

	}
	
	
}
