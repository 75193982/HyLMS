package com.jshpsoft.test.controller.operationMng;

import java.math.BigDecimal;
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

import com.jshpsoft.domain.TrackInsuranceDetail;
import com.jshpsoft.util.Constants;

/**
 * 保费管理测试
* @author  fengql 
* @date 2016年11月3日 下午1:39:29
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class TrackInsuranceMngControllerTest {
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
	public void testgetStockList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "0");//车头
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/getStockList";
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
		//type-类型、carNumber-货运车牌号、insuranceBillNo-保单号(模糊查询)、status-状态 、startInTime-插入开始时间、endInTime-插入结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("type", "");
		params.put("carNumber", "");
		params.put("insuranceBillNo", "");
		params.put("status", "");
		params.put("startInTime", "");
		params.put("endInTime", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/getListData";
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
	public void testgetInsuranceBean() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("carNumber", "苏J00001");//新建
		params.put("status", Constants.InsuranceStatus.SUBMIT);//已提交
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/getInsuranceBean";
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
		//type-类型、carNumber-货运车牌号、driver-驾驶员、insuranceBillNo-保单号、startTime-保险开始时间、endTime-保险结束时间、
		//amount-总金额、noticeTime-提醒时间、mark-备注 
		//detail [ insuranceName-险种名称、amount-金额、mark-备注 ]
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "1");
		params.put("carNumber", "苏J 120353");
		params.put("driver", "王五");
		params.put("insuranceBillNo", "201611010001");
		params.put("startTime", "2016-11-01");
		params.put("endTime", "2017-11-01");
		params.put("amount", "500");
		params.put("noticeTime", "2017-10-01");
		params.put("mark", "报保险测试");
		/*params.put("type", "0");
		params.put("carNumber", "苏J 120353");
		params.put("driver", "王五");
		params.put("insuranceBillNo", "201611010001");
		params.put("startTime", "2016-11-01");
		params.put("endTime", "2017-11-01");
		params.put("amount", "3000");
		params.put("noticeTime", "2017-10-01");
		params.put("mark", "参加保险测试");
		
		List<TrackInsuranceDetail> list = new ArrayList<TrackInsuranceDetail>();
		TrackInsuranceDetail bps = new TrackInsuranceDetail();
		bps.setInsuranceName("交强险");
		bps.setAmount(new BigDecimal(1000));
		bps.setMark("");
		list.add(bps);
		bps = new TrackInsuranceDetail();
		bps.setInsuranceName("商业险");
		bps.setAmount(new BigDecimal(2000));
		bps.setMark("");
		list.add(bps);
		params.put("detailList", list);*/
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/save";
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
	public void testgetDetail() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackInsuranceMng/getDetail/10";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、type-类型、carNumber-货运车牌号、driver-驾驶员、insuranceBillNo-保单号、startTime-保险开始时间、endTime-保险结束时间、
		//amount-总金额、noticeTime-提醒时间、mark-备注 
		//detail [ insuranceName-险种名称、amount-金额、mark-备注 ]
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 10);
		params.put("type", "0");
		params.put("carNumber", "苏J 120353");
		params.put("driver", "王五");
		params.put("insuranceBillNo", "201611010001");
		params.put("startTime", "2016-11-01");
		params.put("endTime", "2017-11-01");
		params.put("amount", "3500");
		params.put("noticeTime", "2017-10-01");
		params.put("mark", "参加保险测试");
		
		List<TrackInsuranceDetail> list = new ArrayList<TrackInsuranceDetail>();
		TrackInsuranceDetail bps = new TrackInsuranceDetail();
		bps.setInsuranceName("交强险");
		bps.setAmount(new BigDecimal(1000));
		bps.setMark("");
		list.add(bps);
		bps = new TrackInsuranceDetail();
		bps.setInsuranceName("商业险");
		bps.setAmount(new BigDecimal(2000));
		bps.setMark("");
		list.add(bps);
		bps = new TrackInsuranceDetail();
		bps.setInsuranceName("第三责任险");
		bps.setAmount(new BigDecimal(500));
		bps.setMark("");
		list.add(bps);
		params.put("detailList", list);
		
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/update";
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
		String url = "/operationMng/trackInsuranceMng/delete/7";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testsubmit() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackInsuranceMng/submit/12";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testpayInsurance() throws Exception{
		//请求参数：json格式
		//amount-金额、mark-备注
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("amount", "2000");
		params.put("mark", "支付保险");

		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/payInsurance";
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
	public void testclaimPay() throws Exception{
		//请求参数：json格式
		//insuranceId-保险表id、insuranceNo-保单号、amount-金额、mark-备注
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("insuranceId", "12");
		params.put("insuranceNo", "201611010001");
		params.put("amount", "200");
		params.put("mark", "支付保险索赔");

		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/claimPay";
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
	public void testgetPrintData() throws Exception{
		//请求参数：json格式
		//type-类型、carNumber-货运车牌号、insuranceBillNo-保单号(模糊查询)、status-状态 、startInTime-插入开始时间、endInTime-插入结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", "");
		params.put("carNumber", "");
		params.put("insuranceBillNo", "");
		params.put("status", "");
		params.put("startInTime", "");
		params.put("endInTime", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/getPrintData";
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
	public void testgetPayListData() throws Exception{
		//请求参数：json格式
		//type-类型(0,1)、startInTime-插入开始时间、endInTime-插入结束时间
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("type", "0,1");
		params.put("startInTime", "");
		params.put("endInTime", "");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/operationMng/trackInsuranceMng/getPayListData";
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
	public void testgetPayDetailList() throws Exception{
		//请求参数：json格式
		String url = "/operationMng/trackInsuranceMng/getPayDetailList/18";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
}
