package com.jshpsoft.test.controller.common;

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
 * 合同设置测试
* @author  fengql 
* @date 2016年11月1日 下午4:37:39
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class ContractSettingControllerTest {
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
	public void testgetMainIdList() throws Exception{
		//请求参数：json格式
		String url = "/commonSetting/contractSetting/getMainIdList/1";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetListData() throws Exception{
		//请求参数：json格式
		//type-类型(0-员工合同，1-外协单位合同)、code-合同编码、startTime-开始时间yyyy-MM-dd、endTime-结束时间yyyy-MM-dd、status-状态(0-生效中，1-已到期)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("type", "");
		params.put("code", "");
		params.put("startTime", "");
		params.put("endTime", "");
		params.put("status", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/contractSetting/getListData";
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
		//type-类型、code-合同编码、mainId-主体编号、startTime-开始时间、endTime-结束时间、mark-备注、noticeTime-到期提醒时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "1");
		params.put("code", "456123");
		params.put("mainId", "5");
		params.put("startTime", "2016-01-01");
		params.put("endTime", "2017-01-01");
		params.put("mark", "ces");
		params.put("noticeTime", "2016-12-01");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/contractSetting/save";
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
		String url = "/commonSetting/contractSetting/getDetailData/8";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、type-类型、code-合同编码、mainId-主体编号、startTime-开始时间、endTime-结束时间、mark-备注、noticeTime-到期提醒时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 7);
		params.put("type", "1");
		params.put("code", "qwe456123");
		params.put("mainId", "5");
		params.put("startTime", "2016-01-01");
		params.put("endTime", "2017-01-01");
		params.put("mark", "ces");
		params.put("noticeTime", "2016-12-01");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/contractSetting/update";
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
		String url = "/commonSetting/contractSetting/delete/7";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
}
