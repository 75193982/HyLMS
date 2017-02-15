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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.CarDamageStockInOut;
import com.jshpsoft.domain.CarDamageStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarDamageMngService;
import com.jshpsoft.service.CarDamageStockInOutService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 折损车管理Controller
* @author  fengql 
* @date 2016年10月9日 下午5:17:18
 */
@Controller
@RequestMapping("/operationMng/carDamageMng")
public class CarDamageMngController {
	
	@Autowired  
	private CarDamageMngService carDamageMngService;
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private CarDamageStockInOutService carDamageStockInOutService;
	
	
	/**
	 * 折损车管理页面
	* @author  fengql 
	* @date 2016年10月9日 下午5:18:11 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/carDamageMng/index");		
		return mv;		
	}

	/**
	 * 获取折损车列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ brand-品牌(String,模糊查询)、status-状态 (String)  没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、waybillId-运单编号、brand-品牌、vin-车架号、model-车型、color-颜色、engineNo-发动机号、mark-备注、
	 * 								position-停车位置、keyPosition-钥匙存放位置、status-状态  ]
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
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				params.put("stockId", stockId);
				Pager<CarDamageStock> pager = carDamageMngService.getPageData(params);
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
	 * 获取品牌列表信息
	* @author  fengql 
	* @date 2016年10月8日 下午2:29:34 
	* @parameter  
	* @return	List [ id-id号、brandName-名称 ]
	 */
	@RequestMapping(value = "/getBrandList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getBrandList(HttpServletRequest request, 
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
	 * 查询折损车运单(新建状态) status = 0
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
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("type", Constants.WaybillType.ZSC);//2折损车
			params.put("status", Constants.WaibillStatus.NEW.getValue());
			params.put("delFlag", Constants.DelFlag.N);
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			List<Waybill> list = carDamageMngService.getWaybillNo(params);
			
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
	 * 保存折损车信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ waybillId-运单编号(int)、brand-品牌(String)、vin-车架号(String)、model-车型(String)、color-颜色(String)、
	* 					 engineNo-发动机号(String)、mark-备注(String)、position-停车位置(String)、keyPosition-钥匙存放位置(String)]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarDamageStock bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号--根据登录者获取
			if(stockId == null){
				result.put("code", "300");
				result.put("msg", "当前登录人的仓库编号为空");
			}else{
				String oper = CommonUtil.getOperId(request);//操作员
				bean.setStockId(Integer.parseInt(stockId));
				carDamageMngService.save(bean, oper);
				
				result.put("code", "200");
				result.put("msg", "成功");
			}
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取折损车详细信息-用于修改、查看
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [ id-id号、waybillId-运单编号、brand-品牌、vin-车架号、model-车型、color-颜色、engineNo-发动机号、mark-备注、
	 * 					 position-停车位置、keyPosition-钥匙存放位置  ]
	 */
	@RequestMapping(value = "/getcarDamagetList/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getcarDamagetList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			CarDamageStock bean = carDamageMngService.getById(id);
			
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
	 * 修改折损车信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:31:01 
	* @parameter  bean [ id-id号(int)、waybillId-运单编号(int)、brand-品牌(String)、vin-车架号(String)、model-车型(String)、color-颜色(String)、
	* 					 engineNo-发动机号(String)、mark-备注(String)、position-停车位置(String)、keyPosition-钥匙存放位置(String) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CarDamageStock bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			carDamageMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除折损车信息--更新逻辑删除键标志
	* @author  fengql 
	* @date 2016年9月21日 上午10:35:01
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
			carDamageMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 折损车出入库查询
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @parameter  params [ type-类型(String)、status-状态(String) 、startTime-开始时间(String)、endTime-结束时间(String)] 没有值传''
	 * @return	list{   id-id号,type-类型：0-入库，1-出库,business_id-业务编号,count-数量,mark-备注,status-状态：0-新建，1-待复核，2-已完成,
						insertTime-插入时间,insertUser-插入人
						detailList { id-id号,brand-品牌,vin-车架号,model-车型,color-颜色 ,engineNo-发动机号,position-停车位置 }
					  }
	 */
	@RequestMapping(value = "/getInoutList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getInoutList(HttpServletRequest request, 
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
				List<CarDamageStockInOut> list = carDamageMngService.getCarDamageInOutListData(params);
				
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
	 * 查询系统-折损库存查询
	 * @author  ww 
	 * @date 2016年12月19日 下午2:30:18
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/carDamageMng/adminIndex");		
		return mv;		
	}
	
	/**
	 * 折损车库存列表
	 * @author  ww 
	 * @date 2016年12月19日 下午2:33:06
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/getAdminListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAdminListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
				Pager<CarDamageStock> pager = carDamageMngService.getPageData(params);
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
	 * 查询系统-折损出入库查询
	 * @author  ww 
	 * @date 2016年12月19日 下午4:32:15
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminInOutIndex",method=RequestMethod.GET)		
	public ModelAndView adminInOutIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/carDamageMng/adminInOutIndex");		
		return mv;		
	}
	
	/**
	 * 查询系统-折损出入库查询
	 * @author  ww 
	 * @date 2016年12月19日 下午4:50:42
	 * @parameter  params{type-类型( 0-入库、1-出库)   startTime-开始时间、endTime-结束时间}
	 * @return
	 */
	@RequestMapping(value = "/getAdminInOutList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getAdminInOutList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
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
	 * 查询系统-查看明细
	 * @author  ww 
	 * @date 2016年12月19日 下午4:19:36  
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
			Pager<CarDamageStockInOutDetail> pager = carDamageMngService.getDetailByParentId(params);
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
