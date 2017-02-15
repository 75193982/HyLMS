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
 * 折损车管理测试
* @author  fengql 
* @date 2016年11月2日 下午2:18:58
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class CarDamageMngControllerTest {
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
		//brand-品牌、status-状态 
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("brand", "");
		params.put("status", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/carDamageMng/getListData";
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
	public void testgetBrandList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/carDamageMng/getBrandList";
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
	public void testqueryWaybill() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", Constants.WaybillType.ZSC);//2折损车
		params.put("status", Constants.WaibillStatus.NEW.getValue());
		params.put("delFlag", Constants.DelFlag.N);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/carDamageMng/queryWaybill";
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
		//waybillId-运单编号、brand-品牌、vin-车架号、model-车型、color-颜色、engineNo-发动机号、mark-备注、
		//position-停车位置、keyPosition-钥匙存放位置
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("waybillId", "84");
		params.put("brand", "大众");
		params.put("vin", "ZSCKQWE52613");
		params.put("model", "");
		params.put("color", "red");
		params.put("engineNo", "");
		params.put("mark", "测试");
		params.put("position", "三行三列");
		params.put("keyPosition", "三行三列");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/carDamageMng/save";
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
	public void testgetcarDamagetList() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/carDamageMng/getcarDamagetList/8";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、waybillId-运单编号、brand-品牌、vin-车架号、model-车型、color-颜色、engineNo-发动机号、mark-备注、
		//position-停车位置、keyPosition-钥匙存放位置
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 8);
		params.put("waybillId", "84");
		params.put("brand", "大众");
		params.put("vin", "ZSCKJH52613");
		params.put("model", "");
		params.put("color", "red");
		params.put("engineNo", "1234567");
		params.put("mark", "测试");
		params.put("position", "三行十三列");
		params.put("keyPosition", "三行十三列");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/carDamageMng/update";
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
		String url = "/operationMng/carDamageMng/delete/9";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testgetInoutList() throws Exception{
		//请求参数：json格式
		//type-类型、status-状态 、startTime-开始时间、endTime-结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "");
		params.put("status", "");
		params.put("startTime", "");
		params.put("endTime", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/carDamageMng/getInoutList";
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
