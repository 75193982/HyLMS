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
 * 4S店管理测试
* @author  fengql 
* @date 2016年10月31日 下午3:52:01
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class CarShopMngControllerTest {
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
		//orgCode-经销商代码、name-名称 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("orgCode", "11");
		//params.put("name", "上海");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/carShopMng/getListData";
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
		//province-省份、orgCode-经销商代码、name-名称、address-地址、linkUser-联系人、brithday-联系人出生日期、linkTelephone-电话号码、linkMobile-手机号码
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("province", "浙江省");
		params.put("orgCode", "ZJ0101");
		params.put("name", "上海大众4S");
		params.put("address", "浙江省XXXXX");
		params.put("linkUser", "李四");
		params.put("brithday", "1979-1-1");
		params.put("linkTelephone", "");
		params.put("linkMobile", "13752160356");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/carShopMng/save";
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
		String url = "/basicSetting/carShopMng/getDetailData/8";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、province-省份、orgCode-经销商代码、name-名称、address-地址、linkUser-联系人、brithday-联系人出生日期、linkTelephone-电话号码、linkMobile-手机号码
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 8);
		params.put("province", "浙江省");
		params.put("orgCode", "ZJ0101");
		params.put("name", "上海大众4S");
		params.put("address", "浙江省XXXXX");
		params.put("linkUser", "李四");
		params.put("brithday", "1969-01-01");
		params.put("linkTelephone", "");
		params.put("linkMobile", "13752160356");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/carShopMng/update";
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
		String url = "/basicSetting/carShopMng/delete/5";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
}
