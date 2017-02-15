package com.jshpsoft.controller.operationMng;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.SendCarCommand;
import com.jshpsoft.service.SendCarCommandService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 派车指令管理
 * @author  ww 
 * @date 2016年12月3日 上午10:57:41
 */
@Controller
@RequestMapping("/operationMng/sendCarCommand")
public class SendCarCommandController {
	
	@Resource
	private SendCarCommandService sendCarCommandService;
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年12月3日 上午11:20:33
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/sendCarCommand/index");		
		return mv;		
	}
	
	/**
	 * 获取派车指令数据
	 * @author  ww 
	 * @date 2016年12月3日 上午11:23:58
	 *  @parameter  params [ carNumber-装运车号,startInTime,endInTime
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、carNumber-装运车号、startAddress-始发地、endAddress-目的地、insertTime-插入时间、insertUser-插入人、status、delFlag]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST)
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
			Pager<SendCarCommand> pager = sendCarCommandService.getPageData(params);
			pager.setFrontParams(params.get("sEcho"));
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
	 * 根据id得到数据
	 * @author  ww 
	 * @date 2016年12月3日 上午11:26:52
	 * @parameter  id
	 * @return [ id-id号、carNumber-装运车号、startAddress-始发地、endAddress-目的地、insertTime-插入时间、insertUser-插入人、status、delFlag]
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
			SendCarCommand bean = sendCarCommandService.getById(id);
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
	 * 保存  修改
	 * @author  ww 
	 * @date 2016年12月3日 上午11:28:08
	 * @parameter  params [id(保存为空)、carNumber-装运车号、startAddress-始发地、endAddress-目的地]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody SendCarCommand bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			sendCarCommandService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 删除
	 * @author  ww 
	 * @date 2016年12月3日 上午11:29:22
	 * @parameter  id
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
			sendCarCommandService.delete(id, oper);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "删除失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 得到最新的一条指令
	 * @author  ww 
	 * @date 2016年12月3日 上午11:30:53
	 * @parameter  carNumber
	 * @return [ id-id号、carNumber-装运车号、startAddress-始发地、endAddress-目的地、insertTime-插入时间、insertUser-插入人、status、delFlag]
	 */
	@RequestMapping(value = "/getNewOne",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getNewOne(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestParam("carNumber") String carNumber
			) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "删除失败");
		try {
			SendCarCommand sendCarCommand = sendCarCommandService.getNewOne(carNumber);
			result.put("data", sendCarCommand);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}
		return result;
	}
	
	/**
	 * 提交
	 * @author  ww 
	 * @date 2016年12月3日 下午1:36:11
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/submit/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submitWaybill(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,@PathVariable int id) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "提交失败");
		try {
			String oper = CommonUtil.getOperId(request);
			sendCarCommandService.submit(id,oper);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "提交失败：" + e.getMessage());
		}
		return result;
	}
	
	

}
