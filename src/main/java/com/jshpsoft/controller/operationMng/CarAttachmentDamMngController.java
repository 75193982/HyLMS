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
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarAttachmentStockService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 折损配件库存
 * @author  ww 
 * @date 2016年10月17日 下午5:04:41
 */
@Controller
@RequestMapping("/operationMng/carAttachmentDamMng")
public class CarAttachmentDamMngController {
	
	@Resource
	private CarAttachmentStockService carAttachmentMngService;
	
	/**
	 * 折损配件库存主页
	 * @author  ww 
	 * @date 2016年10月17日 下午5:06:55
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session)
	{
		ModelAndView mv = new ModelAndView("operationMng/carAttachmentDamMng/index");
		return mv;
	}
	
	/**
	 * 得到入库单号
	 * @author  ww 
	 * @date 2016年10月18日 上午9:53:48
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
			listType.add("2");
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("list", listType);
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
	 * 获取折损配件库存数据
	 * @author  ww 
	 * @date 2016年10月18日 上午9:56:06
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		waybillNo-入库单号,position-存放位置,attachmentName-配件名称,status--状态
	 * }
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id,stock_id-仓库编号,waybill_id-运单id,waybillNo-入库单号,position-存放位置,attachment_name-配件名称,count-数量,status-状态,mark-备注,insert_time-插入时间 
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
			//List<String> list = new ArrayList<String>();
			//list.add("2");
			//params.put("typeList", list);
			String stockId = CommonUtil.getStockIdFromSession(request);
			params.put("stockId", stockId);		
			Pager<CarAttachmentStock> pager = carAttachmentMngService.getPageDataDam(params);
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
	 * 保存
	 * @author  ww 
	 * @date 2016年10月18日 上午9:58:04
	 * @parameter   bean[attachmentName-配件名称,count-数量,position-存放位置, waybillId-入库单号,mark--备注]
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
			//Map<String, Object> params = new HashMap<String, Object>();
			/*params.put("waybillId", bean.getWaybillId());
			params.put("position", bean.getPosition());
			params.put("attachmentName", bean.getAttachmentName());
			List<CarAttachmentStock> list = carAttachmentMngService.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				throw new RuntimeException("该数据已存在，请不要重复保存。");
			}*/
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号--根据登录者获取
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));//操作员
			carAttachmentMngService.saveZS(bean,stockId,userId);//配件库存
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 根据配件id得到数据
	 * @author  ww 
	 * @date 2016年10月18日 上午10:54:00
	 * @parameter  
	 * @return
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
			carAttachmentMngService.updateZS(bean);
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
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
	}
	

}
