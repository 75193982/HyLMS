package com.jshpsoft.controller.operationMng;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CashWaitingPayLog;
import com.jshpsoft.service.CashWaitingPayLogService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 待付管理Controller
 * @author  army.liu
 * @date 2016年12月12日 下午16:14:53
 */
@Controller
@RequestMapping("/operationMng/cashWaitingPayLogMng")
public class CashWaitingPayLogMngController {
	
	@Autowired  
	private CashWaitingPayLogService cashWaitingPayLogService;
	
	/**
	 * 待付管理页面
	 * @author  army.liu
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/cashWaitingPayLogMng/index");		
		return mv;		
	}
	
	/**
	 * 获取待付列表数据
	 * @author  army.liu
	 * @date 2016年9月21日 上午10:13:01
	 * @parameter  params [ businessType-业务类(String)、status-状态 (String)、mark-事由(String,模糊查询)、departmentId-部门
	 * 
	 * 						startTime-开始时间(String)、endTime-结束时间(String) 没有值传''
	 * 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	 * 					 ]
	 * 
	 * @return		{
	 * 					records:[ id-id号、departmentId-接收人部门id,receiveUser-接收人id,receiveUserName-接收人名称，businessType-业务类型、mark-事由、money-金额、status-状态（0-未支付，1-已支付）、
	 * 							insertUser-插入人、insertTime-插入时间 、insertUserName-插入人名称
	 * 							udpateUser-支付人、udpateTime-支付时间 、udpateUserName-支付人名称
	 * 							payTime-待付时间，格式转为yyyy-MM-dd
	 * 					]
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
			Pager<CashWaitingPayLog> pager = cashWaitingPayLogService.getPageData(params);
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
	 * 获取待付信息
	 * @author  army.liu
	 * @parameter  id-id号(int) 必传
	 * @return	  bean [ id-id号、departmentId-接收人部门id,receiveUser-接收人id,receiveUserName-接收人名称，businessType-业务类型、mark-事由、money-金额、status-状态（0-未支付，1-已支付）、insertUser-插入人、insertTime-插入时间  ]
	 */
	@RequestMapping(value = "/getDetail/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			CashWaitingPayLog bean = cashWaitingPayLogService.getById(id);
			
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
	 * 支付待付信息
	 * @author  army.liu
	 * @parameter  {
	 * 		id
	 * }
	 * @return
	 */
	@RequestMapping(value = "/pay/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable int id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			cashWaitingPayLogService.pay(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
}
