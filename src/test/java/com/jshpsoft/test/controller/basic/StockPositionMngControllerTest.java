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
 * 储位管理测试
* @author  fengql 
* @date 2016年11月1日 下午2:20:35
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class StockPositionMngControllerTest {
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
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/stockPositionMng/getStockList";
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
	public void testgetCarShopList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/stockPositionMng/getCarShopList";
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
	public void testgetListData() throws Exception{
		//请求参数：json格式
		//stockId-仓库id、province-省份、carShopId-4S店id、status-状态：Y-已使用，N-未使用 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("stockId", "2");
		params.put("province", "上海市");
		params.put("carShopId", "3");
		params.put("status", "N");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/stockPositionMng/getListData";
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
		//stockId-仓库id、province-省份、carShopId-4S店id、position-位置
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("stockId", "2");
		params.put("province", "上海市");
		params.put("carShopId", "3");
		params.put("position", "一行三列");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/stockPositionMng/save";
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
		String url = "/basicSetting/stockPositionMng/getDetailData/5";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、stockId-仓库id、province-省份、carShopId-4S店id、position-位置
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 5);
		params.put("stockId", "3");
		params.put("province", "上海市");
		params.put("carShopId", "4");
		params.put("position", "第一排第七列");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/stockPositionMng/update";
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
		String url = "/basicSetting/stockPositionMng/delete/4";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
}
