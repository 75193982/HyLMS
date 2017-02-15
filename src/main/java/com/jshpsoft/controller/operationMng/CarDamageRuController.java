package com.jshpsoft.controller.operationMng;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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

import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarAttachmentStockService;
import com.jshpsoft.service.CarDamageMngService;
import com.jshpsoft.service.CarDamageStockInOutService;
import com.jshpsoft.service.WaybillManageService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 折损车入库管理(相当于运单)
 * @author  ww 
 * @date 2016年10月18日 上午11:10:19
 */
@Controller
@RequestMapping("/operationMng/carDamageInStock")
public class CarDamageRuController {
	
	@Resource
	private CarDamageStockInOutService carDamageStockInOutService;
	
	@Autowired
	private WaybillManageService waybillManageService;
	
	@Autowired
	private CarAttachmentStockService carAttachmentStockService;
	
	@Autowired  
	private CarDamageMngService carDamageMngService;
	
	/**
	 * 折损车入库
	 * @author  ww 
	 * @date 2016年10月18日 上午11:12:10
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session)
	{
		ModelAndView mv = new ModelAndView("/operationMng/carDamageInStock/index");
		return mv;
	}

	/**
	 * 得到折损入库数据
	 * @author  ww 
	 * @date 2016年10月18日 下午12:53:50
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		type --类型 0     vin--车架号，     brand--品牌
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
	@RequestMapping(value = "/getListRuData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getListRuData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			Pager<Waybill> pager = carDamageStockInOutService.getRuPageData(params);
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
		
	}
	
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Waybill bean) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String stockId = CommonUtil.getStockIdFromSession(request);
			int userId = CommonUtil.getUserIdFromSession(request);;
			carDamageStockInOutService.saveRu(bean, stockId, userId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
		
	}
	
	/**
	 * 按id查询运单
	 * 
	 * @author ww
	 * @date 2016年10月19日 
	 * @param id-运单id
	 * @return{    type 类型：2 折损车,waybillNo 入库单号, mark 入库原因
	 * 
	 * 				supplierId 供应商id ,amount - 结算总金额,carShopName-经销商名称,
	 * 				supplierName-供应商名称
	 *            ,brand 品牌,carShopId 4S店编号, sendTime 发运日期,receiveUser
	 *            接车联系人,receiveUserTelephone 接车联系人电话,receiveUserMobile
	 *            接车联系人手机, startAddress 出发地, targetProvince-目的省、targetCity-目的地, distance 总路程
	 *            
	 *            code-200，msg-保存成功}
	 * @throws Exception
	 */
	@RequestMapping(value = "/queryWaybill/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> queryWaybill(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, @PathVariable int id)
			throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			Waybill waybill = waybillManageService.queryWaybill(id);
			result.put("data", waybill);
			result.put("code", "200");
			result.put("msg", "获取成功");	

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败" );
		}
		return result;
	}
	
	/**
	 * 修改运单
	 * 
	 * @author ww
	 * @date 2016年10月19日 
	 * @param { id-运单id ,mark  }
	 * @return {code，msg}
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateWaybill", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateWaybill(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@RequestBody Waybill waybill) throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");

		try {
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT);
			waybill.setUpdateTime(simpleDateFormat.format(new Date()));
			int userId = CommonUtil.getUserIdFromSession(request);
			waybill.setUpdateUser(String.valueOf( userId ));
			int resultCode =waybillManageService.updateWaybill(waybill, request);
			if(resultCode == -1){
				result.put("msg", "修改失败:该运单不是新建状态");
			}else{
				result.put("code", "200");
				result.put("msg", "修改成功");
			}
		

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "修改失败");
		}
		return result;
	}
	
	/**
	 * 删除运单
	 * 
	 * @author ww
	 * @date 2016年10月19日 
	 * @param id-运单id
	 * @return{code，msg}
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteWaybill/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> deleteWaybill(HttpServletRequest request,
			HttpServletResponse response, HttpSession session, @PathVariable int id)
			throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");

		try {
			carDamageStockInOutService.deleteWaybill(id);
			result.put("code", "200");
			result.put("msg", "删除成功");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "删除失败" );
		}
		return result;
	}
	
	/**
	 * 绑定折损车
	 * @author  ww 
	 * @date 2016年10月19日 下午1:52:43
	 * @parameter 前台传参数 waybillId, list:id1,id2,id3...       
	 * @return
	 */
	@RequestMapping(value = "/bindCarDamStock",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> bindCarDamStock(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			String ids = params.get("list").toString();
			List<String> list = new ArrayList<String>();
			for(int i = 0;i<ids.split(",").length;i++)
			{
				list.add(ids.split(",")[i]);
			}
			params.put("list", list);
			carDamageStockInOutService.bindCarDamStock(params);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
		
	}
	
	/**
	 * 获取折损车库存数据
	 * @author  ww 
	 * @date 2016年11月9日 上午10:45:41
	 *  @parameter  params [ waybillId-运单号 ,vin-车架号
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
	@RequestMapping(value = "/queryDamCarStock",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getDamCarListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号
			params.put("stockId", stockId);
			params.put("delFlag", Constants.DelFlag.N);
			params.put("status", Constants.WaibillStatus.NEW.getValue());
			params.put("flag", "flag");			
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
	 * 校验查询折损车中入库单号
	 * @author  ww 
	 * @date 2016年10月19日 下午3:38:36
	 * @parameter  waybillId
	 * @return
	 */
	@RequestMapping(value = "/checkRuWaybillId",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkRuWaybillId(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			params.put("delFlag", Constants.DelFlag.N);
			params.put("status", Constants.CarStatus.NEW);
			List<CarDamageStock> list = carDamageStockInOutService.checkRuWaybillId(params);
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
	 * 校验查询折损派件中入库单号
	 * @author  ww 
	 * @date 2016年10月20日 上午10:46:26
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/checkRuAttWaybillId",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> checkRuAttWaybillId(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			//params.put("delFlag", Constants.DelFlag.N);
			params.put("status", Constants.CarAttchmentStockStatus.NEW);
			List<CarAttachmentStock> list = carAttachmentStockService.checkRuAttWaybillId(params);
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
	 * 获取折损配件的库存数据
	 * @author  ww 
	 * @date 2016年11月9日 下午12:56:04
	 * @parameter  
	 * {
	 * 		waybill_id -运单号，attachmentName-配件名称
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		
	 * }  
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id,stockId-仓库编号,waybillId-运单编号,position-存放位置,attachmentName-配件名称,count-数量,status-状态,mark-备注
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }
	 */
	@RequestMapping(value = "/queryDamAttachment",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getDamAttListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			//仓库编号
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			//新建状态
			params.put("status", Constants.WaibillStatus.NEW.getValue());
			params.put("flag", "flag");
			Pager<CarAttachmentStock> pager = carAttachmentStockService.getPageDataDam(params);
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "获取成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败");	
		}
		return result;
		
	}
	
	
	/**
	 * 绑定配件
	 * @author  ww 
	 * @date 2016年10月19日 下午1:52:43
	 * @parameter 前台传参数 waybillId, list:id1,id2,id3...       
	 * @return
	 */
	@RequestMapping(value = "/bindDamAttStock",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> bindDamAttStock(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception 
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			String ids = params.get("list").toString();
			List<String> list = new ArrayList<String>();
			for(int i = 0;i<ids.split(",").length;i++)
			{
				list.add(ids.split(",")[i]);
			}
			params.put("list", list);
			carDamageStockInOutService.bindDamAttachment(params);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());
		}
		return result;
		
	}
	
	/**
	 * 提交运单
	 * @author ww
	 * @date 2016年10月19日 
	 * @param {id-运单id }
	 * @return {}
	 * @throws Exception
	 */
	@RequestMapping(value = "/submitWaybill/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submitWaybill(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@PathVariable int id) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");

		try {
			params.put("id", id);
			params.put("operId", CommonUtil.getUserIdFromSession(request));
			
			int waybill = carDamageStockInOutService.submitWaybill(params);
			if(waybill > 0 ){
				result.put("code", "200");
				result.put("msg", "提交成功");
			}else if(waybill == -1){
				result.put("msg", "失败：该入库单未绑定折损车");
			}

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "提交失败：" + e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查看入库单绑定的商品车、配件
	 * 
	 * @author ww
	 * @date 2016年10月20日 下午3:25:30
	 * @param {id-入库单id }
	 * @return data:{id-主键 ， waybillNo-运单编号,mark,...
	 *         "carDamageStockList(绑定的商品车)":[{ brand 品牌
	 *         vin 车架号  model 车型 color 颜色 engine_no 发动机号 mark 备注  status
	 *         状态：0-新建(默认)，1-待复核，2-已入库，3-已出库      }]
	 *         "carAttachmentStockList(配件)":[{id 主键，
	 *         attachmentName 配件名称 count 数量 status 状态：0-新建，1-待复核，2-已入库，3-已出库
	 *         mark 备注}]
	 *         
	 *         }
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkWaybill/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> checkWaybill(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@PathVariable int id) throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");

		try {
			Waybill waybill = carDamageStockInOutService.checkWaybill(id);
			result.put("data", waybill);
			result.put("code", "200");
			result.put("msg", "成功");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败：" + e.getMessage());
		}
		return result;
	}
	
}
