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
 * 调度管理测试
* @author  fengql 
* @date 2016年11月8日 上午8:56:47
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class ScheduleMngControllerTest {
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
		//sendTimeStart-开始发车时间(String)、sendTimeEnd-结束发车时间(String)、carNumber-货运车牌号(String)、
		//startAddress-出发地(String)、endAddress-目的地(String)、status-状态(String)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("sendTimeStart", "");
		params.put("sendTimeEnd", "");
		params.put("carNumber", "");
		params.put("startAddress", "");
		params.put("endAddress", "");
		params.put("status", "");
		//params.put("stockId", CommonUtil.getStockIdFromSession(request));
		//params.put("insertUser", CommonUtil.getOperId(request));
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/scheduleMng/getListData";
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
		
		String url = "/operationMng/scheduleMng/getStockList";
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
		
		String url = "/operationMng/scheduleMng/getCarShopList";
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
	public void testgetCarList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		//params.put("stockId", stockId);
		params.put("carShopId", 2);
		params.put("type", "0");//类型：0-正常新车，1-二手车，2-折损车
		params.put("status", Constants.CarStatus.HASIN);//1已入库
		params.put("delFlag", Constants.DelFlag.N);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/scheduleMng/getCarList";
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
	public void testgetCarAttachmentList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		//params.put("stockId", stockId);
		params.put("carShopId", 2);
		params.put("type", "0");//类型：0-正常新车，1-二手车，2-折损车
		params.put("delFlag", Constants.DelFlag.N);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/scheduleMng/getCarAttachmentList";
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
	public void testgetSecCarList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		//params.put("stockId", stockId);
		params.put("type", "1");//类型：0-正常新车，1-二手车，2-折损车
		params.put("status", Constants.CarStatus.HASIN);//1已入库
		params.put("delFlag", Constants.DelFlag.N);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/scheduleMng/getSecCarList";
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
	public void testgetSecCarAttachmentList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		//params.put("stockId", stockId);
		params.put("type", "1");//类型：0-正常新车，1-二手车，2-折损车
		params.put("delFlag", Constants.DelFlag.N);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/scheduleMng/getSecCarAttachmentList";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
		.contentType(MediaType.APPLICATION_JSON)
		.accept(MediaType.APPLICATION_JSON)
		.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
/*	@Test
	public void testsave() throws Exception{
		//请求参数：json格式
		//
		Map<String, Object> params = new HashMap<String, Object>();

		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/scheduleMng/save";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}*/
	
	@Test
	public void testgetDetailData() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/scheduleMng/getDetailData/HY2016110900006";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testdelete() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/scheduleMng/delete/HY2016110900006";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsubmit() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/scheduleMng/submit/HY2016110900006";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetLatestBillNo() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/scheduleMng/getLatestBillNo";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
}
