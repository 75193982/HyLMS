package com.jshpsoft.controller.operationMng;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.CarDamageStockInOut;
import com.jshpsoft.domain.CarDamageStockInOutDetail;
import com.jshpsoft.service.CarDamageMngService;
import com.jshpsoft.service.CarDamageStockInOutService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 折损车出库登记
 * @author  ww 
 * @date 2016年10月8日 下午12:51:15
 */
@Controller
@RequestMapping("/operationMng/carDamageOutStock")
public class CarDamageStockOutController {
	
	@Resource
	private CarDamageStockInOutService carDamageStockInOutService;
	
	@Autowired  
	private CarDamageMngService carDamageMngService;
	
	/**
	 * 折损车出库登记
	 * @author  ww 
	 * @date 2016年10月8日 下午1:01:21
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session)
	{
		ModelAndView mv = new ModelAndView("/operationMng/carDamageOutStock/index");
		return mv;
	}
	
	/**
	 * 折损车出库管理
	 * @author  ww 
	 * @date 2016年10月10日 下午3:59:49
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/Manageindex",method=RequestMethod.GET)
	public ModelAndView loginManger(HttpServletRequest request, HttpServletResponse response,HttpSession session)
	{
		ModelAndView mv = new ModelAndView("/operationMng/carDamageOutStock/Manageindex");
		return mv;
	}

	/**
	 * 得到折损车出库管理数据
	 * @author  ww 
	 * @date 2016年10月10日 下午4:01:28
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		type --类型
	 * }
	 * @return
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id-id号、type,business_id,mark,status,..... 
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }
	 */
	@RequestMapping(value = "/getCarDamData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCarDamData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			Pager<CarDamageStockInOut> pager = carDamageStockInOutService.getCarDamOutData(params);
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
	 * 得到折损车库存数据（勾选）   折损车库存关联折损车出入库明细的businessId，然后明细关联折损车出入库主表
	 * @author  ww 
	 * @date 2016年10月9日 下午1:53:54
	 * @parameter  params [ carDamInOutId-折损车出入库（出库）id
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return		{
	 * 					records:[ id、waybillId-运单编号....
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getCarDamDataByCarDamInOutId",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getCarDamDataByCarDamInOutId(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号
			params.put("stockId", stockId);
			params.put("delFlag", Constants.DelFlag.N);
			params.put("status", Constants.CarStatus.HASIN);//在库
			params.put("flag", "flag");
			Pager<CarDamageStock> pager = carDamageMngService.getPageDataByCarDamInOutId(params);
			pager.setFrontParams(params.get("sEcho"));
			
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
	 * 根据id得到折损车出库
	 * @author  ww 
	 * @date 2016年10月9日 下午1:55:13
	 * @parameter  id
	 * @return bean[
	 * 				 id,..
	 *              detailList
	 *              {
	 *              	bean[id,parentId...]
	 *              }
	 * ]
	 */
	@RequestMapping(value = "/getById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getById(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestParam("id") int id) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			CarDamageStockInOut  carDamageStockInOut= carDamageStockInOutService.getById(id);
			result.put("data", carDamageStockInOut);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
		
	}
	
	/**
	 * 保存折损车出库
	 * @author  ww 
	 * @date 2016年10月8日 下午2:43:56
	 * @parameter  
	 * 		   bean[mark,
	 * 				detailList
	 * 					{
	 * 						[carStockId,waybillId,brand,vin,model,color,engineNo,position,outAmount]
	 * 					}
	 *      
	 * 
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarDamageStockInOut bean) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			
			String stockId = CommonUtil.getStockIdFromSession(request);
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));
			carDamageStockInOutService.save(bean,stockId,userId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
		
	}
	
	/**
	 * 提交折损车出库
	 * @author  ww 
	 * @date 2016年10月11日 上午10:28:25
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/submit",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam int id) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));
			carDamageStockInOutService.submit(id, userId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
		
	}
	
	/**
	 * 根据parent id得到已经勾选的出库明细
	 * @author  ww 
	 * @date 2016年10月17日 上午10:36:51
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getOutListById",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getOutListById(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam int id) throws Exception
			{
				Map<String, Object> result = new HashMap<String, Object>();
				result.put("code", "300");
				result.put("msg", "获取失败");
				
				try {
					List<CarDamageStockInOutDetail> list = carDamageStockInOutService.getByParentId(id);
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
	 * 修改折损车出库
	 * @author  ww 
	 * @date 2016年10月9日 上午11:29:32
	 * * @parameter  
	 * 		   bean[id,mark
	 * 				detailList
	 * 					{
	 * 						[carStockId,waybillId,brand,vin,model,color,engineNo,position,outAmount]
	 * 					}
	 *      
	 * 
	 * @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarDamageStockInOut bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));
			carDamageStockInOutService.update(bean,userId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 删除折损车出库
	 * @author  ww 
	 * @date 2016年10月9日 下午1:48:34
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/delete",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("id") int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String userId = String.valueOf(CommonUtil.getUserIdFromSession(request));
			carDamageStockInOutService.delete(id,userId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
	}
	
}
