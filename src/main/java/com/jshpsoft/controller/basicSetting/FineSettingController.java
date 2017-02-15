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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.Fine;
import com.jshpsoft.service.FineMngService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;

/**
 * 罚款比例设置
 * @author  ww 
 * @date 2016年12月3日 上午10:23:06
 */
@Controller
@RequestMapping("/basicSetting/fineSetting")
public class FineSettingController {
	
	@Autowired  
	private FineMngService fineMngService;
	
	/**
	 * 页面
	 * @author  ww 
	 * @date 2016年12月3日 上午10:24:21
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("basicSetting/fineSetting/index");		
		return mv;		
	}
	
	/**
	 * 保存 修改
	 * @author  ww 
	 * @date 2016年12月3日 上午10:26:29
	 * @parameter  [id,proportion-比例]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Fine fine)throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			String operId = CommonUtil.getOperId(request);
			fineMngService.save(fine,operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 得到数据
	 * @author  ww 
	 * @date 2016年12月3日 上午10:41:00
	 * @parameter  
	 * @return [id,proportion-比例,insertTime,insertUser,updateTime,updateUser,delFlag]
	 */
	@RequestMapping(value = "/getBean",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getBean(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session)throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			List<Fine> list = fineMngService.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				Fine fine = list.get(0);
				result.put("data", fine);
				result.put("code", "200");
				result.put("msg", "成功");
			}else{
				result.put("data", null);
				result.put("code", "200");
				result.put("msg", "成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败:"+e.getMessage());
		}
		return result;
	}

}
