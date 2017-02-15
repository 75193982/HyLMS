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
 * 在途换车测试
* @author  fengql 
* @date 2016年11月14日 上午10:33:27
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class TrackChangeMngControllerTest {
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
		//oldDriver-原驾驶员(String)、newDriver-新驾驶员(String)、status-状态(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("oldDriver", "");
		params.put("newDriver", "");
		params.put("status", "");
		//params.put("stockId", CommonUtil.getStockIdFromSession(request));
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackChangeMng/getListData";
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
	public void testgetSchBillNo() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", Constants.ScheduleBillStatus.ONWAY);//4在途状态的
		params.put("delFlag", Constants.DelFlag.N);//未删除
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackChangeMng/getSchBillNo";
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
	public void testtrackChangeApply() throws Exception{
		//请求参数：json格式
		//scheduleBillNo-调度单号(String)、reason-原因(String)、oldDriver-原驾驶员(String)、oldCarNumber-原货运车牌号(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("scheduleBillNo", "HY2016110900006");
		params.put("reason", "测试");
		params.put("oldDriver", "吕浩");
		params.put("oldCarNumber", "苏J08123");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackChangeMng/trackChangeApply";
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
		String url = "/operationMng/trackChangeMng/getDetail/10";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsubmit() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackChangeMng/submit/10";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}

	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//scheduleBillNo-调度单号(String)、reason-原因(String)、oldDriver-原驾驶员(String)、oldCarNumber-原货运车牌号(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 11);
		params.put("scheduleBillNo", "HY2016110900006");
		params.put("reason", "测试");
		params.put("oldDriver", "吕浩");
		params.put("oldCarNumber", "苏J08123");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackChangeMng/update";
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
		String url = "/operationMng/trackChangeMng/delete/10";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetStockList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");//车头
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackChangeMng/getStockList";
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
	public void testauditSuccess() throws Exception{
		//请求参数：json格式
		//id-id号(int)、newCarNumber-新货运车(String)、newDriver-新驾驶员(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 11);
		params.put("newCarNumber", "苏J7v887");
		params.put("newDriver", "吕浩");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackChangeMng/auditSuccess";
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
	public void testauditFail() throws Exception{
		//请求参数：json格式
		//id-id号(int)、auditContent-驳回理由(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 11);
		params.put("auditContent", "啛啛喳喳");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackChangeMng/auditFail";
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
