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
import com.jshpsoft.domain.TrackTyreInOut;
import com.jshpsoft.domain.TrackTyreStock;
import com.jshpsoft.service.TrackTyreInOutMngService;
import com.jshpsoft.service.TrackTyreMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 轮胎库存管理Controller
* @author  fengql 
* @date 2016年10月9日 下午5:17:18
 */
@Controller
@RequestMapping("/operationMng/trackTyreMng")
public class TrackTyreMngController {
	
	@Autowired  
	private TrackTyreMngService trackTyreMngService;
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private TrackTyreInOutMngService trackTyreInOutMngService;
	
	/**
	 * 轮胎库存管理页面
	* @author  fengql 
	* @date 2016年10月9日 下午5:18:11 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackTyreMng/index");		
		return mv;		
	}

	/**
	 * 获取货运车号信息
	* @author  fengql 
	* @date 2016年10月9日 下午2:36:12 
	* @parameter  params{no-车牌号 模糊查询}
	* @return	list [ no-车牌号  ]
	 */
	@RequestMapping(value = "/getStockList",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getStockList(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String,Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
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
	 * 获取轮胎信息列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ tyreNo-轮胎编号(String)、status-状态 (String)、carNumber-货运车号(String) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、tyreNo-轮胎编号、spec-规格、carNumber-货运车号、status-状态 、mark-备注、insertTime-插入时间 、updateTime-更新时间]
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
			Pager<TrackTyreStock> pager = trackTyreMngService.getPageData(params);
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
	 * 查询轮胎入库单 0 新建状态的
	* @author  fengql 
	* @date 2016年10月14日 下午4:24:46 
	* @parameter  
	* @return	list [ id、billNo-单据号]
	 */
	@RequestMapping(value = "/queryBillNo",method=RequestMethod.POST,headers={"Content-Type=application/json"})
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
			params.put("status", Constants.TrackTyreInOutStatus.NEW);//新建
			params.put("delFlag", Constants.DelFlag.N);
			params.put("stockId", CommonUtil.getStockIdFromSession(request));
			List<TrackTyreInOut> list = trackTyreInOutMngService.getByConditions(params);
			
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
	 * 保存轮胎信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ billId-单据id(int)、tyreNo-轮胎编号(String)、spec-规格(String)、mark-备注(String)  ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackTyreStock bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackTyreMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取轮胎详细信息-用于修改、查看，修改时只显示新增时的内容
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [ id-id号、billId-单据id、tyreNo-轮胎编号、spec-规格、carNumber-货运车号、status-状态 、mark-备注、
	* 					 insertTime-插入时间 、insertUser-插入人、updateTime-更新时间 、updateUser-更新人  ]
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
			TrackTyreStock bean = trackTyreMngService.getById(id);
			
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
	* @parameter  bean [ id-id号(int)、billId-单据id(int)、tyreNo-轮胎编号(String)、spec-规格(String)、mark-备注(String)  ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackTyreStock bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackTyreMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
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
			trackTyreMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 查询系统-轮胎库存查询
	 * @author  ww 
	 * @date 2016年12月28日 下午2:09:44
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/searchIndex",method=RequestMethod.GET)		
	public ModelAndView searchIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackTyreMng/searchIndex");		
		return mv;		
	}
	

}
