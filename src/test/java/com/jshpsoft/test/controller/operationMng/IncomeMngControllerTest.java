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
 * 收入管理测试
* @author  fengql 
* @date 2016年11月2日 下午4:25:33
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class IncomeMngControllerTest {
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
		//waybillNo-运单编号(模糊查询)、brand-品牌(模糊查询)、startTime-开始时间、endTime-结束时间、supplierId-供应商id
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("waybillNo", "");
		params.put("brand", "");
		params.put("startTime", "");
		params.put("endTime", "");
		params.put("supplierId", "");
		//状态:2,3,4
		params.put( "statusIn", Constants.WaibillStatus.UNRECEIPT.getValue() + ","  + 
					Constants.WaibillStatus.FINISHED.getValue() );
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/incomeMng/getListData";
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
		//detailId-运单id、type-计费方式、ratio-比例、amount-金额、mark-备注
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("detailId", "37");
		params.put("type", "1");
		params.put("ratio", "60");
		params.put("amount", "");
		params.put( "mark", "测试测试2");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/incomeMng/save";
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
	public void testgetAttachDetail() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/incomeMng/getAttachDetail/37";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testdelete() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/incomeMng/delete/11";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetPrint() throws Exception{
		//请求参数：json格式
		//waybillNo-运单编号(模糊查询)、brand-品牌(模糊查询)、startTime-开始时间、endTime-结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("waybillNo", "2011609");
		params.put("brand", "");
		params.put("startTime", "");
		params.put("endTime", "");
		//状态:2,3,4
		params.put( "statusIn", Constants.WaibillStatus.UNRECEIPT.getValue() + "," + 
					Constants.WaibillStatus.FINISHED.getValue() );
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/incomeMng/getPrint";
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
	public void testbalance() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/incomeMng/balance/98";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
}
