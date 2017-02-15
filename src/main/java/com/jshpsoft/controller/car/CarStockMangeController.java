package com.jshpsoft.controller.car;

import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.CarStockInOut;
import com.jshpsoft.domain.CarStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarStockMangeService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 商品车库存管理
 * @author lvhao
 *
 */
@Controller
@RequestMapping("/car/carStockMange")
public class CarStockMangeController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private CarStockMangeService carStockMangeService;
	
	/**
	 * 商品车入库页面
	 *@author  lvhao 
	 * @date 2016年9月24日 下午2:04:20 
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("car/carStockMange/index");		
		return mv;		
	}
	/**
	 * 商品车维护页面
	 * @author gll
	 * @date 2016年12月30日 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws IOException
	 */
   @RequestMapping(value="/maintainIndex",method=RequestMethod.GET)
   public ModelAndView maintainIndex(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException{
	   ModelAndView mv=new ModelAndView("car/carStockMange/maintainIndex");
	   return mv;
	   
   }
	/**
	 * 查询所有品牌
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @return {id-主键 ， brandName-品牌名称}
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryCarBrand",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> queryCarBrand(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<CarBrand> list = commonService.getCarBrandList(params);
			
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
	 * 查询运单(新建状态) status = 0
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @return {id、waybillNo-运单编号}
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryWaybill",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> queryWaybill(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				Map<String, Object> params = new HashMap<String, Object>();
				//params.put("type", Constants.WaibillType.SPC);//0商品车
				List<String> listType = new ArrayList<String>();
				listType.add(Constants.WaybillType.SPC);
				listType.add(Constants.WaybillType.ESC);
				params.put("list", listType);
				params.put("status", Constants.WaibillStatus.NEW.getValue());
				//params.put("delFlag", Constants.DelFlag.N);
				params.put("stockId", stockId);
				List<Waybill> list = carStockMangeService.getWaybillNo(params);
				
				result.put("data", list);
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
	 * 商品车入库
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @parameter bean{ 
						type - 类型：0-商品车(默认)，1-二手车
						waybillId 运单id  
						brand 品牌
						vin 车架号
						model 车型
						color 颜色
						engineNo 发动机号
						position 停车位置
						keyPosition 钥匙存放位置
						mark 备注
						storageTime 入库时间
						afterFlag 是否为后(补)入库：Y-是，N-否 (默认)
					  }
	 * @return	{code:200,msg：}
	 */
	@RequestMapping(value = "/carStockIn",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> carStockIn(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarStock bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "入库失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				String oper = CommonUtil.getOperId(request);//操作员
				
				carStockMangeService.carStockIn(bean, stockId, oper);
				
				result.put("code", "200");
				result.put("msg", "成功");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "入库失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 库存管理--获取商品车信息
	* @author  fengql 
	* @date 2016年9月28日 下午2:27:03 
	* @parameter  params [ type-类型、brand-品牌、status-状态
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return		{
	 * 					records:[ id、type-类型、waybillNo-运单编号、supplierName-供应商名称、brand-品牌、vin-车架号、model-车型、color-颜色、
	* 								engineNo-发动机号、mark-备注、status-状态、storageTime-入库时间、afterFlag-是否为后(补)入库：Y-是，N-否
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getCarListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarListData(HttpServletRequest request, 
			HttpServletResponse response,Integer id ,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{

				params.put("stockId", stockId);
				Pager<CarStock> pager = carStockMangeService.getPageData(params);
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
	 * 查看商品车
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @parameter {id-商品车id}
	 * @return	bean { 	id-商品车id,type - 类型：0-商品车(默认)，1-二手车,waybillId -运单id,waybillNo-运单原始编号,brand-品牌,
						vin -车架号,model -车型,color -颜色,engineNo -发动机号,position -停车位置,mark-备注,
						storageTime-入库时间,afterFlag-是否为后(补)入库：Y-是，N-否
					  }
	 */
	@RequestMapping(value = "/queryCarStock/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> queryCarStock(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			CarStock bean = carStockMangeService.getById(id);
			
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
	 * 编辑商品车
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @parameter bean { id-商品车id,type - 类型：0-商品车(默认)，1-二手车,waybillId -运单id,brand -品牌,vin -车架号,
					     model -车型,color -颜色,engineNo -发动机号,position -停车位置,mark -备注
						storageTime - 入库时间
						afterFlag - 是否为后(补)入库：Y-是，N-否 }
	 * @return	
	 */
	@RequestMapping(value = "/editCarStock",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> editCarStock(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarStock bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carStockMangeService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 删除商品车
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @parameter {id 商品车id
					}
	 * @return	{code:200,msg：}
	 */
	@RequestMapping(value = "/deleteCarStock/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> deleteCarStock(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carStockMangeService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 商品出入库查询页面
	 * @author  ww 
	 * @date 2016年11月8日 下午2:59:37
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/carChuRuIndex",method=RequestMethod.GET)		
	public ModelAndView carChuRuIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("car/carStockMange/carChuRuIndex");		
		return mv;		
	}
	
	/**
	 * 商品车出入库查询
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @parameter {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		startTime-开始时间,endTime-结束时间,businessId-业务编号,type 类型
	 * }
	 * @return	list{   id-id号,type-类型：0-入库，1-出库,business_id-业务编号,count-数量,mark-备注,status-状态：0-新建，1-待复核，2-已完成,
						insertTime 插入时间,insertUser 插入人
						detailList { id-id号,waybillNo-运单原始编号,brand-品牌,vin-车架号,model-车型,color-颜色 ,
									engineNo-发动机号,position-停车位置,keyPosition-钥匙存放位置	}
					  }
	 */
	@RequestMapping(value = "/queryCarStockInOut",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> queryCarStockInOut(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				params.put("stockId", stockId);
				params.put("delFlag", Constants.DelFlag.N);
				Pager<CarStockInOut> pager = carStockMangeService.getCarInOutListData(params);
				
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
			Pager<CarStockInOutDetail> pager = carStockMangeService.getCarInOutListDetail(params);
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
	 * 商品车库存查询页面
	 * @author  ww 
	 * @date 2016年11月11日 上午9:15:26
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("car/carStockMange/adminIndex");		
		return mv;		
	}
	
	
	/**
	 * 商品车库存查询(没有权限)
	 * @author  ww 
	 * @date 2016年11月11日 上午9:16:51
	 * @parameter  
	 * params [ type-类型、brand-品牌、status-状态
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* @return		{
	 * 					records:[ id、type-类型、waybillNo-运单编号、supplierName-供应商名称、brand-品牌、vin-车架号、model-车型、color-颜色、
	* 								engineNo-发动机号、mark-备注、status-状态
	* 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getAllCarListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAllCarListData(HttpServletRequest request, 
			HttpServletResponse response,Integer id ,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<CarStock> pager = carStockMangeService.getPageData(params);
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
