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

/**
 * @author  ww 
 * @date 2016年10月26日 上午9:03:54
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class OtherContactsTest {
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
	public void testExport() throws Exception{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");
		params.put("name", "");
		params.put("status", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/otherContactsMng/export";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
	}
	
	public static void main(String[] args) {
		List<List<String>> listA = new ArrayList<List<String>>();
		
		String a = "1,2,3,4,5,6";
		String[] b = a.split(",");
		for(int i = 0;i<b.length;i++)
		{
			List<String> listb = new ArrayList<String>();
			listb.add(b[i]);
			listA.add(listb);
			//listb.clear();
		}
		System.out.println(listA);
	}

}
