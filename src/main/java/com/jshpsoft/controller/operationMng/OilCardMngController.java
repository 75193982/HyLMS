package com.jshpsoft.controller.operationMng;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.OilCardOperateLog;
import com.jshpsoft.domain.OilCardStock;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.OilCardMngService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 油卡管理Controller
* @author  fengql 
* @date 2016年10月18日 下午3:07:33
 */
@Controller
@RequestMapping("/operationMng/oilCardMng")
public class OilCardMngController {
	
	@Autowired  
	private OilCardMngService oilCardMngService;
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private UserService userService;
	
	/**
	 * 油卡管理页面
	* @author  fengql 
	* @date 2016年10月18日 下午3:47:17 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/oilCardMng/index");		
		return mv;		
	}
	
	/**
	 * 获取油卡列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ type-类型(String)、source-来源(String,模糊查询)、cardType-卡类型(String)、cardNo-卡号(String,模糊查询)、status-状态(String)、
	* 						startTime-开始时间(String)、endTime-结束时间(String)  没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、type-类型、source-来源、cardType-卡类型、cardNo-卡号、money-金额、status-状态、
	 * 								receiveUser-领取人、receiveTime-领取时间、insertTime-插入时间 、updateTime-更新时间]
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
			Pager<OilCardStock> pager = oilCardMngService.getPageData(params);
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
	 * 新增油卡信息
	* @author  fengql 
	* @date 2016年10月18日 下午3:54:46 
	* @parameter   bean [ type-类型(String)、source-来源(String)、cardType-卡类型(String)、cardNo-卡号(String)、money-金额(double)  ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody OilCardStock bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			oilCardMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取油卡详细信息--用于修改、查看，修改时只显示新增时的内容
	* @author  fengql 
	* @date 2016年10月18日 下午3:55:52 
	* @parameter  id-id号(int)  必传
	* @return	bean [ id-id号、type-类型、source-来源、cardType-卡类型、cardNo-卡号、money-金额、status-状态、receiveUser-领取人、receiveTime-领取时间、
	 * 					insertTime-插入时间 、insertUser-插入人、updateTime-更新时间 、updateUser-更新人 ]
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
			OilCardStock bean = oilCardMngService.getById(id);
			
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
	 * 修改油卡信息
	* @author  fengql 
	* @date 2016年10月18日 下午3:59:54 
	* @parameter  bean [ id-id号(int)、type-类型(String)、source-来源(String)、cardType-卡类型(String)、cardNo-卡号(String)、money-金额(double) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody OilCardStock bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			oilCardMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除油卡信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年10月18日 下午4:00:26 
	* @parameter  id-id号(int) 必传
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
			oilCardMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 提交油卡信息
	* @author  fengql 
	* @date 2016年10月18日 下午4:00:26 
	* @parameter  id-id号(int)  必传
	* @return
	 */
	@RequestMapping(value = "/submit/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			oilCardMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 获取领取人信息
	* @author  ww 
	* @date 2016年12月21日 上午9:59:31 
	* @parameter  params{name-姓名}
	* @return	list [id号、name-姓名 departmentName-部门]
	 */
	@RequestMapping(value = "/getReceiveUser",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getReceiveUser(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String,Object > params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			//params.put("driverFlag", "Y");
			List<User> list = userService.getByConditions(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 发放油卡
	* @author  fengql 
	* @date 2016年10月18日 下午4:00:26 
	* @parameter  params [id号(int)、receiveUser-领取人id(String)]
	* @return
	 */
	@RequestMapping(value = "/grant",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> grant(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "发放失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			oilCardMngService.grant(params, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "发放失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 回收油卡
	* @author  fengql 
	* @date 2016年10月18日 下午4:00:26 
	* @parameter  params [id号(int)、money-金额(double)]
	* @return
	 */
	@RequestMapping(value = "/recover",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> recover(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "回收失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			oilCardMngService.recover(params, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "回收失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 油卡充值
	* @author  fengql 
	* @date 2016年10月18日 下午4:00:26 
	* @parameter  params [id号(int)、money-充值金额(double)]
	* @return
	 */
	@RequestMapping(value = "/recharge",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> recharge(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "充值失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			oilCardMngService.recharge(params, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "充值失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取油卡列表数据--用于打印
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ type-类型(String)、source-来源(String,模糊查询)、cardType-卡类型(String)、cardNo-卡号(String,模糊查询)、status-状态(String)、
	* 						startTime-开始时间(String)、endTime-结束时间(String) ]  没有值传''
	* 
	* @return	list [ id-id号、type-类型、source-来源、cardType-卡类型、cardNo-卡号、money-金额、status-状态、receiveUser-领取人、receiveTime-领取时间、
	 * 					insertUser-插入人 、insertTime-插入时间 、updateUser-更新人 、updateTime-更新时间 ]
	 */
	@RequestMapping(value = "/getPrintData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getPrintData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<OilCardStock> list = oilCardMngService.getByConditions(params);
			
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取油卡操作日志
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ cardNo-油卡卡号(String)、mark-备注(String,模糊查询)  没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、cardNo-卡号、money-金额、receiveUser-领取人、 mark-备注、insertTime-插入时间 、updateTime-更新时间]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/queryOilCardLog",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> queryOilCardLog(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<OilCardOperateLog> pager = oilCardMngService.queryOilCardLog(params);
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
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月19日 下午1:12:25 
	* @parameter  params [ type-类型(String)、source-来源(String,模糊查询)、cardType-卡类型(String)、cardNo-卡号(String,模糊查询)、status-状态(String)、
	* 						startTime-开始时间(String)、endTime-结束时间(String) ]  没有值传''
	* 
	* @return	list [ id-id号、type-类型、source-来源、cardType-卡类型、cardNo-卡号、money-金额、status-状态、receiveUser-领取人、receiveTime-领取时间、
	 * 					insertUser-插入人 、insertTime-插入时间 、updateUser-更新人 、updateTime-更新时间 ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("type") String type,
			@RequestParam("source") String source,
			@RequestParam("cardType") String cardType,
			@RequestParam("cardNo") String cardNo,
			@RequestParam("status") String status,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("source", source);
		params.put("cardType", cardType);
		params.put("cardNo", cardNo);
		params.put("status", status);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		Map<String, Object> formatData = oilCardMngService.getExportData(params);

		String fileName = "油卡信息导出Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
	
	/**
	 * 导入
	 * @author  ww 
	 * @date 2016年12月28日 上午11:12:32
	 * @parameter  params[filePath--地址]
	 * @return
	 */
	@RequestMapping(value = "/input",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> input(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String oper = CommonUtil.getOperId(request);
			oilCardMngService.input(request, params,oper);
			result.put("code", 200);
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
	}
	
	
	
	
	
	/**
	 * 查询页面
	 * @author  ww 
	 * @date 2016年12月28日 上午10:13:07
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/searchIndex",method=RequestMethod.GET)		
	public ModelAndView searchIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/oilCardMng/searchIndex");		
		return mv;		
	}
	
}
