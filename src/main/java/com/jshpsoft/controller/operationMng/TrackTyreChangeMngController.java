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

import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TrackTyreChangeApply;
import com.jshpsoft.domain.TrackTyreStock;
import com.jshpsoft.service.TrackTyreChangeMngService;
import com.jshpsoft.service.TrackTyreMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 轮胎更换管理Controller
* @author  fengql 
* @date 2016年10月27日 上午10:06:56
 */
@Controller
@RequestMapping("/operationMng/trackTyreChangeMng")
public class TrackTyreChangeMngController {
	
	@Autowired  
	private TrackTyreChangeMngService trackTyreChangeMngService;
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private TrackTyreMngService trackTyreMngService;
	
	/**
	 * 轮胎更换管理页面
	* @author  fengql 
	* @date 2016年10月9日 下午5:18:11 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackTyreChangeMng/index");		
		return mv;		
	}

	/**
	 * 获取货运车号信息
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter  
	* @return	list [ no-车牌号  ]
	 */
	@RequestMapping(value = "/getTrackList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getTrackList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("type", "0");//车头
			List<Track> list = commonService.getTrackList(params);
			
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
	 * 获取轮胎更换信息列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ carNumber-货运车号(String)、status-状态(String)、startTime-申请开始时间(String)、endTime-申请结束时间(String) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、carNumber-货运车号、oldTyreNo-原轮胎编号、newTyreNo-新轮胎编号、status-状态 、mark-备注、applyTime-申请时间、insertUser-申请人]
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
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			Pager<TrackTyreChangeApply> pager = trackTyreChangeMngService.getPageData(params);
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
	 * 根据原轮胎编号模糊查询
	* @author  ww 
	* @date 2016年12月23日 上午10:45:42 
	* @parameter  params [  tyreNo-轮胎编号 ] 
	* @return	list [ tyreNo-轮胎编号  ]---应该有且只有一条，取第一条数据
	 */
	@RequestMapping(value = "/getOldTyreNo",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getOldTyreNo(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			params.put("status", Constants.TrackTyreStatus.USED);//使用中
			List<TrackTyreStock> list = trackTyreMngService.getByConditions(params);
				
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
	 * 查询轮胎  1已入库状态的--用于获取新轮胎
	* @author  fengql 
	* @date 2016年10月14日 下午4:24:46 
	* @parameter  params[brand-品牌、ssize-尺寸、type-类型]
	* @return	list [ id、tyreNo-轮胎编号、spec-规格  ]
	 */
	@RequestMapping(value = "/queryTrackTyre",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> queryTrackTyre(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String,Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			params.put("status", Constants.TrackTyreStatus.HASIN);//已入库
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			List<TrackTyreStock> list = trackTyreMngService.getByConditions(params);
			
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
	 * 保存轮胎更换信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ carNumber-货运车号(String)、oldTyreNo-原轮胎编号(String)、newTyreNo-新轮胎编号(String) 、mark-备注(String) ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackTyreChangeApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackTyreChangeMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取轮胎更换详细信息-用于修改、查看，修改时只显示新增时的内容
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int)  必传
	* @return	  bean [ id-id号、carNumber-货运车号、oldTyreNo-原轮胎编号、oldTyrePic-原轮胎照片、newTyreNo-新轮胎编号、newTyrePic-新轮胎照片、status-状态 、
	* 						mark-备注、applyTime-申请时间、insertTime-插入时间 、insertUser-插入人、updateTime-更新时间 、updateUser-更新人  ]
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
			TrackTyreChangeApply bean = trackTyreChangeMngService.getById(id);
			
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
	 * 修改轮胎信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:31:01 
	* @parameter  bean [ id-id号(int)、carNumber-货运车号(String)、oldTyreNo-原轮胎编号(String)、newTyreNo-新轮胎编号(String)、mark-备注(String) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackTyreChangeApply bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackTyreChangeMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 上传旧、新轮胎的照片
	* @author  fengql 
	* @date 2016年10月19日 下午3:42:50 
	* @parameter  params[ id号(int)、oldTyrePic-原轮胎照片(String)、newTyrePic-新轮胎照片(String) ]
	* @return
	 */
	@RequestMapping(value = "/updateTyrePic",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> updateTyrePic(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "上传失败");
		
		try{
			trackTyreChangeMngService.updateTyrePic(params,request);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "上传失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除轮胎信息--更新逻辑删除键标志
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
			trackTyreChangeMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 提交轮胎更换信息
	* @author  fengql 
	* @date 2016年10月27日 上午10:53:45 
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
			String oper = CommonUtil.getOperId(request);//操作员
			trackTyreChangeMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
}
