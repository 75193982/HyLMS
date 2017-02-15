package com.jshpsoft.test.controller.operationMng;

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

import com.jshpsoft.domain.TransportPrepayApplyDetail;

/**
 * 装运预付申请测试
* @author  fengql 
* @date 2016年11月14日 上午9:31:13
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class TransportPrepayMngControllerTest {
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
	public void testgetStockList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");//车头
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/transportPrepayMng/getStockList";
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
	public void testgetOfficeListData() throws Exception{
		//请求参数：json格式
		//carNumber-车牌号(String)、driver-驾驶员(String,模糊查询)、startTime-申请开始时间(String)、endTime-申请结束时间(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		//params.put("insertUser", loginId);
		//String stockId = CommonUtil.getStockIdFromSession(request);
		//params.put("stockId", stockId);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/transportPrepayMng/getOfficeListData";
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
	public void testgetBrandList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/transportPrepayMng/getBrandList";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
		.contentType(MediaType.APPLICATION_JSON)
		.accept(MediaType.APPLICATION_JSON)
		.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	public void testsave() throws Exception{
		//请求参数：json格式
		//carNumber-车牌号(String)、driver-驾驶员(String)、mobile-手机号码(String)、applyTime-申请时间(date)、prepayCash-预付现金(double)、
		//bankName-开户行名称(String)、bankAccount-账号(String)、oilCardNo-油卡卡号(String)、oilAmount-预付油费(double)、mark-备注(String)
		//detailList [ brandName-品牌(String)、count-台数(int)、startAddress-起运地(String)、endAddress-目的地(String)、mark-备注(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("carNumber", "苏J08123");
		params.put("driver", "吕浩");
		params.put("mobile", "18932297586");
		params.put("applyTime", "2016-10-10");
		params.put("prepayCash", "5000");
		params.put("bankName", "");
		params.put("bankAccount", "");
		params.put("oilCardNo", "");
		params.put("oilAmount", "");
		params.put("mark", "预付测试");
		
		List<TransportPrepayApplyDetail> list = new ArrayList<TransportPrepayApplyDetail>();
		TransportPrepayApplyDetail bps = new TransportPrepayApplyDetail();
		bps.setBrandName("起亚");
		bps.setCount(10);
		bps.setStartAddress("盐城");
		bps.setEndAddress("上海");
		bps.setMark("");
		list.add(bps);
		bps = new TransportPrepayApplyDetail();
		bps.setBrandName("奥迪");
		bps.setCount(20);
		bps.setStartAddress("盐城");
		bps.setEndAddress("上海");
		bps.setMark("");
		list.add(bps);
		params.put("detailList", list);
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/transportPrepayMng/save";
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
	public void testgetDetail() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/transportPrepayMng/getDetail/44";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号(int)、carNumber-车牌号(String)、driver-驾驶员(String)、mobile-手机号码(String)、applyTime-申请时间(date)、prepayCash-预付现金(double)、
		//bankName-开户行名称(String)、bankAccount-账号(String)、oilCardNo-油卡卡号(String)、oilAmount-预付油费(double)、mark-备注(String)
		//detailList [ brandName-品牌(String)、count-台数(int)、startAddress-起运地(String)、endAddress-目的地(String)、mark-备注(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 40);
		params.put("carNumber", "苏J08123");
		params.put("driver", "吕浩");
		params.put("mobile", "18932297586");
		params.put("applyTime", "2016-10-10");
		params.put("prepayCash", "5000");
		params.put("bankName", "");
		params.put("bankAccount", "");
		params.put("oilCardNo", "");
		params.put("oilAmount", "");
		params.put("mark", "预付测试");
		
		List<TransportPrepayApplyDetail> list = new ArrayList<TransportPrepayApplyDetail>();
		TransportPrepayApplyDetail bps = new TransportPrepayApplyDetail();
		bps.setBrandName("起亚");
		bps.setCount(10);
		bps.setStartAddress("盐城");
		bps.setEndAddress("上海");
		bps.setMark("");
		list.add(bps);
		bps = new TransportPrepayApplyDetail();
		bps.setBrandName("奥迪");
		bps.setCount(20);
		bps.setStartAddress("盐城");
		bps.setEndAddress("上海");
		bps.setMark("");
		list.add(bps);
		params.put("detailList", list);
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/transportPrepayMng/update";
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
		String url = "/operationMng/transportPrepayMng/delete/44";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsubmit() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/transportPrepayMng/submit/44";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
}
