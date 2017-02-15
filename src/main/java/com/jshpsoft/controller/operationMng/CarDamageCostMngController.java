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

import com.jshpsoft.domain.CarDamageCostApply;
import com.jshpsoft.service.CarDamageCostMngService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 折损费用申请管理Controller
 * @author army.liu 
 * @date 2016年10月21日 上午11:26:33
 */
@Controller
@RequestMapping("/operationMng/carDamageCostMng")
public class CarDamageCostMngController {
	
	@Autowired  
	private CarDamageCostMngService carDamageCostMngService;
	
	/**
	 * 管理页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/carDamageCostMng/index");		
		return mv;		
	}
	
	/**
	 * 获取列表数据
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		type-类型
	 * 		scheduleBillNo-调度单号
	 * 		carNumber-车号
	 * 		driver-驾驶员
	 * 
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * }
	 * @return
	 * {
	 * 		records [ 
	 * 					id-id号、type-类型：0-直接赔付，1-买断，scheduleBillNo-调度单号、carNumber-车号、driver-驾驶员、attach_file_path-照片路径，多个以;连接、
	 * 					mark-情况说明、bankName-开户行、accountName-名称、accountNo-账号、
	 * 					status-状态、amount-总金额、insurance_flag-是否走保险：Y-有，N-没有、
	 * 					insertUser-插入人、insertTime-插入时间
	 * 				]
	 * 		totalCounts -总记录数
	 * 		totalPages -总页数
	 * 		pageSize -页大小
	 * 		frontParams -前台带过来的参数，不动返回回去的
	 * }
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
			params.put("insertUser", CommonUtil.getUserIdFromSession(request));
			Pager<CarDamageCostApply> pager = carDamageCostMngService.getPageData(params);
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
	 * 保存信息
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 					type-类型：0-直接赔付，1-买断，
	 * 					scheduleBillNo-调度单号、
	 * 					carNumber-车号、
	 * 					driver-驾驶员、
	 * 					attachFilePath-照片路径，多个以;连接、
	 * 					mark-情况说明、
	 * 					bankName-开户行、
	 * 					accountName-名称、
	 * 					accountNo-账号、
	 * 					insurance_flag-是否走保险：Y-有，N-没有、
	 * 					detailList : [
	 * 						{
	 * 							carStockId-车辆库存id
	 *							amount-金额
	 *						}
	 * 					]
	 * }
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarDamageCostApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carDamageCostMngService.save(bean, oper, request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取信息-用于修改
	 * @author  army.liu 
	 * @parameter  id-id号(int) 必传
	 * @return	  bean [
	 * 						id-主键
	 * 						type-类型：0-直接赔付，1-买断，
	 * 						scheduleBillNo-调度单号、
	 * 						carNumber-车号、
	 * 						driver-驾驶员、
	 * 						attachFilePath-照片路径，多个以;连接、
	 * 						mark-情况说明、
	 * 						bankName-开户行、
	 * 						accountName-名称、
	 * 						accountNo-账号、
	 * 						insurance_flag-是否走保险：Y-有，N-没有、
	 * 						insertUser-插入人、insertTime-插入时间
	 * 						detailList : [
	 * 							{
	 * 								carStockId-车辆库存id
	 *								amount-金额
	 *							}
	 * 						]
	 * 						carStockList : [
	 * 							{
	 * 								商品车信息
	 * 								
	 *							}
	 * 						]
	 *				   ]
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
			CarDamageCostApply bean = carDamageCostMngService.getById(id);
			
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
	 * 修改信息
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 					id-id
	 * 					type-类型：0-直接赔付，1-买断，
	 * 					scheduleBillNo-调度单号、
	 * 					carNumber-车号、
	 * 					driver-驾驶员、
	 * 					attachFilePath-照片路径，多个以;连接、
	 * 					mark-情况说明、
	 * 					bankName-开户行、
	 * 					accountName-名称、
	 * 					accountNo-账号、
	 * 					insurance_flag-是否走保险：Y-有，N-没有、
	 * 					detailList : [
	 * 						{
	 * 							carStockId-车辆库存id
	 *							amount-金额
	 *						}
	 * 					]
	 * }
	 * @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarDamageCostApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carDamageCostMngService.update(bean, oper, request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除信息--更新逻辑删除键标志
	 * @author  army.liu 
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
			carDamageCostMngService.delete(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 提交信息
	 * @author  army.liu 
	 * @parameter  id-id号(int) 必传
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
		result.put("msg", "删除失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carDamageCostMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 折损费用申请查询的页面
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/queryIndex",method=RequestMethod.GET)		
	public ModelAndView queryIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/carDamageCostMng/queryIndex");		
		return mv;		
	}
	
	/**
	 * 获取折损费用申请查询的列表数据
	 * @author  army.liu 
	 * @parameter 
	 * {
	 * 		type-类型
	 * 		scheduleBillNo-调度单号
	 * 		carNumber-车号
	 * 		driver-驾驶员
	 * 
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * }
	 * @return
	 * {
	 * 		records [ 
	 * 					id-id号、type-类型：0-直接赔付，1-买断，scheduleBillNo-调度单号、carNumber-车号、driver-驾驶员、attach_file_path-照片路径，多个以;连接、
	 * 					mark-情况说明、bankName-开户行、accountName-名称、accountNo-账号、
	 * 					status-状态、amount-总金额、insurance_flag-是否走保险：Y-有，N-没有、
	 * 					insertUser-插入人、insertTime-插入时间
	 * 				]
	 * 		totalCounts -总记录数
	 * 		totalPages -总页数
	 * 		pageSize -页大小
	 * 		frontParams -前台带过来的参数，不动返回回去的
	 * }
	 */
	@RequestMapping(value = "/getListDataForQuery",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getListDataForQuery(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<CarDamageCostApply> pager = carDamageCostMngService.getPageData(params);
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
	
}
