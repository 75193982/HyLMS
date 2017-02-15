package com.jshpsoft.test.controller.car;

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
 * 商品车库存管理
* @author  fengql 
* @date 2016年11月2日 上午9:55:10
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class CarStockMangeControllerTest {
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
	public void testqueryCarBrand() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/car/carStockMange/queryCarBrand";
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
		params.put("type", Constants.WaybillType.SPC);//0商品车
		params.put("status", Constants.WaibillStatus.NEW.getValue());
		params.put("delFlag", Constants.DelFlag.N);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/car/carStockMange/queryWaybill";
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
		//type - 类型：0-商品车(默认)，1-二手车，waybillId 运单id ,brand 品牌，vin 车架号,model 车型，color 颜色,engineNo 发动机号
		//position 停车位置，keyPosition 钥匙存放位置,mark 备注
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");
		params.put("waybillId", "59");
		params.put("brand", "大众");
		params.put("vin", "JBJ2584613");
		params.put("model", "");
		params.put("color", "red");
		params.put("engineNo", "");
		params.put("position", "一行一号");
		params.put("keyPosition", "一行一号");
		params.put("mark", "商品车入库测试");

		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/car/carStockMange/carStockIn";
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
	public void testgetCarListData() throws Exception{
		//请求参数：json格式
		//type-类型、brand-品牌、status-状态
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("type", "");
		params.put("brand", "");
		params.put("status", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/car/carStockMange/getCarListData";
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
	public void testqueryCarStock() throws Exception{
		//请求参数：json格式
		String url = "/car/carStockMange/queryCarStock/48";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testeditCarStock() throws Exception{
		//请求参数：json格式
		//id-id号、type - 类型：0-商品车(默认)，1-二手车，waybillId 运单id ,brand 品牌，vin 车架号,model 车型，color 颜色,engineNo 发动机号
		//position 停车位置，keyPosition 钥匙存放位置,mark 备注
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 48);
		params.put("type", "0");
		params.put("waybillId", "59");
		params.put("brand", "大众");
		params.put("vin", "JBJ2584613");
		params.put("model", "");
		params.put("color", "red");
		params.put("engineNo", "");
		params.put("position", "一行二号");
		params.put("keyPosition", "一行二号");
		params.put("mark", "商品车入库测试");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/car/carStockMange/editCarStock";
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
	public void testdeleteCarStock() throws Exception{
		//请求参数：json格式
		String url = "/car/carStockMange/deleteCarStock/48";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testqueryCarStockInOut() throws Exception{
		//请求参数：json格式
		//type-类型、status-状态
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");
		params.put("status", "1");

		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/car/carStockMange/queryCarStockInOut";
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
