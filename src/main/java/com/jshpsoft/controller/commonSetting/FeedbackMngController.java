package com.jshpsoft.controller.commonSetting;

import java.io.IOException;
import java.util.HashMap;
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

import com.jshpsoft.domain.Feedback;
import com.jshpsoft.service.FeedbackService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Pager;

/**
 * 
 * @Description: 意见反馈controller
 * @author army.liu
 * @date 2016年11月5日 上午8:46:01
 *
 */
@Controller
@RequestMapping("/basicSetting/feedbackMng")
public class FeedbackMngController {
	
	@Autowired  
	private FeedbackService feedbackService;
	
	/**
	 * 
	 * @Description: 列表页面
	 * @author army.liu 
	 * @param @param request
	 * @param @param response
	 * @param @param session
	 * @param @return
	 * @param @throws IOException    设定文件
	 * @return ModelAndView    返回类型
	 * @throws
	 * @see
	 */
	@RequestMapping(value = "/index", method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/feedbackMng/index");		
		return mv;		
	}

	/**
	 * 获取汽车品牌列表数据
	 * @author army.liu 
	 * @parameter
	 * { 
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		
	 * 		suggest-模糊查询
	 * }
	 * @return		
	 * {
	 * 		records:[ {id-id号、suggest-反馈意见、insertTime-反馈时间、insertUser-反馈人 id、 insertUserName-反馈人名称}  ]
	 * 		totalCounts -总记录数
	 * 		totalPages -总页数
	 * 		pageSize -页大小
	 * 		frontParams -前台带过来的参数，不动返回回去的
	 * }
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
			Pager<Feedback> pager = feedbackService.getPageData(params);
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
	 * 保存意见反馈信息
	 * 
	 * @author army.liu  
	 * @parameter  
	 * {
	 * 		suggest-反馈意见
	 * }
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Feedback bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			feedbackService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取反馈意见详细信息
	 * 
	 * @author army.liu 
	 * @parameter  id-id号
	 * @return	{ id-id号、suggest-反馈意见、insertTime-反馈时间、insertUser-反馈人 id、 insertUserName-反馈人名称 }
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
			Feedback bean = feedbackService.getById(id);
			
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());		
		}		
		return result;
	}
	
}
