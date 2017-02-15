package com.jshpsoft.controller.waybill;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarAttachmentStockService;
import com.jshpsoft.service.CarStockMangeService;
import com.jshpsoft.service.CarStockService;
import com.jshpsoft.service.WaybillManageService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 运单管理
 * 
 * @author lvhao
 * 
 */
@Controller
@RequestMapping("/waybill/waybillManage")
public class WaybillManageController {
	@Autowired
	private WaybillManageService waybillManageService;
	@Autowired
	private CommonService commonService ;
	@Autowired
	private CarStockService CarStockService;
	@Autowired
	private CarStockMangeService carStockMangeService;
	@Autowired
	private CarAttachmentStockService carAttachmentMngService;

	/**
	 * 运单管理页面
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午2:04:20
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView login(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		ModelAndView mv = new ModelAndView("waybill/waybillManage/index");
		return mv;
	}

	/**
	 * 运单维护页面
	 * 
	 * @author gll
	 * @date 2016年12月30日 下午2:04:20
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/maintainIndex", method = RequestMethod.GET)
	public ModelAndView maintainIndex(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws IOException {
		ModelAndView mv = new ModelAndView("waybill/waybillManage/maintainIndex");
		return mv;
	}
	/**
	 * 获取所有供应商
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param 
	 * @return{id-主键 ，name-名称}
	 * @throws Exception
	 */
	@RequestMapping(value = "/getBasicSuppliersList", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getBasicSuppliersList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");

		try {
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			List<Supplier> suppliersList = commonService.getBasicSuppliersList(params);
			result.put("data", suppliersList);
			result.put("code", "200");
			result.put("msg", "获取成功");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败" );
		}
		return result;
	}
	
	
	
	
	
	/**
	 * 获取所有品牌
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param 
	 * @return{id-主键 ，brandName-名称}
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCarBrandList", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getCarBrandList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");

		try {
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			List<CarBrand> carBrandList = commonService.getCarBrandList(params);
			result.put("data", carBrandList);
			result.put("code", "200");
			result.put("msg", "获取成功");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败" );
		}
		return result;
	}
	
	
	
	
	
	/**
	 * 获取所有经销商
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param 
	 * @return{id-主键 ，name-名称、province-省份、city-城市}
	 * @throws Exception
	 */
	@RequestMapping(value = "/getCarShopList", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getCarShopList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session)
			throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");

		try {
			
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			List<CarShop> carShopList = commonService.getCarShopList(params);
			result.put("data", carShopList);
			result.put("code", "200");
			result.put("msg", "获取成功");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败" );
		}
		return result;
	}

	
	/**
	 * 获取运单列表数据
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * 
	 * @parameter{
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的(移动端不需要传)
	 * 		waybillNo -运单号(移动端不需要)
	 * 		status -状态：0-新建，1-待复核，2-已复核，3-已回执，4-已结算
	 * }
	 * @return
	 * {"data":{        totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 					"records":[id-主键 ， waybillNo-运单编号 ，type 类型：0-正常新车，1-二手车，2-折损车
	 *         ,supplierName-供应商名称,brand-品牌,carShopName-经销单位,brandName -品牌名称
	 *         startAddress出发地(二手车用到) ,  targetProvince-目的省、targetCity-目的地(二手车用到)
	 *         ,sendTime-发运日期,status -状态，insertTime-插入时间
	 *         
	 *         ],"frontParams":null},
	 *         
	 *         "code":"200","msg":"成功"}
	 *  	
	 */
	@RequestMapping(value = "/getWaybillList", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getWaybillList(HttpServletRequest request,
			@RequestBody Map<String, Object> params,
			 HttpSession session)
			throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
	
		try {
			params.put("status", params.get("status").toString());
			params.put("delFlag", Constants.DelFlag.N);
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			params.put("insertUser", CommonUtil.getOperId(request));
			Pager<Waybill> pager = waybillManageService.getWaybillList(params);
			pager.setFrontParams(params.get("sEcho"));
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败");
		}
		return result;
	}

	/**
	 * 插入运单
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @parameter {type 类型：0-正常新车(默认)，1-二手车,waybillNo 运单编号, supplierId 供应商id ,amount - 结算总金额
	 *            ,brand 品牌,carShopId 4S店编号, sendTime 发运日期,receiveUser
	 *            接车联系人,receiveUserTelephone 接车联系人电话,receiveUserMobile
	 *            接车联系人手机, startProvince 出发地省份，startAddress 出发地, targetProvince-目的省、targetCity-目的地, distance 总路程 
	 *            attachFileName-扫描件名称
	 *            attachFilePath-扫描件上传地址
	 *            }
	 * @return {code，msg}
	 */
	@RequestMapping(value = "/insertWaybill", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertWaybill(HttpServletRequest request,
			HttpServletResponse response, @RequestBody Waybill waybill,
			HttpSession session) throws Exception {

		Map<String, Object>  result= new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");

		try {
			if(waybill.getType().equals(Constants.WaybillType.ESC)){
				waybill.setWaybillNo(CommonUtil.getWaybillNo());
			}
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT);
			waybill.setInsertTime(simpleDateFormat.format(new Date()));
			waybill.setDelFlag(Constants.DelFlag.N);
			int userId = CommonUtil.getUserIdFromSession(request);
			String stockId = CommonUtil.getStockIdFromSession(request);
			waybill.setInsertUser(String.valueOf(userId));
			waybill.setStockId(null == stockId ? null :Integer.parseInt(stockId));
			waybillManageService.insertWaybill(waybill, request);			
			result.put("code", "200");
			result.put("msg", "保存成功");					

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "保存失败");
		}
		return result;
	}

	/**
	 * 按id查询运单
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param id-运单id
	 * @return{    type 类型：0-正常新车(默认)，1-二手车,waybillNo 运单编号, supplierId 供应商id ,amount - 结算总金额,carShopName-经销商名称,
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
	 * 删除运单
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
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
		result.put("msg", "删除失败");

		try {
			int resultCode = waybillManageService.deleteWaybill(id);
			if(resultCode == -1){
				result.put("msg", "删除失败:该运单不是新建状态");
			}else if(resultCode == -2){
				result.put("msg", "删除失败:该运单下存在商品车，请先解绑");
			}else if(resultCode == -3){
				result.put("msg", "删除失败:该运单下存在零配件，请先解绑");
			}else{
				result.put("code", "200");
				result.put("msg", "删除成功");
			}
			
			
			

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "删除失败" );
		}
		return result;
	}

	/**
	 * 修改运单
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param { id-运单id type 类型：0-正常新车(默认)，1-二手车,waybillNo 运单编号, supplierId 供应商id ,amount - 结算总金额
	 *            ,brand 品牌,carShopId 4S店编号, sendTime 发运日期,receive_user
	 *            接车联系人,receiveUserTelephone 接车联系人电话,receiveUserMobile
	 *            接车联系人手机, startProvince 出发地省份，startAddress 出发地,  targetProvince-目的省、targetCity-目的地, distance 总路程 ,
	 *            attachFileName-扫描件名称
	 *            attachFilePath-扫描件上传地址
	 *             }
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
	 * 获取能绑定商品车信息
	* @author  lvhao 
	* @date 2016年9月28日 下午2:27:03 
	* @parameter  params [ waybillId-运单号 ,type-类型、vin-车架号、status-状态
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
	@RequestMapping(value = "/queryCarStock",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getCarListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			String stockId = CommonUtil.getStockIdFromSession(request);//仓库编号
			params.put("stockId", stockId);
			params.put("delFlag", Constants.DelFlag.N);
			params.put("status", Constants.WaibillStatus.NEW.getValue());
			params.put("flag", "flag");			
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
	
	
	
	
	
	/**
	 * 移动端绑定商品车
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param {wabillId-运单id ids-商品车id串以逗号分隔 }
	 * @return {code，msg}
	 * @throws Exception
	 */
	@RequestMapping(value = "/bindCarStock/{waybillId}/{ids}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> bindCarStock(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@PathVariable int waybillId ,@PathVariable String ids) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "绑定失败");

		try {
			params.put("waybillId", waybillId);
			params.put("ids", ids);
			int bindCarStock = CarStockService.bindCarStock(params);
			if(bindCarStock>0){
				result.put("code", "200");
				result.put("msg", "绑定成功");
			}
			

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "绑定失败：");
		}
		return result;
	}

	/**
	 * web端绑定商品车
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param {wabillId-运单id ids-商品车id串以逗号分隔 }
	 * @return {code，msg}
	 * @throws Exception
	 */
	@RequestMapping(value = "/batchBindCarStock/{waybillId}/{ids}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> batchBindCarStock(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@PathVariable int waybillId ,@PathVariable String ids) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "绑定失败");

		try {
			params.put("waybillId", waybillId);
			params.put("ids", ids);
			int bindCarStock = CarStockService.batchBindCarStock(params);
			if(bindCarStock>0){
				result.put("code", "200");
				result.put("msg", "绑定成功");
			}
			

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "绑定失败");
		}
		return result;
	}

	
	/**
	 * 取消绑定商品车
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param {id-商品车id }
	 * @return {code，msg}
	 * @throws Exception
	 */
	@RequestMapping(value = "/cancelBindCarStock/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> cancelCarStock(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@PathVariable int id) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "取消失败");

		try {
			int resultCode = carStockMangeService.cancelBindCarStock(id);
			if(resultCode>0){
				result.put("code", "200");
				result.put("msg", "取消成功");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "取消失败");
		}
		return result;
	}
	
	
	
	/**
	 * 获取可以绑定配件库存信息
	 * @author  lvhao 
	 * @date 2016年9月26日 上午11:01:46
	 * @parameter  
	 * {
	 * 		waybill_id -运单号(移动端不需要)
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		attachmentName-配件名称（没有查询全部）
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
	@RequestMapping(value = "/queryCarAttachment",method=RequestMethod.POST)
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
			//仓库编号
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			//新建状态
			params.put("status", Constants.WaibillStatus.NEW.getValue());
			params.put("flag", "flag");
			Pager<CarAttachmentStock> pager = carAttachmentMngService.getPageData(params);
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
	 * 移动端绑定配件
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param {wabillId-运单id ids-配件id串}
	 * @return {}
	 * @throws Exception
	 */
	@RequestMapping(value = "/bindCarAttachment/{waybillId}/{ids}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> bindCarAttachment(HttpServletRequest request,
			HttpServletResponse response, HttpSession session ,@PathVariable int waybillId ,@PathVariable String ids) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");

		try {
			boolean endsWith = ids.endsWith(",");
			if(endsWith){
				ids = 	ids.substring(0, ids.length()-1);
			}

			params.put("waybillId", waybillId);
			params.put("ids", ids);
			Waybill wb = waybillManageService.queryWaybill(waybillId);
			if(null == wb)
			{
				throw new RuntimeException("没有查询到运单信息！");
			}
			params.put("type", wb.getType());
			int bindCarAttachment = carAttachmentMngService.bindCarAttachment(params);
			if(bindCarAttachment > 0 ){
				result.put("code", "200");
				result.put("msg", "绑定成功");
			}
			

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败：" + e.getMessage());
		}
		return result;
	}

	
	
	/**
	 * web端绑定配件
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param {wabillId-运单id ids-配件id串}
	 * @return {}
	 * @throws Exception
	 */
	@RequestMapping(value = "/batchBindCarAttachment/{waybillId}/{ids}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> batchBindCarAttachment(HttpServletRequest request,
			HttpServletResponse response, HttpSession session ,@PathVariable int waybillId ,@PathVariable String ids) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");

		try {
			boolean endsWith = ids.endsWith(",");
			if(endsWith){
				ids = 	ids.substring(0, ids.length()-1);
			}
			params.put("waybillId", waybillId);
			params.put("ids", ids);
			int bindCarAttachment = 
			carAttachmentMngService.batchBindCarAttachment(params);
			//if(bindCarAttachment > 0 ){
				result.put("code", "200");
				result.put("msg", "绑定成功");
			//}
			

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败：" + e.getMessage());
		}
		return result;
	}
	
	
	
	
	/**
	 * 取消绑定配件
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param {id-配件id }
	 * @return {code，msg}
	 * @throws Exception
	 */
	@RequestMapping(value = "/cancelBindCarAttachment/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> cancelBindCarAttachment(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@PathVariable int id) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "取消失败");

		try {
			int resultCode = carAttachmentMngService.cancelBindCarAttachment(id);
			if(resultCode>0){
				result.put("code", "200");
				result.put("msg", "取消成功");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "取消失败：");
		}
		return result;
	}
	
	
	
	/**
	 * 提交运单
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
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
			
			int waybill = waybillManageService.submitWaybill(params);
			if(waybill > 0 ){
				result.put("code", "200");
				result.put("msg", "提交成功");
			}else if(waybill == -1){
				result.put("msg", "失败：该运单未绑定商品车");
			}

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "提交失败：" + e.getMessage());
		}
		return result;
	}

	
	
	/**
	 * 撤回运单
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param {id-运单id }
	 * @return {}
	 * @throws Exception
	 */
	@RequestMapping(value = "/cancelWaybill/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> cancelWaybill(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@PathVariable int id) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "撤回失败");

		try {
			params.put("id", id);
			params.put("status", Constants.WaibillStatus.NEW.getValue());
			int waybill = waybillManageService.cancelWaybill(params);
			if(waybill > 0 ){
				result.put("code", "200");
				result.put("msg", "撤回成功");
			}else if(waybill == -1){
				result.put("msg", "失败：该运单不是待复核状态");
			}

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "撤回失败");
		}
		return result;
	}
	
	
	
	
	/**
	 * 查看运单绑定的商品车、配件
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * @param {id-运单id }
	 * @return data:{id-主键 ， waybillNo-运单编号
	 *         ,supplierName-供应商名称,brand-品牌id,brandName -品牌名称 ,carShopName-经销单位
	 *         ,sendTime-发运日期,status -状态,startAddress-出发地, targetProvince-目的省、targetCity-目的地,amount-结算总金额,receiveUser-接车联系人,
	 *         receiveUserTelephone-接车联系人电话,receiveUserMobile-接车联系人手机,distance-总路程
	 *         "carStockList(绑定的商品车)":[{ brand 品牌
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
			Waybill waybill = waybillManageService.checkWaybill(id);
			result.put("data", waybill);
			result.put("code", "200");
			result.put("msg", "成功");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败：" + e.getMessage());
		}
		return result;
	}

	/**
	 * 管理员运单查询页面
	* @author  fengql 
	* @date 2016年11月11日 上午9:08:50 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/adminiIndex", method = RequestMethod.GET)
	public ModelAndView adminiIndex(HttpServletRequest request,HttpServletResponse response, HttpSession session)
			throws IOException {
		ModelAndView mv = new ModelAndView("waybill/waybillManage/adminiIndex");
		return mv;
	}
	
	/**
	 * 获取管理员运单列表数据
	 * 
	 * @author lvhao
	 * @date 2016年9月24日 下午3:25:30
	 * 
	 * @parameter{
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的(移动端不需要传)
	 * 		waybillNo -运单号(移动端不需要)
	 * 		status -状态：0-新建，1-待复核，2-已复核，3-已回执，4-已结算
	 * }
	 * @return
	 * {"data":{        totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 					"records":[id-主键 ， waybillNo-运单编号 ，type 类型：0-正常新车，1-二手车，2-折损车
	 *         ,supplierName-供应商名称,brand-品牌,carShopName-经销单位,brandName -品牌名称
	 *         startAddress出发地(二手车用到) ,   targetProvince-目的省、targetCity-目的地(二手车用到)
	 *         ,sendTime-发运日期,status -状态，insertTime-插入时间
	 *         
	 *         ],"frontParams":null},
	 *         
	 *         "code":"200","msg":"成功"}
	 *  	
	 */
	@RequestMapping(value = "/getAdminiWaybillList", method=RequestMethod.POST, headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getAdminiWaybillList(HttpServletRequest request,
			@RequestBody Map<String, Object> params,
			 HttpSession session)
			throws Exception {

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
	
		try {
			params.put("status", params.get("status").toString());
			params.put("delFlag", Constants.DelFlag.N);
			//params.put("stockId", CommonUtil.getStockIdFromSession(request));
			Pager<Waybill> pager = waybillManageService.getWaybillList(params);
			pager.setFrontParams(params.get("sEcho"));
			result.put("data", pager);
			result.put("code", "200");
			result.put("msg", "成功");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败");
		}
		return result;
	}
	
	
}
