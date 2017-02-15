package com.jshpsoft.test.controller.operationMng;

import java.util.HashMap;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.codec.CharEncoding;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

/**
 * 对账管理测试
* @author  fengql 
* @date 2016年11月7日 下午1:17:09
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class BalanceBillMngControllerTest {
	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mockMvc;
	
	private MockHttpServletRequest request = null;
	
	@Before
	public void setUp(){
		request = new MockHttpServletRequest();
		request.setCharacterEncoding("UTF-8");
		
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
	}
	
	@Test
	public void testgetListData() throws Exception{
		//请求参数：json格式
		//startTime-插入开始时间(String)、endTime-插入结束时间(String)、supplierId-供应商id(String)、
		//waybillNo-运单号(String)、status-状态:0新建1已确认(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("startTime", "2016-01-01");
		params.put("endTime", "2016-11-12");
		params.put("supplierId", "8");
		params.put("waybillNo", "201611041004");
		params.put("status", "0");
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/balanceBillMng/getListData";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}

	@Test
	public void testgetDetailData() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/balanceBillMng/getDetailData/1";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetDetailPrintData() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/balanceBillMng/getDetailPrintData/3";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetAmount() throws Exception{
		//请求参数：json格式
		//id-id号(int)、carCount-台数(int)、distance-公里数(int)、balanceType-结算方式(String,传0、1、2)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 1);
		params.put("carCount", "3");
		params.put("distance", "2800");
		params.put("balanceType", "0");
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/balanceBillMng/getAmount";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号(int)、carCount-台数(int)、distance-公里数(int)、balanceType-结算方式(String,传0、1、2)、balanceAmount-结算总金额(Double) 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 1);
		params.put("carCount", "5");
		params.put("distance", "2900");
		params.put("balanceType", "1");
		params.put("balanceAmount", "12000");
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/balanceBillMng/update";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsure() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/balanceBillMng/sure/1";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetPrint() throws Exception{
		//请求参数：json格式
		//startTime-插入开始时间(String)、endTime-插入结束时间(String)、supplierId-供应商id(String)、
		//waybillNo-运单号(String)、status-状态:0新建1已确认(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("startTime", "2016-01-01");
		params.put("endTime", "2016-11-12");
		params.put("supplierId", "8");
		params.put("waybillNo", "201611041004");
		params.put("status", "");
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/balanceBillMng/getPrint";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}
}
