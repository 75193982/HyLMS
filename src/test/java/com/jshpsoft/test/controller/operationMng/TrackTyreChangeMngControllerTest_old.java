package com.jshpsoft.test.controller.operationMng;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TrackTyreChangeApply;
import com.jshpsoft.domain.TrackTyreStock;
import com.jshpsoft.service.TrackTyreChangeMngService;
import com.jshpsoft.service.TrackTyreMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Constants;

/**
 * 轮胎更换管理测试
* @author  fengql 
* @date 2016年10月27日 下午2:13:49
 */
public class TrackTyreChangeMngControllerTest_old {

	/**
	 * 获取货运车号信息
	* @author  fengql 
	* @date 2016年10月24日 下午5:06:46 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testgetTrackList() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CommonService commonService = (CommonService) context.getBean("commonService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");//车头
		List<Track> list = commonService.getTrackList(params);
		System.out.println(list.size());
	}
	
	/**
	 * 获取轮胎更换信息
	* @author  fengql 
	* @date 2016年10月27日 下午2:21:12 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testgetListData() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreChangeMngService trackTyreChangeMngService = (TrackTyreChangeMngService) context.getBean("trackTyreChangeMngService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		List<TrackTyreChangeApply> list = trackTyreChangeMngService.getByConditions(params);
		System.out.println(list.size());
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testgetOldTyreNo() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreMngService trackTyreMngService = (TrackTyreMngService) context.getBean("trackTyreMngService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("carNumber", "苏J00001");
		params.put("status", Constants.TrackTyreStatus.USED);//使用中
		List<TrackTyreStock> list = trackTyreMngService.getByConditions(params);
		System.out.println(list.size());
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testqueryTrackTyre() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreMngService trackTyreMngService = (TrackTyreMngService) context.getBean("trackTyreMngService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", Constants.TrackTyreStatus.HASIN);//已入库
		List<TrackTyreStock> list = trackTyreMngService.getByConditions(params);
		System.out.println(list.size());
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testsave() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreChangeMngService trackTyreChangeMngService = (TrackTyreChangeMngService) context.getBean("trackTyreChangeMngService");
		
		TrackTyreChangeApply bean = new TrackTyreChangeApply();
		bean.setCarNumber("苏J00001");
		bean.setOldTyreNo("MQL10001");
		bean.setNewTyreNo("MQL10003");
		bean.setMark("测试2");
		
		trackTyreChangeMngService.save(bean, "12");
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testgetDetail() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreChangeMngService trackTyreChangeMngService = (TrackTyreChangeMngService) context.getBean("trackTyreChangeMngService");
		
		TrackTyreChangeApply bean = trackTyreChangeMngService.getById(1);
		System.out.println(bean.getNewTyreNo());
		
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testupdate() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreChangeMngService trackTyreChangeMngService = (TrackTyreChangeMngService) context.getBean("trackTyreChangeMngService");
		
		TrackTyreChangeApply bean = new TrackTyreChangeApply();
		bean.setId(1);
		bean.setCarNumber("苏J00001");
		bean.setOldTyreNo("MQL10001");
		bean.setNewTyreNo("MQL10004");
		bean.setMark("测试修改");
		
		trackTyreChangeMngService.update(bean, "12");
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testdelete() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreChangeMngService trackTyreChangeMngService = (TrackTyreChangeMngService) context.getBean("trackTyreChangeMngService");
		
		trackTyreChangeMngService.updateById(2, "12");
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testsubmit() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreChangeMngService trackTyreChangeMngService = (TrackTyreChangeMngService) context.getBean("trackTyreChangeMngService");
		
		trackTyreChangeMngService.submit(1, "12");
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testauditSuccess() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreChangeMngService trackTyreChangeMngService = (TrackTyreChangeMngService) context.getBean("trackTyreChangeMngService");
		
		trackTyreChangeMngService.auditSuccess(1, "2","12");
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testauditFail() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		TrackTyreChangeMngService trackTyreChangeMngService = (TrackTyreChangeMngService) context.getBean("trackTyreChangeMngService");
		
		trackTyreChangeMngService.auditFail(1, "0","12");
	}
}
