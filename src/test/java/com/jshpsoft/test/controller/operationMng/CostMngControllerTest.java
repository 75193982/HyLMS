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
 * 成本管理测试
* @author  fengql 
* @date 2016年11月2日 下午3:58:35
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class CostMngControllerTest {
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
		//scheduleBillNo-调度单号(模糊查询)、carNumber-货运车牌号(模糊查询)、startTime-开始时间、endTime-结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("scheduleBillNo", "HY20161028");
		params.put("carNumber", "J00001");
		params.put("startTime", "");
		params.put("endTime", "");
		params.put("statusIn", Constants.ScheduleBillStatus.ONWAY + "," + Constants.ScheduleBillStatus.FINISH );
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/costMng/getListData";
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
	public void testgetPrint() throws Exception{
		//请求参数：json格式
		//scheduleBillNo-调度单号(模糊查询)、carNumber-货运车牌号(模糊查询)、startTime-开始时间、endTime-结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("scheduleBillNo", "HY20161028");
		params.put("carNumber", "J00001");
		params.put("startTime", "");
		params.put("endTime", "");
		params.put("statusIn", Constants.ScheduleBillStatus.ONWAY + "," + Constants.ScheduleBillStatus.FINISH );
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/costMng/getPrint";
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
