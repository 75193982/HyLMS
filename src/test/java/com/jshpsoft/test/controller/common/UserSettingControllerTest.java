package com.jshpsoft.test.controller.common;

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
 * 用户设置测试
* @author  fengql 
* @date 2016年11月2日 上午9:24:36
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml", "classpath:/applicationContext.xml"})
@WebAppConfiguration
public class UserSettingControllerTest {
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
	public void testgetDepartmentList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/userSetting/getDepartmentList";
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
	public void testgetParent() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/userSetting/getParent";
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
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/userSetting/getStockList";
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
	public void testgetRoleList() throws Exception{
		//请求参数：json格式
		Map<String, Object> params = new HashMap<String, Object>();
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/userSetting/getRoleList";
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
		//searchInfo-查询条件、departmentId-部门id、driverFlag-是否是司机（N-普通员工，Y-司机）
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("pageSize", 100);
		params.put("pageStartIndex", 0);
		params.put("searchInfo", "田七");
		params.put("departmentId", "22");
		params.put("driverFlag", "Y");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/userSetting/getListData";
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
		//workNo-工号、name-姓名、departmentId-部门id、title-职务、brithday-出生日期、sex-性别、telephone-电话号码、mobile-手机号码、
		//shortMobile-集团短号、address-家庭地址、idCard-身份证号、hiredate-入职时间、signmentTime-合同签订日期、salary-工资、driverFlag-是否是司机、
		//discountLimit-折现上限、discountPoint-折扣点、certificate-从业资格证书、stockId-仓库id、parentId-上级id、roleId-角色id
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("workNo", "1023");
		params.put("name", "测试用户");
		params.put("departmentId", "2");
		params.put("title", "总经理");
		params.put("brithday", "1964-01-26");
		params.put("sex", "1");
		params.put("telephone", "");
		params.put("mobile", "13685423694");
		params.put("shortMobile", "623694");
		params.put("address", "江苏盐城");
		params.put("idCard", "");
		params.put("hiredate", "1990-05-26");
		params.put("signmentTime", "1990-05-26");
		params.put("salary", "");
		params.put("driverFlag", "N");
		params.put("discountLimit", "");
		params.put("discountPoint", "");
		params.put("certificate", "");
		params.put("stockId", "");
		params.put("parentId", "");
		params.put("roleId", "9");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/userSetting/save";
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
		String url = "/commonSetting/userSetting/getDetailData/23";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testupdate() throws Exception{
		//请求参数：json格式
		//id-id号、workNo-工号、name-姓名、departmentId-部门id、title-职务、brithday-出生日期、sex-性别、telephone-电话号码、mobile-手机号码、
		//shortMobile-集团短号、address-家庭地址、idCard-身份证号、hiredate-入职时间、signmentTime-合同签订日期、salary-工资、driverFlag-是否是司机、
		//discountLimit-折现上限、discountPoint-折扣点、certificate-从业资格证书、stockId-仓库id、parentId-上级id、roleId-角色id
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 22);
		params.put("workNo", "1023");
		params.put("name", "测试用户");
		params.put("departmentId", "2");
		params.put("title", "总经理1");
		params.put("brithday", "1974-01-26");
		params.put("sex", "1");
		params.put("telephone", "");
		params.put("mobile", "13985425694");
		params.put("shortMobile", "625694");
		params.put("address", "江苏盐城1");
		params.put("idCard", "");
		params.put("hiredate", "1999-05-26");
		params.put("signmentTime", "1999-05-26");
		params.put("salary", "");
		params.put("driverFlag", "N");
		params.put("discountLimit", "");
		params.put("discountPoint", "");
		params.put("certificate", "");
		params.put("stockId", "");
		params.put("parentId", "");
		params.put("roleId", "9");
		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/userSetting/update";
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
		String url = "/commonSetting/userSetting/delete/20";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
	
	@Test
	public void testpasswordReset() throws Exception{
		//请求参数：json格式
		//id号(整型)、password-新密码(字符串)
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", 22);
		params.put("password", "666666");

		String josnStr = JSONObject.fromObject(params).toString();
		
		String url = "/commonSetting/userSetting/passwordReset";
		MockHttpServletRequestBuilder post = MockMvcRequestBuilders.post(url);
		post.content(josnStr)
			.contentType(MediaType.APPLICATION_JSON)
			.accept(MediaType.APPLICATION_JSON)
			.characterEncoding(CharEncoding.UTF_8);
		mockMvc.perform( post )
			   .andExpect( MockMvcResultMatchers.status().isOk() )
			   .andDo( MockMvcResultHandlers.print() );
		
	}
	
	/**
	 * 移动接口--获取用户角色
	* @author  fengql 
	* @date 2016年11月12日 上午9:42:26 
	* @parameter  
	* @return
	 */
	@Test
	public void testgetUserMenuList() throws Exception{
		//请求参数：json格式
		String url = "/mobile/getUserMenuList/4";
		MockHttpServletRequestBuilder get = MockMvcRequestBuilders.get(url);
		mockMvc.perform( get )
		.andExpect( MockMvcResultMatchers.status().isOk() )
		.andDo( MockMvcResultHandlers.print() );
		
	}
}
