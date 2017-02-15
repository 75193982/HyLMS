package com.jshpsoft.controller.basicSetting;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.User;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;
import com.jshpsoft.websocket.SystemWebSocketHandler;

/**
 * 驾驶员设置Controller
 * @author  army.liu 
 * @date 2016年9月13日 下午5:23:12
 */
@Controller
@RequestMapping("/basicSetting/driverMng")
public class DriverMngController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private UserService userService;
	
	@Bean
    public SystemWebSocketHandler systemWebSocketHandler() {
        return new SystemWebSocketHandler();
    }
	
	/**
	 * 驾驶员设置页面
	 * @author  army.liu 
	 * @date 2016年9月13日 下午5:24:13 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/driverMng/index");		

		return mv;		
	}

	/**
	 * 获取驾驶员列表数据 
	 * @author  army.liu 
	 * @date 2016年9月14日 上午9:29:40 
	 * @parameter  params [ 
	 * 						outSourcingName-承运商名称
	 * 						name-姓名
	 * 						mobile-手机号码
	 * 
	 * 					    pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 					 ]
	 * 
	 * @return      {
	 * 					records:[  
	 * 								id-id号、name-姓名、mobile-手机号码、idCard-身份证号、idCardFilePath-身份证上传地址、certificate-从业资格证书、certificateFilePath-从业资格证书上传地址、importLinkman-紧急联系人
	 * 								outSourcingId-承运商id
	 * 								outSourcingName-承运商名称
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("driverFlag", "Y");
			Pager<User> pager = userService.getPageData(params);
			pager.setFrontParams(params.get("sEcho"));
			
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 保存驾驶员信息
	 * @author  army.liu 
	 * @date 2016年9月14日 上午9:50:40 
	 * @parameter  bean [  
	 * 						id-id号、name-姓名、mobile-手机号码、idCard-身份证号、idCardFilePath-身份证上传地址、certificate-从业资格证书、certificateFilePath-从业资格证书上传地址、importLinkman-紧急联系人
	 * 						outSourcingId-承运商id
	 *					]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody User bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			userService.saveForDriver(bean, oper, request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取驾驶员详细信息
	 * @author  army.liu 
	 * @date 2016年9月14日 上午9:55:40 
	 * @parameter  id-id号
	 * @return	  bean [  
	 *						id-id号、name-姓名、mobile-手机号码、idCard-身份证号、idCardFilePath-身份证上传地址、certificate-从业资格证书、certificateFilePath-从业资格证书上传地址、importLinkman-紧急联系人
	 *						outSourcingId-承运商id
	 *						outSourcingName-承运商名称
	 * 					]
	 */
	@RequestMapping(value = "/getDetailData/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetailData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			User bean = userService.getById(id);
			bean.setPassword(null);
			
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除驾驶员信息
	 * @author  army.liu 
	 * @date 2016年9月14日 上午10:10:40  
	 * @parameter  id-id号
	 * @return
	 */
	@RequestMapping(value = "/delete/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "删除失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			userService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
}
