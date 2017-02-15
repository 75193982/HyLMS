package com.jshpsoft.controller.operationMng;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.OilCardOperateLog;
import com.jshpsoft.domain.OilCardStock;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.OilCardMngService;
import com.jshpsoft.service.OilCardOperateLogService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 油卡收支信息管理
 * @author  ww 
 * @date 2016年12月23日 下午3:39:13
 */
@Controller
@RequestMapping("/operationMng/oilCardOperateLog")
public class OilCardOperateLogController {
	
	@Autowired
	private OilCardOperateLogService oilCardOperateLogService;
	
	@Autowired  
	private UserService userService;
	
	@Autowired
	private OilCardMngService OilCardMngService;
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年12月23日 下午3:57:13
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/operationMng/oilCardOperateLog/index");		
		return mv;		
	}
	
	/**
	 * 获取领取人信息
	* @author  ww 
	* @date 2016年12月23日 下午4:22:31 
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
	 * 根据使用人查询卡号
	 * @author  ww 
	 * @date 2016年12月23日 下午4:46:19
	 * @parameter  params{receiveUser-使用人id}
	 * @return list{cardNo...}
	 */
	@RequestMapping(value = "/getCardNo",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCardNo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String,Object > params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("delFlag", Constants.DelFlag.N);
			List<OilCardStock> list = OilCardMngService.getByConditions(params);
			
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
	 * 得到分页数据
	 * @author  ww 
	 * @date 2016年12月23日 下午3:58:12
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		type-类型,startTime-创建时间开始,endTime-结束,receiveUserId-使用人id,status（0-新建，1-待确认，2-已提交）
	 * }  
	 * @return
	 * {
	 * 		inCount - 总收入
	 * 		outCount - 总支出
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id(修改传)、 type-类型(0-收入，1-支出)、money-金额、receiveUserId-使用人id、oilCardNo-卡号、mark-备注、status-状态、
	 * 						insertTime-创建时间、insertUser、updateTime、updateUser、
	 * 						delFlag、receiveUserName-使用人、insertUserName、创建人
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			params.put("insertUser", CommonUtil.getOperId(request));
			Pager<OilCardOperateLog> pager = oilCardOperateLogService.getPageData(params);
			List<OilCardOperateLog> list = oilCardOperateLogService.getByConditions(params);
			double inCount =0 ,outCount =  0 ;
			if(null != list && list.size() > 0)
			{
				for (OilCardOperateLog oilp : list) {
					 switch (oilp.getType()) {
					 //0 充值  1消费
					case Constants.OtherContactsType.IN:
						if( !StringUtils.isEmpty( oilp.getMoney()))
						inCount += oilp.getMoney();
						break;
					case Constants.OtherContactsType.OUT:
						if( !StringUtils.isEmpty( oilp.getMoney() ) )
						outCount += oilp.getMoney();
						break;
					default:
						break;
					}
				}
			}
			result.put("inCount", inCount);
			result.put("outCount", outCount);
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		
		return result;
		
	}

	/**
	 * 保存、更新
	 * @author  ww 
	 * @date 2016年12月23日 下午3:58:37
	 * @parameter 
	 * bean [ 
	 * 			id(修改传)、 type-类型(0-收入，1-支出)、money-金额、receiveUserId-使用人id、oilCardNo-卡号、mark-备注
	 * 		]  
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody OilCardOperateLog bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			oilCardOperateLogService.save(bean, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	
	/**
	 * 根据id获取bean
	 * @author  ww 
	 * @date 2016年12月23日 下午4:02:02
	 * @parameter  id
	 * @return bean [ id(修改传)、 type-类型(0-收入，1-支出)、money-金额、receiveUserId-使用人id、oilCardNo-卡号、mark-备注、status-状态、insertTime-创建时间、insertUser
	 * 					delFlag、receiveUserName-使用人、insertUserName、创建人
	 * ] 
	 */
	@RequestMapping(value = "/getById/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getById(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			OilCardOperateLog bean = oilCardOperateLogService.getById(id);
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		
		return result;
		
	}
	
	/**
	 * 删除
	 * @author  ww 
	 * @date 2016年12月23日 下午4:03:18
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/delete/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			oilCardOperateLogService.delete(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 提交
	 * @author  ww 
	 * @date 2016年12月23日 下午4:10:47
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/submit/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			oilCardOperateLogService.submit(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 确认
	 * @author  ww 
	 * @date 2016年12月27日 下午4:11:57
	 * @parameter  id
	 * @return
	 * bean [ id(修改传)、 type-类型(0-收入，1-支出)、jieyu-上期结余、money-金额、receiveUserId-使用人id、oilCardNo-卡号、mark-备注、status-状态、insertTime-创建时间、insertUser
	 * 					delFlag、receiveUserName-使用人、insertUserName、创建人
	 * ] 
	 */
	@RequestMapping(value = "/dosure/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> dosure(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			OilCardOperateLog bean = oilCardOperateLogService.dosure(id, operId);
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 确认保存
	 * @author  ww 
	 * @date 2016年12月27日 下午4:57:29
	 * @parameter  params[money-金额、oilCardNo、id]
	 * @return
	 */
	@RequestMapping(value = "/sureSave", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sureSave(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody Map<String,Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			params.put("updateUser", operId);
			params.put("updateTime", new Date());
			params.put("oper", CommonUtil.getOperId(request));
			oilCardOperateLogService.sureSave(params);
			result.put("code", "200");
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
	 * @date 2016年12月28日 上午10:23:37
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/searchIndex",method=RequestMethod.GET)		
	public ModelAndView searchIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/operationMng/oilCardOperateLog/searchIndex");		
		return mv;		
	}
	
}
