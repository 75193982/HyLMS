package com.jshpsoft.test.controller.waybill;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.webAppContextSetup;
import net.sf.json.JSONObject;

import org.apache.commons.codec.CharEncoding;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.context.WebApplicationContext;

import com.jshpsoft.domain.Waybill;
/**
 * 运单管理
 * @author lvhao
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:/spring-servlet.xml","classpath:/applicationContext.xml"})  
@WebAppConfiguration
public class WaybillManageControllerTest {
	private MockMvc mockMvc; 
 	@Autowired  
    private WebApplicationContext wac;
    private MockHttpServletRequest request;  
    @SuppressWarnings("unused")
	private MockHttpServletResponse response;   
    @SuppressWarnings("unused")
	private MockHttpSession session;   
    
   
    @Before    
    public void setUp(){    
        request = new MockHttpServletRequest();      
        request.setCharacterEncoding("UTF-8");      
        response = new MockHttpServletResponse();   
        session = new MockHttpSession();
        this.mockMvc = webAppContextSetup(this.wac).build();  
          
    }  
    
    
	@SuppressWarnings("static-access")
	@Test
	public void insertWaybill() throws Exception {
		Waybill waybill = new Waybill();
		waybill.setType("0");
		waybill.setWaybillNo("201160928154335");
		waybill.setSupplierId(1);
		waybill.setBrand("东风悦达起亚");
		waybill.setCarShopId(2);
		waybill.setSendTime("2015-05-01 12:21:12");
		waybill.setReceiveUser("张三");
		waybill.setReceiveUserMobile("1391278788");
		waybill.setReceiveUserTelephone("445455");
		waybill.setStartAddress("江苏盐城");
		waybill.setTargetCity("北京");
		waybill.setDistance(100);
		JSONObject paramsJson = new JSONObject();
		JSONObject fromObject = paramsJson.fromObject(waybill);	    	
    	mockMvc.perform((post("/waybill/waybillManage/insertWaybill").content(fromObject.toString()).contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.characterEncoding(CharEncoding.UTF_8))).andExpect(status().isOk())  
        .andDo(print());
		
	}
	
	
	@Test
	public void getWaybillList() throws Exception {
		String paramsJson="{\"pageStartIndex\":0,\"pageSize\":10,\"waybillNo\":\"201160928154335\",\"status\":0}";
		mockMvc.perform((post("/waybill/waybillManage/getWaybillList").content(paramsJson).contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.characterEncoding(CharEncoding.UTF_8))).andExpect(status().isOk())  
        .andDo(print());
		
	}
	@Test
	public void deleteWaybill() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/deleteWaybill/5"))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	@Test
	public void getBasicSuppliersList() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/getBasicSuppliersList")).param("id", "2")).andExpect(status().isOk())  
        .andDo(print());
	}
	
	@Test
	public void getCarBrandList() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/getCarBrandList"))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	@Test
	public void getCarShopList() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/getCarShopList"))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	@SuppressWarnings("static-access")
	@Test
	public void updateWaybill() throws Exception {
		Waybill waybill = new Waybill();
		waybill.setId(5);
		waybill.setType("1");
		waybill.setWaybillNo("200000");
		waybill.setSupplierId(2);
		waybill.setBrand("东风悦2达起亚");
		waybill.setCarShopId(2);
		waybill.setSendTime("2015-05-01 22:22:22");
		waybill.setReceiveUser("张2三");
		waybill.setReceiveUserMobile("2222222222");
		waybill.setReceiveUserTelephone("22222222");
		waybill.setStartAddress("江苏盐城2");
		waybill.setTargetCity("北京2");
		waybill.setDistance(200);
		JSONObject paramsJson = new JSONObject();
		JSONObject fromObject = paramsJson.fromObject(waybill);	    	
    	mockMvc.perform((post("/waybill/waybillManage/updateWaybill").content(fromObject.toString()).contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.characterEncoding(CharEncoding.UTF_8))).andExpect(status().isOk())  
        .andDo(print());
	}
	@Test
	public void queryWaybill() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/queryWaybill/34"))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	@Test
	public void queryCarStock() throws Exception {
	
		String paramsJson="{\"pageStartIndex\":0,\"pageSize\":10,\"status\":0,\"waybillId\":60}";
		mockMvc.perform((post("/waybill/waybillManage/queryCarStock").content(paramsJson).contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.characterEncoding(CharEncoding.UTF_8))).andExpect(status().isOk())  
        .andDo(print());
	}
	@Test
	public void bindCarStock() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/bindCarStock/12/1"))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	
	@Test
	public void queryCarAttachment() throws Exception {
		String paramsJson="{\"pageStartIndex\":0,\"pageSize\":10,\"attachmentName\":\"三角\",\"status\":0}";
		mockMvc.perform((post("/waybill/waybillManage/queryCarAttachment").content(paramsJson).contentType(MediaType.APPLICATION_JSON)
				.accept(MediaType.APPLICATION_JSON)
				.characterEncoding(CharEncoding.UTF_8))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	@Test
	public void bindCarAttachment() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/bindCarAttachment/12/1"))).andExpect(status().isOk())  
        .andDo(print());
	}
	@Test
	public void submitWaybill() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/submitWaybill/12"))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	@Test
	public void checkWaybill() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/checkWaybill/12"))).andExpect(status().isOk())  
        .andDo(print());
	}
	@Test
	public void cancelBindCarStock() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/cancelBindCarStock/1"))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	
	@Test
	public void cancelBindCarAttachment() throws Exception {
		
		mockMvc.perform((get("/waybill/waybillManage/cancelBindCarAttachment/1"))).andExpect(status().isOk())  
        .andDo(print());
	}
	
	
}
