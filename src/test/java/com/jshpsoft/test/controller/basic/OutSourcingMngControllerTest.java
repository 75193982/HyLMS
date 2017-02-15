package com.jshpsoft.test.controller.basic;

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
 * 外协单位管理测试
* @author  fengql 
* @date 2016年11月1日 上午10:21:14
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class OutSourcingMngControllerTest {
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
		//name-名称、needInvoiceFlag-是否需要提供发票(N否,Y是)、invoiceOrder-开票方式(0票前,1票后)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("name", "外协单位");
		params.put("needInvoiceFlag", "N");
		params.put("invoiceOrder", "0");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/outSourcingMng/getListData";
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
	public void testsave() throws Exception{
		//请求参数：json格式
		//name-名称、address-地址、linkUser-联系人、brithday-联系人出生日期、linkTelephone-电话号码、linkMobile-手机号码、
		//signmentTime-合同签订日期、needInvoiceFlag-是否需要提供发票、invoiceOrder-开票方式，transportOilCostRatio-油费占运费比例
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", "中通运输2");
		params.put("address", "江苏盐城");
		params.put("linkUser", "李二");
		params.put("brithday", "1982-05-26");
		params.put("linkTelephone", "");
		params.put("linkMobile", "13864259876");
		params.put("signmentTime", "2016-01-01");
		params.put("needInvoiceFlag", "Y");
		params.put("invoiceOrder", "1");
		params.put("transportOilCostRatio", "0.8");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/outSourcingMng/save";
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
		String url = "/basicSetting/outSourcingMng/getDetailData/6";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//name-名称、address-地址、linkUser-联系人、brithday-联系人出生日期、linkTelephone-电话号码、linkMobile-手机号码、
		//signmentTime-合同签订日期、needInvoiceFlag-是否需要提供发票、invoiceOrder-开票方式，transportOilCostRatio-油费占运费比例
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 6);
		params.put("name", "中通运输2");
		params.put("address", "江苏盐城");
		params.put("linkUser", "周六");
		params.put("brithday", "1982-05-26");
		params.put("linkTelephone", "");
		params.put("linkMobile", "13864259876");
		params.put("signmentTime", "2016-01-01");
		params.put("needInvoiceFlag", "Y");
		params.put("invoiceOrder", "1");
		params.put("transportOilCostRatio", "0.8");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/outSourcingMng/update";
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
	public void testdelete() throws Exception{
		//请求参数：json格式
		String url = "/basicSetting/outSourcingMng/delete/6";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
}
