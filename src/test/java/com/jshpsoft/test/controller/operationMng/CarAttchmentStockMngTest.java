package com.jshpsoft.test.controller.operationMng;


import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.jshpsoft.service.CarAttachmentStockService;

/**
 * @author  ww 
 * @date 2016年10月21日 下午4:41:48
 */
public class CarAttchmentStockMngTest {
	
//	@SuppressWarnings("resource")
//	@Test
//	public void testUpdate() throws Exception{
//		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
//		CarAttachmentStockService carAttachmentMngService = (CarAttachmentStockService) context.getBean("carAttachmentMngService");
//		
//		CarAttachmentStock ca = new CarAttachmentStock();
//		ca.setCount(5);
//		ca.setId(1);
//		carAttachmentMngService.update(ca);
//	}
	
	@SuppressWarnings("resource")
	@Test
	public void test2() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CarAttachmentStockService carAttachmentMngService = (CarAttachmentStockService) context.getBean("carAttachmentMngService");
		
		Map<String,Object> params = new HashMap<String, Object>();
		String a = "1,2,3";
		String[] b = a.split(",");
		String attachmentIds = "";
		for(int i = 0;i<b.length;i++)
		{
			attachmentIds += "'"+b[i]+"'";
			if(i != b.length-1)
			{
				attachmentIds += ",";
			}
		}
		System.out.println("--------attachmentIds-------"+attachmentIds);
		params.put("attachmentIds",attachmentIds);
		carAttachmentMngService.getByConditions(params);
	}
	

}
