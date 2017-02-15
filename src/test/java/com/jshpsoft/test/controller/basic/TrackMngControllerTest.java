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
 * 运输车辆管理测试
* @author  fengql 
* @date 2016年11月1日 下午2:31:51
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class TrackMngControllerTest {
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
	public void testgetOutSourcingList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/trackMng/getOutSourcingList";
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
	public void testgetListData() throws Exception{
		//请求参数：json格式
		//outSourcingId-外协单位id、ower-所有人、insuranceStartTime-保险开始时间、insuranceEndTime-保险结束时间、
		//insuranceCompany-保险公司、annualStartTime-上次年审开始时间、annualEndTime-上次年审结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("outSourcingId", "10");
		//params.put("ower", "李四");
		//params.put("insuranceStartTime", "2016-09-26");
		//params.put("insuranceEndTime", "2019-07-04");
		//params.put("insuranceCompany", "太平洋");
		//params.put("annualStartTime", "2016-08-27");
		//params.put("annualEndTime", "2016-10-27");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/trackMng/getListData";
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
		//type-类型、outSourcingId-外协单位id,0-公司车、no-车头号码、driver-驾驶员、ower-所有人、owerAddress-所有人地址、vin-车辆识别代号、
		//engineNo-发动机号、registerTime-注册时间、size-外部尺寸、insuranceStartTime-保险开始时间、insuranceEndTime-保险到期时间、
		//insuranceCompany-保险公司、annualReviewTime-上次年审日期、standardOilWear-核定油耗、oilDiscountLimit-油的折扣上限、
		//oilDiscountPoint-油的折扣点
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");
		params.put("outSourcingId", "3");
		params.put("no", "苏J 52410");
		params.put("driver", "王五");
		params.put("ower", "李四");
		params.put("owerAddress", "盐城");
		params.put("vin", "JNG568941");
		params.put("engineNo", "123456");
		params.put("registerTime", "2016-01-01");
		params.put("size", "1023");
		params.put("insuranceStartTime", "2016-09-26");
		params.put("insuranceEndTime", "2019-07-04");
		params.put("insuranceCompany", "太平洋");
		params.put("annualReviewTime", "2016-01-01");
		params.put("standardOilWear", "8");
		params.put("oilDiscountLimit", "5000");
		params.put("oilDiscountPoint", "4");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/trackMng/save";
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
		String url = "/basicSetting/trackMng/getDetailData/9";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、type-类型、outSourcingId-外协单位id,0-公司车、no-车头号码、driver-驾驶员、ower-所有人、owerAddress-所有人地址、vin-车辆识别代号、
		//engineNo-发动机号、registerTime-注册时间、size-外部尺寸、insuranceStartTime-保险开始时间、insuranceEndTime-保险到期时间、
		//insuranceCompany-保险公司、annualReviewTime-上次年审日期、standardOilWear-核定油耗、oilDiscountLimit-油的折扣上限、
		//oilDiscountPoint-油的折扣点
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 8);
		params.put("type", "0");
		params.put("outSourcingId", "3");
		params.put("no", "苏J 120353");
		params.put("driver", "王五");
		params.put("ower", "李四");
		params.put("owerAddress", "盐城");
		params.put("vin", "JNG5364128");
		params.put("engineNo", "123456");
		params.put("registerTime", "2016-01-01");
		params.put("size", "1023");
		params.put("insuranceStartTime", "2016-09-26");
		params.put("insuranceEndTime", "2019-07-04");
		params.put("insuranceCompany", "太平洋");
		params.put("annualReviewTime", "2016-01-01");
		params.put("standardOilWear", "8");
		params.put("oilDiscountLimit", "5000");
		params.put("oilDiscountPoint", "4");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/basicSetting/trackMng/update";
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
		String url = "/basicSetting/trackMng/delete/10";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	
}
