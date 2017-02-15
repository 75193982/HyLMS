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

import com.jshpsoft.domain.TrackTyreBuyApply;
import com.jshpsoft.domain.TrackTyreInOut;
import com.jshpsoft.service.TrackTyreBuyApplyService;
import com.jshpsoft.service.TrackTyreMngService;
import com.jshpsoft.service.TrackTyreRuService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 轮胎入库管理
 * @author  ww 
 * @date 2016年12月10日 下午5:26:58
 */
@Controller
@RequestMapping("/operationMng/trackTyreRuMng")
public class TrackTyreRuMngController {
	
	@Autowired  
	private TrackTyreRuService trackTyreRuService;
	
	@Autowired  
	private TrackTyreMngService trackTyreMngService;
	
	@Autowired  
	private TrackTyreBuyApplyService trackTyreBuyApplyService;
	
	/**
	 * 轮胎入库登记页面
	* @author  ww 
	* @date 2016年12月10日
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/trackTyreRuMng/index");		
		return mv;		
	}
	
	/**
	 * 轮胎采购单号下拉
	 * @author  ww 
	 * @date 2016年12月10日 下午3:02:05
	 * @parameter  
	 * @return
	 * list{
	 * 		bean[id,billNo,...]
	 * }
	 */
	@RequestMapping(value = "/getBuyApplyListData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getBuyApplyListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("status", Constants.TrackTyreBuyApplyStatus.FINISH);
			List<TrackTyreBuyApply> list = trackTyreBuyApplyService.getByConditions(params);
				
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
	 * 获取轮胎入库登记列表数据
	* @author  ww 
	* @date 2016年12月10日 上午10:13:01
	* @parameter  params [ billNo-入库单号(String)、buyBillNo-采购单号(String)、startTime-登记时间(String)、endTime-结束时间(String) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、billNo-入库单号、type-类型（0-入库，1-出库）、mark-备注、status-状态（0-新建，1-待复核，2-已完成）、
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
			params.put("type", Constants.TrackTyreInOutType.IN);//入库
			params.put("insertUser", CommonUtil.getOperId(request));
			Pager<TrackTyreInOut> pager = trackTyreRuService.getPageData(params);
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
	 * 保存轮胎入库登记信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ buyBillNo-采购单号(String)、mark-备注(String)
	* 						detailList{
	* 						    [type-类型（0-轮胎，1-钢圈）、brand-品牌、tyreNo-轮胎编号、size-尺寸、price-价格]
	* 						}
	*  					]
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
			trackTyreRuService.save(bean, oper);
			
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
	* @date 2016年12月10日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [ buyBillNo-采购单号(String)、mark-备注(String)、typeEdit-类型、brandEdit-品牌、sizeEdit-尺寸、sumEdit-数量、priceEdit-价格
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
			TrackTyreInOut bean = trackTyreRuService.getById(id);
			
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
	 * 修改轮胎入库登记信息
	* @author  ww
	* @date 2016年12月10日 上午10:31:01 
	* @parameter  bean [ id、buyBillNo-采购单号(String)、mark-备注(String)
	* 						detailList{
	* 						    [type-类型（0-轮胎，1-钢圈）、brand-品牌、tyreNo-轮胎编号、size-尺寸、price-价格]
	* 						}
	*  					]
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
			trackTyreRuService.update(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "修改失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除轮胎入库登记信息--更新逻辑删除键标志
	* @author  ww 
	* @date 2016年12月10日 上午10:35:01
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
			trackTyreRuService.updateById(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}

	/**
	 * 提交轮胎单据
	* @author  ww 
	* @date 2016年12月10日 下午1:30:45 
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
			trackTyreRuService.submit(id, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());		
		}		
		return result;
	}

}
