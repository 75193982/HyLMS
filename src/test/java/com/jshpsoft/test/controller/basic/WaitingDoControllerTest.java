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
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class WaitingDoControllerTest {
	@Autowired
	private WebApplicationContext wac;
	
	private MockMvc mockMvc;
	
	private MockHttpServletRequest request = null;
	
	private MockHttpServletResponse response = null;
	
	private MockHttpSession session = null;
	
	@Before
	public void setUp(){
		request = new MockHttpServletRequest();
		request.setCharacterEncoding("UTF-8");
		
		response = new MockHttpServletResponse();
		
		session = new MockHttpSession();
		
		this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
	}

	@Test
	public void testgetListData() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 10);
		params.put("pageStartIndex", 1);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/dailyOffice/waitingDo/getListData";
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
		String url = "/dailyOffice/waitingDo/getDetailData/1";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsubmitWaybill() throws Exception{
		//请求参数：json格式
		String url = "/dailyOffice/waitingDo/getNextProcessDetailInfo/31";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	/**
	 * 提交审核
	 */
	@Test
	@Transactional
	@Rollback(true)
	public void testaudit() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("taskId", 17);
		params.put("mark", "信息不完整");
		params.put("successFlag", "N");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/dailyOffice/waitingDo/audit";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}
	
	/**
	 * 提交审核
	 */
	@Test
	@Transactional
	@Rollback(true)
	public void testaudit2() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("taskId", 17);
		params.put("mark", "同意");
		params.put("successFlag", "Y");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/dailyOffice/waitingDo/audit";
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
	public void testgetListDataForHasDo() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 10);
		params.put("pageStartIndex", 1);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/dailyOffice/waitingDo/getListDataForHasDo";
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
