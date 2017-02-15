package com.jshpsoft.controller.operationMng;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarAttachmentStockInOutAndUser;
import com.jshpsoft.domain.CarAttachmentStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarAttachmentStockService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;


/**
 * 配件入库  Controller
 * @author  ww 
 * @date 2016年9月26日 上午10:35:33
 */
@Controller
@RequestMapping("/operationMng/carAttachmentMng")
public class CarAttachmentMngController {
	
	@Resource
	private CarAttachmentStockService carAttachmentMngService;
	
	/**
	 * 配件库存主页面
	 * @author ww
	 * @date 2016年9月26日 
	 * @parameter  
	 * @return 
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session)
	{
		ModelAndView mv = new ModelAndView("operationMng/carAttachmentMng/index");
		return mv;
	}
	
	/**
	 * 获取运单编号
	 * @author  ww 
	 * @date 2016年10月14日 上午10:16:55
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getWaybillList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getWaybillList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			List<String> listType = new ArrayList<String>();
			listType.add(Constants.WaybillType.SPC);
			listType.add(Constants.WaybillType.ESC);
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("list", listType);
			params.put("status", Constants.WaibillStatus.NEW.getValue());
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			List<Waybill> list = carAttachmentMngService.getWaybillList(params);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 获取配件库存信息
	 * @author  ww 
	 * @date 2016年9月26日 上午11:01:46
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		waybillNo-运单编号,position-存放位置,attachmentName-配件名称,status--状态,NameOrWaybillNo --配件名称或者运单编号
	 * }
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id,stock_id-仓库编号,waybill_id-运单id,waybillNo-运单编号,position-存放位置,attachment_name-配件名称,count-数量,status-状态,mark-备注,insert_time-插入时间 
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
			HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			/*List<String> list = new ArrayList<String>();
			list.add("0");
			list.add("1");
			params.put("typeList", list);*/
			String stockId = CommonUtil.getStockIdFromSession(request);
			params.put("stockId", stockId);		
			Pager<CarAttachmentStock> pager = carAttachmentMngService.getPageData(params);
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
	 * 插入配件库存
	 * @author  ww 
	 * @date 2016年9月26日 下午4:13:23
	 * @parameter  bean[attachmentName-配件名称,count-数量,position-存放位置, waybillId-运单编号,mark--备注]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody CarAttachmentStock bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			/*Map<String, Object> params = new HashMap<String, Object>();
			params.put("waybillId", bean.getWaybillId());
			params.put("position", bean.getPosition());
			params.put("attachmentName", bean.getAttachmentName());
			List<CarAttachmentStock> list = carAttachmentMngService.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				throw new RuntimeException("该数据已存在，请不要重复保存。");
			}*/
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号--根据登录者获取
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));//操作员
			carAttachmentMngService.save(bean,stockId,userId);//配件库存
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 提交(提交保存,状态为待复核)
	 * @author  ww 
	 * @date 2016年9月30日 上午8:32:29
	 * @parameter  bean[attachmentName-配件名称,count-数量,position-存放位置, waybillId-运单编号]
	 * @return
	 */
	/*@RequestMapping(value = "/saveStockInOut",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveStockInOut(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody CarAttachmentStock bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
		
	}*/
	
	/**
	 * 根据配件库存id获取数据
	 * @author  ww 
	 * @date 2016年9月28日 上午11:13:38
	 * @parameter id 
	 * @return list[id,stockId,waybillId.....,inoutId]
	 */
	@RequestMapping(value = "/getCarAttachmentList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCarAttachmentList(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestParam("id") int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			CarAttachmentStock carAttachmentStock = carAttachmentMngService.getById(id);
			result.put("data", carAttachmentStock);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 修改配件库存 (复核后不允许修改) 
	 * @author  ww 
	 * @date 2016年9月28日 下午1:06:54
	 * @parameter  bean[id配件库存id,attachmentName-配件名称,count-数量,position-存放位置, waybillId-运单编号,mark-备注]
	 * @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody CarAttachmentStock bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(String.valueOf(CommonUtil.getUserIdFromSession(request)));
			carAttachmentMngService.update(bean);
			/*CarAttachmentStockInOut carInOut = new CarAttachmentStockInOut();
			carInOut.setId(id);
			carInOut.setAttachmentName(bean.getAttachmentName());
			carInOut.setCount(bean.getCount());
			carInOut.setPosition(bean.getPosition());
			carInOut.setWaybillId(Integer.valueOf(bean.getWaybillId()));
			carInOut.setUpdateTime(new Date());
			carInOut.setUpdateUser(String.valueOf(CommonUtil.getUserIdFromSession(request)));
			carAttachmentStockInOutService.update(carInOut);*/
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
	}
	
	
	/**
	 * 逻辑删除 配件库存(复核后不允许删除)
	 * @author  ww 
	 * @date 2016年9月28日 下午1:55:48
	 * @parameter  id 配件库存id
	 * @return
	 */
	@RequestMapping(value = "/delete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestParam("id") int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));
			params.put("updateUser",userId);
			params.put("updateTime", new Date());
			params.put("delFlag", Constants.DelFlag.Y);
			params.put("id", id);
			carAttachmentMngService.delete(params);
			/*Map<String, Object> params2 = new HashMap<String, Object>();
			params2.put("updateUser",userId);
			params2.put("updateTime", new Date());
			params2.put("delFlag", Constants.DelFlag.Y);
			params2.put("id", inoutId);
			carAttachmentStockInOutService.delete(params2);*/
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
	}
	
	
	/**
	 * 配件出入库查询界面
	 * @author  ww 
	 * @date 2016年9月30日 上午9:39:57
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/indexInOut",method=RequestMethod.GET)
	public ModelAndView loginInOut(HttpServletRequest request, HttpServletResponse response,HttpSession session)
	{
		ModelAndView mv = new ModelAndView("operationMng/carAttachmentMng/indexInOut");
		return mv;
	}
	
	/**
	 * 出入库查询
	 * @author  ww 
	 * @date 2016年9月28日 下午2:14:02
	 * @parameter  {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		startTime-开始时间,endTime-结束时间,businessId-运单编号
	 * }
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-id号、type,waybillId,..... 
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }
	 */
	@RequestMapping(value = "/getInoutList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getInoutList (HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Pager<CarAttachmentStockInOutAndUser> pager = carAttachmentMngService.getInOutPageData(params);
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
	 * 查看明细
	 * @author  ww 
	 * @date 2016年11月8日 下午1:19:36  
	 * @parameter  parentId
	 * @return
	 */
	@RequestMapping(value = "/getDetailByParentId",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDetailByParentId (HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Pager<CarAttachmentStockInOutDetail> pager = carAttachmentMngService.getDetailByParentId(params);
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
	 * 配件库存查询页面
	 * @author  ww 
	 * @date 2016年11月11日 上午9:13:59
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session)
	{
		ModelAndView mv = new ModelAndView("operationMng/carAttachmentMng/adminIndex");
		return mv;
	}
	

	/**
	 * 查看所有的配件库存数据(没有权限控制)
	 * @author  ww 
	 * @date 2016年11月11日 上午9:03:03
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		waybillNo-运单编号,position-存放位置,attachmentName-配件名称,status--状态
	 * }
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id,stockId-仓库编号,waybillId-运单id,waybillNo-运单编号,position-存放位置,attachmentName-配件名称,count-数量,status-状态,mark-备注,insertTime-插入时间 
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }
	 * 
	 */
	@RequestMapping(value = "/getAllListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getAllListData (HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			Pager<CarAttachmentStock> pager = carAttachmentMngService.getPageData(params);
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
}
