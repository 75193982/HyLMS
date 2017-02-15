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

import com.jshpsoft.util.Constants;

/**
 * 轮胎出入库单管理测试
* @author  fengql 
* @date 2016年11月3日 上午9:30:07
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class TrackTyreInOutMngControllerTest {
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
		//type-类型、status-状态 、startTime-开始时间、endTime-结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("type", "0");
		params.put("status", "2");
		params.put("startTime", "2016-10-26");
		params.put("endTime", "2016-10-30");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackTyreInOutMng/getListData";
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
	public void testqueryTrackTyre() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", Constants.TrackTyreStatus.NEW);//新建
		params.put("delFlag", Constants.DelFlag.N);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackTyreInOutMng/queryTrackTyre";
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
		//type-类型、mark-备注、tyreIds-轮胎id集(以,分隔)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");
		params.put("mark", "测试入库");
		params.put("tyreIds", "1,2,4");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackTyreInOutMng/save";
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
		String url = "/operationMng/trackTyreInOutMng/getDetail/17";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、type-类型、mark-备注、tyreIds-轮胎id集(以,分隔)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 17);
		params.put("type", "0");
		params.put("mark", "测试入库");
		params.put("tyreIds", "1,2");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackTyreInOutMng/update";
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
		String url = "/operationMng/trackTyreInOutMng/delete/16";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetInoutDetail() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackTyreInOutMng/getInoutDetail/17";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsubmit() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackTyreInOutMng/submit/17";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
}
