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
 * 维修保养测试
* @author  fengql 
* @date 2016年11月14日 上午10:14:32
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class TrackMaintMngControllerTest {
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
		//carNumber-货运车号(String)、detailInfo-保养内容(String,关键字查询)、status-状态(String)、
		//startTime-开始时间(String)、endTime-结束时间(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("carNumber", "");
		params.put("detailInfo", "");
		params.put("status", "");
		params.put("startTime", "");
		params.put("endTime", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackMaintMng/getListData";
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
	public void testgetStockList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");//车头
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackMaintMng/getStockList";
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
		//carNumber-货运车号(String)、currentMileage-目前公里数(int)、detailInfo-保养详情(String)、amount-保养费用(double)、mark-备注(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("carNumber", "苏J08123");
		params.put("currentMileage", "10000");
		params.put("detailInfo", "我问问");
		params.put("amount", "500");
		params.put("mark", "测试");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackMaintMng/save";
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
		String url = "/operationMng/trackMaintMng/getDetail/8";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、carNumber-货运车号(String)、currentMileage-目前公里数(int)、detailInfo-保养详情(String)、amount-保养费用(double)、mark-备注(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 7);
		params.put("carNumber", "苏J08123");
		params.put("currentMileage", "10000");
		params.put("detailInfo", "我问问");
		params.put("amount", "500");
		params.put("mark", "测试");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackMaintMng/update";
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
		String url = "/operationMng/trackMaintMng/delete/8";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsubmit() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackMaintMng/submit/8";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
}
