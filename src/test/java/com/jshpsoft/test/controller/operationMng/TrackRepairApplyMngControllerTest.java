package com.jshpsoft.test.controller.operationMng;

import java.util.Date;
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
 * 收支管理测试
* @author  fengql 
* @date 2016年11月2日 下午3:19:31
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class TrackRepairApplyMngControllerTest {
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
		//type-类型、status-状态 、mark-事由(模糊查询)、startTime-开始时间、endTime-结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("vin", "LH-GHHH");
		/*params.put("status", "1");
		params.put("mark", "");*/
		params.put("startTime", "");
		params.put("endTime", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackRepairApply/getListData";
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
		//type-类型、mark-事由、money-金额
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("carStockId", "1");
		params.put("applyTime", new Date().getTime());
		params.put("repairContent", "修理车子");
		params.put("repairCompany", "二子修理厂");
		params.put("repairTelephone", "18954455454");
		params.put("repairFinishedTime", new Date().getTime());
		String josnStr = JSONObject.fromObject(params).toString();
		String url = "/operationMng/trackRepairApply/save";
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
	public void testGetDamageStocks() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackRepairApply/getDamageStocks";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
	@Test
	public void testgetDetail() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackRepairApply/getDetail/3";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、type-类型、mark-事由、money-金额
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 5);
		params.put("carStockId", "2");
		params.put("applyTime", new Date().getTime());
		params.put("repairContent", "修理车子4");
		params.put("repairCompany", "二子修理厂4");
		params.put("repairTelephone", "18954455452");
		params.put("repairFinishedTime", new Date().getTime());
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackRepairApply/update";
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
		String url = "/operationMng/trackRepairApply/delete/5";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsubmit() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackRepairApply/submit/5";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
	
	@Test
	public void testconfirm() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 5);
		params.put("finishTime", new Date().getTime());
		params.put("finishUser", "修理车子4");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackRepairApply/confirm";
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
		//type-类型、status-状态 、mark-事由(模糊查询)、startTime-开始时间、endTime-结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vin", "LH-GHHH");
		params.put("status", "1");
		/*params.put("mark", "");*/
		params.put("startTime", "");
		params.put("endTime", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackRepairApply/getPrint";
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
	public void testexport() throws Exception{
		//请求参数：json格式
		//type-类型、status-状态 、mark-事由(模糊查询)、startTime-开始时间、endTime-结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vin", "LH-GHHH");
		/*params.put("status", "1");
		params.put("mark", "");*/
		params.put("startTime", "");
		params.put("endTime", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackRepairApply/export";
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
