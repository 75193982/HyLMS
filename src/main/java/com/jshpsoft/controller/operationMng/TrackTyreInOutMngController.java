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

import com.jshpsoft.domain.TrackTyreInOut;
import com.jshpsoft.domain.TrackTyreStock;
import com.jshpsoft.service.TrackTyreBuyApplyService;
import com.jshpsoft.service.TrackTyreInOutMngService;
import com.jshpsoft.service.TrackTyreMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 轮胎出库管理Controller
* @author  fengql 
* @date 2016年10月9日 下午5:17:18
 */
@Controller
@RequestMapping("/operationMng/trackTyreInOutMng")
public class TrackTyreInOutMngController {
	
	@Autowired  
	private TrackTyreInOutMngService trackTyreInOutMngService;
	
	@Autowired  
	private TrackTyreMngService trackTyreMngService;
	
	@Autowired  
	private CommonService commonService;
	
	@Autowired  
	private TrackTyreBuyApplyService trackTyreBuyApplyService;
	/**
	 * 轮胎出入库登记页面
	* @author  fengql 
	* @date 2016年10月9日 下午5:18:11 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackTyreInOutMng/index");		
		return mv;		
	}
	
	
	
	/**
	 * 获取轮胎出库登记列表数据
	* @author  ww
	* @date 2016年12月13日 上午10:13:01
	* @parameter  params [ billNo-出库单号(String) startTime-开始时间  endTime-结束时间
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、billNo-出库单号、type-类型（0-入库，1-出库）、mark-备注、status-状态（0-新建，1-待复核，2-已完成）、
	 * 						buyBillNo-采购单号、insertTime-登记时间、insertUserName-登记人、updateTime更新时间  ]
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
			params.put("type", Constants.TrackTyreInOutType.OUT);
			params.put("insertUser", CommonUtil.getOperId(request));
			Pager<TrackTyreInOut> pager = trackTyreInOutMngService.getPageData(params);
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
	 * 查询轮胎  已入库状态的
	* @author  ww 
	* @date 2016年12月13日 下午4:24:46 
	* @parameter  params{type,brand,sszie}
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
			params.put("delFlag", Constants.DelFlag.N);
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
	 * 保存轮胎出库信息
	* @author  ww
	* @date 2016年12月13日 上午10:17:01 
	* @parameter  bean [ mark-备注(String),ids(轮胎库存id，多个逗号,隔开)]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackTyreInOut bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackTyreInOutMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取轮胎入库登记详细信息-用于修改
	* @author  ww
	* @date 2016年12月13日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [ billNo-出库单号(String)、mark-备注(String)
	* 						detailList{
	* 						    [type-类型（0-轮胎，1-钢圈）、brand-品牌、tyreNo-轮胎编号、size-尺寸、price-价格]
	* 						}
	*  					]
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
			TrackTyreInOut bean = trackTyreInOutMngService.getById(id);
			
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
	 * 修改轮胎出库信息
	* @author  ww
	* @date 2016年12月13日 上午10:31:01 
	* @parameter  bean [ id-id号(int)、mark-备注(String)、ids-(轮胎库存id，多个逗号,隔开) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody TrackTyreInOut bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			trackTyreInOutMngService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除轮胎出库信息--更新逻辑删除键标志
	* @author  ww 
	* @date 2016年12月13日 上午10:35:01
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
			trackTyreInOutMngService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 获取轮胎出入库明细--用于查看明细
	 * @author  lvhao 
	 * @date 2016年9月24日 下午3:25:30 
	 * @parameter  id号(int) 必传
	 * @return	bean{  id-id号、billNo-单据号、type-类型、mark-备注、status-状态、insertTime-插入时间、insertUser-插入人、
					   detailList { id-id号、tyreNo-轮胎编号、spec-规格、carNumber-货运车号、mark-备注   }
					}
	 */
	@RequestMapping(value = "/getInoutDetail/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getInoutDetail(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@PathVariable Integer id
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			TrackTyreInOut bean = trackTyreInOutMngService.getDetailById(id);
			
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
	 * 提交轮胎出库单据
	* @author  ww 
	* @date 2016年12月13日 下午1:30:45 
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
			trackTyreInOutMngService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}
	
	
	/**
	 * 查询管理-轮胎出入库查询
	 * @author  ww 
	 * @date 2016年12月21日 下午4:54:56
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/searchIndex",method=RequestMethod.GET)		
	public ModelAndView searchIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackTyreInOutMng/searchIndex");		
		return mv;		
	}
	
	
	/**
	 * 查询系统-轮胎出入库查询
	 * @author  ww 
	 * @date 2016年12月23日 上午9:05:49
	 *  @parameter  params [ type-类型(0-入库，1-出库)、startTime-创建时间、endTime-结束时间、status-状态、billNo-出入库单号
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、billNo-出入库单号、type-类型（0-入库，1-出库）、mark-备注、status-状态（0-新建，1-待复核，2-已完成）、
	 * 						insertTime-登记时间、insertUserName-登记人、updateTime更新时间  ]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
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
			Pager<TrackTyreInOut> pager = trackTyreInOutMngService.getPageData(params);
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
