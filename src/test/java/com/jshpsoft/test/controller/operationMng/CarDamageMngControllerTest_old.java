package com.jshpsoft.test.controller.operationMng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.service.CarDamageMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Pager;

/**
 * 折损车管理测试
* @author  fengql 
* @date 2016年10月10日 下午5:28:23
 */
public class CarDamageMngControllerTest_old {

	/**
	 * 获取折损车信息
	* @author  fengql 
	* @date 2016年10月10日 下午5:28:55 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testgetListData() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CarDamageMngService carDamageMngService = (CarDamageMngService) context.getBean("carDamageMngService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageStartIndex", "0");
		params.put("pageSize", "10");
		params.put("stockId", 1);
		Pager<CarDamageStock> pager = carDamageMngService.getPageData(params);		
		System.out.println(pager.getTotalCounts());
		
	}
	
	/**
	 * 获取品牌数据
	* @author  fengql 
	* @date 2016年10月11日 上午10:08:46 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testgetBrandList() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CommonService commonService = (CommonService) context.getBean("commonService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		List<CarBrand> list = commonService.getCarBrandList(params);
		System.out.println(list.size());
		
	}
	
	/**
	 * 保存折损车信息
	* @author  fengql 
	* @date 2016年10月11日 上午10:11:30 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testsave() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CarDamageMngService carDamageMngService = (CarDamageMngService) context.getBean("carDamageMngService");
	
		CarDamageStock bean = new CarDamageStock();
		bean.setStockId(1);
		bean.setBrand("宝马");
		bean.setVin("AJDLAA29XG0658426");
		bean.setModel("G114");
		bean.setColor("白色");
		bean.setEngineNo("DXS4D1615");
		bean.setMark("测试测试");
		bean.setPosition("二号一行一列");
		bean.setKeyPosition("二号一行一列");
//		bean.setAttachPosition("二号一行一列");
		String oper = "测试";//操作员
		
		carDamageMngService.save(bean, oper);
		
	}
	
	/**
	 * 获取详细信息
	* @author  fengql 
	* @date 2016年10月11日 上午10:28:03 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testgetcarDamagetList() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CarDamageMngService carDamageMngService = (CarDamageMngService) context.getBean("carDamageMngService");
	
		CarDamageStock bean = carDamageMngService.getById(6);
		System.out.println(bean.getBrand());
		
	}
	
	@SuppressWarnings("resource")
	@Test
	public void testupdate() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CarDamageMngService carDamageMngService = (CarDamageMngService) context.getBean("carDamageMngService");
	
		CarDamageStock bean = new CarDamageStock();
		bean.setId(6);
		bean.setStockId(1);
		bean.setBrand("宝马");
		bean.setVin("AJDLAA29XG0658426");
		bean.setModel("G114");
		bean.setColor("黑色");
		bean.setEngineNo("DXS4D1615");
		bean.setMark("测试啊");
		bean.setPosition("二号一行一列");
		bean.setKeyPosition("二号一行一列");
//		bean.setAttachPosition("二号一行一列");
		String oper = "测试";//操作员
		
		carDamageMngService.update(bean, oper);		
	}
	
	/**
	 * 删除折损车信息
	* @author  fengql 
	* @date 2016年10月11日 下午1:22:12 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testdelete() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CarDamageMngService carDamageMngService = (CarDamageMngService) context.getBean("carDamageMngService");
	
		carDamageMngService.updateById(6, "测试");	
	}
	
	/**
	 * 提交
	* @author  fengql 
	* @date 2016年10月11日 下午1:28:41 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testsubmit() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		CarDamageMngService carDamageMngService = (CarDamageMngService) context.getBean("carDamageMngService");
	
		carDamageMngService.submit(6, "测试");	
	}
}
