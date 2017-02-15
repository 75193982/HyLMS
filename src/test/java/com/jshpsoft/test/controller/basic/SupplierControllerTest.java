package com.jshpsoft.test.controller.basic;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import com.jshpsoft.domain.BalancePriceSetting;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class SupplierControllerTest {
	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mockMvc;
	
	private MockHttpServletRequest request = null;
	
//	private MockHttpServletResponse response = null;
//	private MockHttpSession session = null;
	
	@Before
	public void setUp(){
		request = new MockHttpServletRequest();
		request.setCharacterEncoding("UTF-8");
		
//		response = new MockHttpServletResponse();
//		session = new MockHttpSession();
		
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
	}
	
	@Test
	public void testgetListData() throws Exception{
		//请求参数：json格式
		//name-名称、needInvoiceFlag-是否需要提供发票(N否,Y是)、invoiceOrder-开票方式(0票前,1票后) 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("name", "国际物流");
		params.put("needInvoiceFlag", "");
		params.put("invoiceOrder", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/supplierMng/getListData";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}
	
	
	
	
	

//	 * 		id-供应商id
//	 * 		balanceType-结算方式（0-单价模式，1-公里数模式、2-总价模式）
//	 * 		detail : 
//	 * 		[
//	 * 			prices-价格
//	 * 			outSourcingPrice-外协单位结算价格
//	 * 			brand-品牌
//	 * 			carType-车型
//	 * 
//	 * 		]
	@Test
	public void testsaveBalanceSetting() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 2);
		params.put("balanceType", 1);
		List<BalancePriceSetting> list = new ArrayList<BalancePriceSetting>();
//		{"detail":[{"brand":"大众","carType":"SA2","price":"333","outSourcingPrice":"444"},{"brand":"宝马","carType":"X1","price":"44","outSourcingPrice":"55"}],"balanceType":"1","id":"2"}
		BalancePriceSetting bps = new BalancePriceSetting();
		bps.setBrand("大众");
		bps.setCarType("SA2");
		bps.setPrice(new BigDecimal(333));
		bps.setOutSourcingPrice(new BigDecimal(444));
		list.add(bps);
		bps = new BalancePriceSetting();
		bps.setBrand("宝马");
		bps.setCarType("X1");
		bps.setPrice(new BigDecimal(44));
		bps.setOutSourcingPrice(new BigDecimal(55));
		list.add(bps);
		params.put("balanceType", 1);
		params.put("detail", list);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/supplierMng/saveBalanceSetting";
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
	public void testgetProcessListForOffice() throws Exception{
		//请求参数：json格式
		String url = "/basicSetting/processMng/getProcessListForOffice/1";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetBalanceSettingInfo() throws Exception{
		//请求参数：json格式
		String url = "/basicSetting/supplierMng/getBalanceSettingInfo/2";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
}
