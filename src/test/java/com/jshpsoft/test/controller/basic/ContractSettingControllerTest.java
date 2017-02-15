package com.jshpsoft.test.controller.basic;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.jshpsoft.domain.Contract;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.ContractService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Pager;

/**
 * 合同设置测试
* @author  fengql 
* @date 2016年10月10日 下午4:45:07
 */
public class ContractSettingControllerTest {

	/**
	 * 获取main_id
	* @author  fengql 
	* @date 2016年10月10日 下午4:46:36 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testgetMainIdList() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		Map<String, Object> params = new HashMap<String, Object>();
		String type="1";
		if(type.equals("0")){//员工
			UserService userService = (UserService) context.getBean("userService");
			List<User> list = userService.getByConditions(params);
			System.out.println(list.size()+"=="+list.get(0).getId()+"=="+list.get(0).getName());
		}else{//外协单位
			CommonService commonService = (CommonService) context.getBean("commonService");
			List<OutSourcing> list = commonService.getOutSourcingList(params);
			System.out.println(list.size()+"=="+list.get(0).getId()+"=="+list.get(0).getName());
		}
	
	}
	
	/**
	 * 获取合同信息
	* @author  fengql 
	* @date 2016年10月10日 下午4:53:05 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testgetListData() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		ContractService contractService = (ContractService) context.getBean("contractService");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageStartIndex", "0");
		params.put("pageSize", "10");
		
		Pager<Contract> pager = contractService.getPageData(params);		
		System.out.println(pager.getTotalCounts()+pager.getRecords().get(0).getMainName());
	
	}
	
	/**
	 * 保存合同信息
	* @author  fengql 
	* @date 2016年10月10日 下午4:57:51 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testsave() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		ContractService contractService = (ContractService) context.getBean("contractService");
		
		Contract bean = new Contract();
		bean.setType("1");
		bean.setCode("112233");
		bean.setMainId(1);
		bean.setStartTime(new Date());
		bean.setEndTime(new Date());
		bean.setMark("qqqqqqqqqq");
		bean.setFilePath("D://qq");

		String oper = "测试";//操作员
		contractService.save(bean, oper);
	
	}
	
	/**
	 * 获取合同详情
	* @author  fengql 
	* @date 2016年10月10日 下午5:21:14 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testgetDetailData() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		ContractService contractService = (ContractService) context.getBean("contractService");
		
		Contract bean = contractService.getById(2);
		System.out.println(bean.getCode());
	}
	
	/**
	 * 修改合同
	* @author  fengql 
	* @date 2016年10月10日 下午5:22:56 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testupdate() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		ContractService contractService = (ContractService) context.getBean("contractService");
		
		Contract bean = new Contract();
		bean.setId(2);
		bean.setType("1");
		bean.setCode("11223344");
		bean.setMainId(1);
		bean.setStartTime(new Date());
		bean.setEndTime(new Date());
		bean.setMark("qqqqqqqqqq");
		bean.setFilePath("D://qq");

		String oper = "测试";//操作员
		contractService.update(bean, oper);
		
	}
	
	/**
	 * 删除合同
	* @author  fengql 
	* @date 2016年10月10日 下午5:25:10 
	* @parameter  
	* @return
	 */
	@SuppressWarnings("resource")
	@Test
	public void testdelete() throws Exception{
		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
		ContractService contractService = (ContractService) context.getBean("contractService");
		
		contractService.updateById(1, "测试");
	}
}
