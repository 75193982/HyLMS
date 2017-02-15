package com.jshpsoft.controller.basicSetting;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.domain.TrackMaintenanceApply;
import com.jshpsoft.domain.TrackTyreChangeApply;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.TrackMaintMngService;
import com.jshpsoft.service.TrackService;
import com.jshpsoft.service.TrackTyreChangeMngService;
import com.jshpsoft.service.UserService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 运输车辆管理Controller
* @author  fengql 
* @date 2016年9月21日 上午10:07:01
 */
@Controller
@RequestMapping("/basicSetting/trackMng")
public class TrackMngController {
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private TrackService trackService;
	
	@Autowired  
	private UserService userService;
	
	@Autowired
	private TrackMaintMngService trackMaintMngService;
	
	@Autowired  
	private TrackTyreChangeMngService trackTyreChangeMngService;
	
	/**
	 * 运输车辆管理页面
	* @author  fengql 
	* @date 2016年9月21日 上午10:10:01
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/trackMng/index");		
		return mv;		
	}
	
	/**
	 * 查询管理运输车辆页面
	* @author  gll 
	* @date 2016年12月1日 上午
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/queryindex",method=RequestMethod.GET)		
	public ModelAndView queryindex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/trackMng/queryindex");		
		return mv;		
	}
	
	/**
	 * 获取外协单位列表数据
	* @author  fengql 
	* @date 2016年9月20日 下午3:25:30 
	* @parameter  
	* @return	List [ id-id号、name-名称 ]
	 */
	@RequestMapping(value = "/getOutSourcingList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getOutSourcingList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			List<OutSourcing> list = commonService.getOutSourcingList(params);
			
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
	 * 获取运输车辆列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ no-车头号码 ,xno-车厢号码,driverId-驾驶员id（接口到公共找） ， outSourcingId-外协单位id(int)、ower-所有人(String,模糊查询)、vin-车辆识别代号，engineNo-发动机号、insuranceStartTime-保险开始时间(String)、insuranceEndTime-保险结束时间(String)、
	* 			           annualStartTime-上次年审开始时间(String)、annualEndTime-上次年审结束时间(String)  
	*                       driverName-主副驾驶员模糊查询    没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	*  					 ]
	* 
	* @return		{
	 * 					records:[  id-id号、outSourcingName-外协单位名称、no-车头号码、xno-车厢号码、driverId-驾驶员、ower-所有人、owerAddress-所有人地址、vin-车辆识别代号、
	* 					  			engineNo-发动机号、registerTime-注册时间、size-外部尺寸、insuranceStartTime-保险开始时间、insuranceEndTime-保险到期时间、
	* 					  			annualReviewTime-上次年审日期、standardOilWear-核定油耗、oilDiscountLimit-油的折扣上限、
	* 					  			oilDiscountPoint-油的折扣点
	* 								driverName-主驾驶员、codriverName-副驾驶员
	* 							]
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
			Pager<Track> pager = trackService.getPageData(params);
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
	 * 获取驾驶员信息
	* @author  fengql 
	* @date 2016年11月4日 下午4:54:37 
	* @parameter  
	* @return  list[ name-姓名 ]
	 */
	@RequestMapping(value = "/geDriverData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> gedriverData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("driverFlag", "Y");
			List<User> list = userService.getByConditions(params);
			
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
	 * 保存运输车辆信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [  outSourcingId-外协单位id,0-公司车、no-车头号码(int)、xno-车厢号码(int)driverId-驾驶员(String)、ower-所有人(String)、owerAddress-所有人地址(String)、
	* 					  vin-车辆识别代号(String)、engineNo-发动机号(String)、registerTime-注册时间(date)、size-外部尺寸(String)、annualReviewTime-上次年审日期(date)、
	* 					  standardOilWear-核定油耗(double)、oilDiscountLimit-油的折扣上限(double)、oilDiscountPoint-油的折扣点(double)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Track bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取运输车辆详细信息-用于修改
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [  id-id号、outSourcingId-外协单位id,0-公司车、no-车头号码、xno-车厢号码、driverId-驾驶员、ower-所有人、owerAddress-所有人地址、vin-车辆识别代号、
	* 					  engineNo-发动机号、registerTime-注册时间、size-外部尺寸、insuranceStartTime-保险开始时间、insuranceEndTime-保险到期时间、
	* 					  annualReviewTime-上次年审日期、standardOilWear-核定油耗、oilDiscountLimit-油的折扣上限、
	* 					  oilDiscountPoint-油的折扣点 drivingFilePath-车头行驶证,toperatingFilePath-车头营运证,xoperatingFilePath-车厢营运证
	* 					]
	 */
	@RequestMapping(value = "/getDetailData/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getDetailData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Track bean = trackService.getById(id);
			
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
	 * 修改运输车辆信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:31:01 
	* @parameter  bean [  id-id号(int)、outSourcingId-外协单位id,0-公司车、no-车头号码(int)、xno-车厢号码(int)、driverId-驾驶员(String)、ower-所有人(String)、owerAddress-所有人地址(String)、
	* 					  vin-车辆识别代号(String)、engineNo-发动机号(String)、registerTime-注册时间(date)、size-外部尺寸(String)、annualReviewTime-上次年审日期(date)、
	* 					  standardOilWear-核定油耗(double)、oilDiscountLimit-油的折扣上限(double)、oilDiscountPoint-油的折扣点(double)
	* 					]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Track bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除运输车辆信息--更新逻辑删除键标志
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
			trackService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 上传
	 * @author  ww 
	 * @date 2016年11月21日 上午11:02:56
	 * @parameter  params[ id号(int)、drivingFilePath-车头行驶证(String)、toperatingFilePath-车头营运证(String)、xoperatingFilePath-车厢营运证(String) ]
	 * @return
	 */
	@RequestMapping(value = "/updateFilePath",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> updateFilePath(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "更新失败");
		
		try{
			trackService.updateFilePath(params,request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "更新失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 得到保险记录或出险记录数据    
	 * @author  ww 
	 * @date 2016年12月8日 下午4:18:44
	 * @parameter  carNumber-运输车辆车号 ， type- 0- 保险记录，1-出险记录
	 * @return
	 */
	@RequestMapping(value = "/getInsuranceList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getInsuranceList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("carNumber") String carNumber ,
			@RequestParam("type") String type
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try{
			List<TrackInsurance> list = trackService.getInsuranceList(carNumber ,type);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "获取成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取维修保养记录
	 * @author  lvhao 
	 * @date 2016年12月20日 下午4:18:44
	 * @param carNumber -车号
	 * @return list {currentMileage-公里数 ，insertTime-保养时间，amount-保养费用，detailInfo-保养详情}
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTrackMaintTranslate",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> gettrackMaintTranslate(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("carNumber")String carNumber
			) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try{
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("carNumber", carNumber);
			params.put("delFlag", Constants.DelFlag.N);
			List<TrackMaintenanceApply> list =  trackMaintMngService.getTrackMaintenanceApply(params);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "获取成功");
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	
	/**
	 * 根据货运车号获取轮胎更换记录
	* @author  lvhao 
	* @date 2016年12月20日 上午10:45:42 
	* @parameter  params [ carNumber-货运车号(String) ]  必传
	* @return	list [ applyTime-更换时间 ，oldTyreNo - 原轮胎编号  newTyreNo-新轮胎编号，mark-备注 ]
	 */
	@RequestMapping(value = "/getTyreTranslate",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getOldTyreNo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("carNumber")String carNumber
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try{
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("carNumber", carNumber);
			List<TrackTyreChangeApply> list = trackTyreChangeMngService.getByConditions(params);
			result.put("data", list);
			result.put("code", "200");
			result.put("msg", "获取成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
}
