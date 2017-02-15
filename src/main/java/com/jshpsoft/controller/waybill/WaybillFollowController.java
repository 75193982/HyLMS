package com.jshpsoft.controller.waybill;

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

import com.jshpsoft.domain.Waybill;
import com.jshpsoft.domain.WaybillLog;
import com.jshpsoft.service.WaybillFollowService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 运单跟踪
* @author  fengql 
* @date 2016年11月26日 下午1:45:21
 */
@Controller
@RequestMapping("/waybill/waybillFollow")
public class WaybillFollowController {

	@Autowired  
	private WaybillFollowService waybillFollowService;
	
	/**
	 * 汽运单跟踪页面
	* @author  fengql 
	* @date 2016年9月21日 上午10:10:01
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("waybill/waybillFollow/index");		
		return mv;		
	}

	/**
	 * 获取运单信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ waybillNo-运单号(String,模糊 查询)、startTime-开始时间(String)、endTime-结束时间(String) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、waybillNo-原始运单编号、supplierName-供应商名称、brand-品牌、carShopName-经销单位、startAddress-出发地、
	 * 							  targetProvince-目的省、targetCity-目的地、sendTime-发运日期、insertTime-插入时间、status-状态(2待回执3已完成) ]
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
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号--根据登录者获取
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前用户对应的仓库信息未设置！");
			}else{
				params.put("stockId", stockId);
				params.put("statusIn", Constants.WaibillStatus.UNRECEIPT.getValue()+","+Constants.WaibillStatus.FINISHED.getValue());
				Pager<Waybill> pager = waybillFollowService.getPageData(params);
				pager.setFrontParams(params.get("sEcho"));
				
				result.put("data", pager);
				result.put("code", "200");
				result.put("msg", "成功");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取运单跟踪信息-用于更新、查看
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01 
	* @parameter  waybillId-运单id(int)  必传
	* @return	  bean [  waybillId运单id、trackingNo-快递单号、backTrackingNo-寄回快递单号、mark-备注  ]
	 */
	@RequestMapping(value = "/getByWaybillId/{waybillId}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getByWaybillId(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer waybillId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			WaybillLog bean = waybillFollowService.getByWaybillId(waybillId);
			
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
	 * 更新运单跟踪信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:31:01 
	* @parameter  bean [  waybillId运单id、trackingNo-快递单号、backTrackingNo-寄回快递单号、mark-备注  ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody WaybillLog bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "更新失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			waybillFollowService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "更新失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 完成确认运单跟踪
	* @author  fengql 
	* @date 2016年9月21日 上午10:35:01
	* @parameter  waybillId-运单id(int)  必传
	* @return
	 */
	@RequestMapping(value = "/sure/{waybillId}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> sure(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer waybillId
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "完成确认失败");
		
		try{
			waybillFollowService.sure(waybillId);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "完成确认失败："+e.getMessage());		
		}		
		return result;
	}
	
}
