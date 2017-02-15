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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.TrackRepairApply;
import com.jshpsoft.service.TrackRepairApplyService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 折损维修登记Controller
 * @author  吕浩 
 * @date 2016年12月21日 上午8:35:59
 *
 */
@Controller
@RequestMapping("/operationMng/trackRepairApply")
public class TrackRepairApplyMngController {
	@Autowired
	private TrackRepairApplyService trackRepairApplyService;
	
	/**
	 * 折损维修登记页面
	* @author  lvhao 
	* @date  2016年12月21日 上午8:35:59
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackRepairApply/index");		
		return mv;		
	}

	/**
	 * 折损维修登记查询页面
	* @author  lvhao 
	* @date  2016年12月21日 上午8:35:59
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/trackRepairApplySearch",method=RequestMethod.GET)		
	public ModelAndView trackRepairApplySearch(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackRepairApply/trackRepairApplySearch");		
		return mv;		
	}
	
	/**
	 * 获取 折损维修登记
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59
	* @parameter  params [ vin-折损车架号 、startTime-登记开始时间(String)、endTime-登记结束时间(String)、name-登记人、repairContent-维修项目
	* 						repairCompany-修理厂名称(String)、status-状态:0新建1修理中2已完成(String,传0或1、2)  所有条件不填或不选传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ vin-折损车架号、repairContent-维修项目、repairCompany-修理厂名称、repairTelephone- 修理厂电话、repairFinishedTime-预计修好时间、name - 登记人、
	 * 					applyTime-登记时间、finishUser-取车人、finishTime-取车时间
	 * 					status-状态、insertTime-调度时间、verifyTime-确认时间  ]
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
			String oper = CommonUtil.getOperId(request);//操作员
			params.put("applyUserId", oper);
			Pager<TrackRepairApply> pager = trackRepairApplyService.getPageData(params);
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
	 * 保存 折损维修登记
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59 
	* @parameter  bean [ carStockId-折损车id ，applyTime-登记时间 ，repairContent -维修项目 ，repairCompany- 修理厂名称，repairTelephone-修理厂电话 、repairFinishedTime - 预计修好时间]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackRepairApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			String name = CommonUtil.getUserNameFromSession(request);
			bean.setApplyUserId( Integer.parseInt(oper));
			bean.setInsertUser(name);
			trackRepairApplyService.save(bean);
			result.put("code", "200");
			result.put("msg", "成功");
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 获取折损车架号
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59 
	* @parameter  
	* @return	list [ vin-车架号，  id-保存时带过来]
	 */
	@RequestMapping(value = "/getDamageStocks",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getPrint(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<CarDamageStock> list = trackRepairApplyService.getDamageStocks();
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
	 * 获取折损维修登记信息-用于修改和查看
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59
	* @parameter  id-id号(int) 必传
	* @return	  bean [ id-id号、applyUserId-申请人id、name-申请人姓名、applyTime-申请时间、carStockId-折损车库存id、repairContent - 维修项目、repairCompany - 修理厂名称 、
	* 				repairTelephone - 修理厂电话 、repairFinishedTime-预计修好时间、repairMoney - 修理费用  、filePath - 扫描件、mark-备注、
	* 				status-状态、finishTime - 取车时间 、finishUser - 取车人名称 、insertUser-插入人、insertTime-插入时间  、updateUser-修改人]
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
			TrackRepairApply detail = trackRepairApplyService.getDetail(id);
			result.put("data", detail);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	
	/**
	 * 修改收支信息
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59
	* @parameter  bean [ id-id号(int)、type-类型(String)、mark-事由(String)、money-金额(double) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackRepairApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String name = CommonUtil.getUserNameFromSession(request);
			bean.setUpdateUser(name);
			bean.setUpdateTime(new Date());
			trackRepairApplyService.update(bean);
			result.put("code", "200");
			result.put("msg", "成功");
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 删除收支信息--更新逻辑删除键标志
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59
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
			TrackRepairApply bean = new TrackRepairApply();
			String name = CommonUtil.getUserNameFromSession(request);
			bean.setUpdateUser(name);
			bean.setUpdateTime(new Date());
			bean.setId(id);
			bean.setDelFlag(Constants.DelFlag.Y);
			trackRepairApplyService.delete(bean);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 提交收支信息
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59 
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
		result.put("msg", "提交失败");
		
		try{
			TrackRepairApply bean = new TrackRepairApply();
			bean.setId(id);
			bean.setStatus(Constants.TrackRepairApplyStatus.ING);
			trackRepairApplyService.submit(bean);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}

	
	
	/**
	 * 确认收支信息
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59
	* @parameter  id-id号(int) 必传   finishTime-取车时间    finishUser - 取车人名称
	* @return
	 */
	@RequestMapping(value = "/confirm",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> confirm(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackRepairApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");
		
		try{
			bean.setStatus(Constants.TrackRepairApplyStatus.FINISH);
			trackRepairApplyService.confirm(bean);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	
	/**
	 * 打印
	* @author  lvhao 
	* @date 2016年10月26日 下午2:19:54 
	* @parameter  params [ all = 0-查询全部数据 ，vin-折损车架号 、startTime-登记开始时间(String)、endTime-登记结束时间(String)、name-登记人、repairContent-维修项目
	* 						repairCompany-修理厂名称(String)、status-状态:0新建1修理中2已完成(String,传0或1、2)  所有条件不填或不选传'''
	* 
	* @return	list [ vin-折损车架号、repairContent-维修项目、repairCompany-修理厂名称、repairTelephone- 修理厂电话、repairFinishedTime-预计修好时间、name - 登记人、
	 * 					applyTime-登记时间、finishUser-取车人、finishTime-取车时间
	 * 					status-状态、insertTime-调度时间、verifyTime-确认时间  ]
	 */
	@RequestMapping(value = "/getPrint",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getPrint(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try{
			String all = (String) params.get("all");
			if( null != all && all .equals( "1" ) ){
				String oper = CommonUtil.getOperId(request);//操作员
				params.put("applyUserId", oper);
			}
			params.put("delFlag", Constants.DelFlag.N);
			List<TrackRepairApply> list = trackRepairApplyService.getPrint(params);
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
	 * 导出
	* @author  lvhao 
	* @date 2016年10月26日 下午2:19:54 
	* @parameter  params [ all = 0-查询全部数据  ，vin-折损车架号 、startTime-登记开始时间(String)、endTime-登记结束时间(String)、name-登记人、repairContent-维修项目
	* 						repairCompany-修理厂名称(String)、status-状态:0新建1修理中2已完成(String,传0或1、2)  所有条件不填或不选传'''
	* 
	* @return	list [ vin-折损车架号、repairContent-维修项目、repairCompany-修理厂名称、repairTelephone- 修理厂电话、repairFinishedTime-预计修好时间、name - 登记人、
	 * 					applyTime-登记时间、finishUser-取车人、finishTime-取车时间
	 * 					status-状态、insertTime-调度时间、verifyTime-确认时间  ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("vin") String vin,
			@RequestParam("status") String status,
			@RequestParam("name") String name,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam("repairCompany") String repairCompany ,
			@RequestParam("repairContent") String repairContent,
			@RequestParam("all") String all
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		if( null != all && all .equals( "1" ) ){
			String oper = CommonUtil.getOperId(request);//操作员
			params.put("applyUserId", oper);
		}
		params.put("vin", vin);
		params.put("status", status);
		params.put("name", name);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("repairCompany", repairCompany);
		params.put("repairContent", repairContent);
		Map<String, Object> formatData = trackRepairApplyService.getExportData(params);
		String fileName = "折损维修登记Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,fileExtend);

	}
	
	
	
	/**
	 * 查询管理 获取 折损维修登记
	* @author  lvhao 
	* @date 2016年12月21日 上午8:35:59
	* @parameter  params [ vin-折损车架号 、startTime-登记开始时间(String)、endTime-登记结束时间(String)、name-登记人、repairContent-维修项目
	* 						repairCompany-修理厂名称(String)、status-状态:0新建1修理中2已完成(String,传0或1、2)  所有条件不填或不选传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ vin-折损车架号、repairContent-维修项目、repairCompany-修理厂名称、repairTelephone- 修理厂电话、repairFinishedTime-预计修好时间、name - 登记人、
	 * 					applyTime-登记时间、finishUser-取车人、finishTime-取车时间
	 * 					status-状态、insertTime-调度时间、verifyTime-确认时间  ]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/searchListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> searchListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<TrackRepairApply> pager = trackRepairApplyService.getPageData(params);
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
