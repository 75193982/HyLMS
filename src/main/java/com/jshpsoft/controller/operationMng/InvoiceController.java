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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jshpsoft.domain.Invoice;
import com.jshpsoft.service.InvoiceService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 发票管理
 * @author  ww 
 * @date 2016年12月20日 上午10:59:13
 */
@Controller
@RequestMapping("/operationMng/invoice")
public class InvoiceController {
	
	@Autowired
	private InvoiceService invoiceService;
	
	
	/**
	 * 发票管理页面
	 * @author  ww 
	 * @date 2016年12月20日 上午11:00:40
	 * @parameter 
	 * @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/invoice/index");		
		return mv;		
	}
	
	/**
	 * 获取分页列表数据
	 * @author  ww 
	 * @date 2016年12月20日 上午11:23:43
	 * @parameter  
	 * {
	 * 		pageStartIndex -页开始索引
	 * 		pageSize -页大小
	 * 		sEcho -前台带过来的参数，不动返回回去的
	 * 		invoiceNo-发票号 ,startTime-开票时间开始,endTime-结束,title-收款方,mark-备注
	 * }   
	 * @return
	 * {
	 * 		code 
	 * 		msg
	 * 		data : {
	 * 					records:[
	 * 								id、invoiceNo-发票号、operateTime-开票时间、title-收款方、amount-开票金额、duty-税金、filePath-上传地址、
	 * 							mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag
	 * 							]
	 * 					totalCounts -总记录数
	 * 					totalPages -总页数
	 * 					pageSize -页大小
	 * 					frontParams -前台带过来的参数，不动返回回去的
	 * 				}
	 * }
	 */
	@RequestMapping(value = "/getListData",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getListData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Map<String, Object> params) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Pager<Invoice> pager = invoiceService.getPageData(params);
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
	 * 保存、更新
	 * @author  ww 
	 * @date 2016年12月20日 下午12:42:56
	 * @parameter  
	 * bean[
	 * 		id、invoiceNo-发票号、operateTime-开票时间、title-收款方、amount-开票金额、duty-税金、filePath-上传地址、mark-备注
	 * ]
	 * @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@RequestBody Invoice bean) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			invoiceService.save(bean, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		return result;
		
	}
	
	/**
	 * 根据id获取详情
	 * @author  ww 
	 * @date 2016年12月20日 下午12:45:48
	 * @parameter  id
	 * @return
	 * bean[
	 * 		id、invoiceNo-发票号、operateTime-开票时间、title-收款方、amount-开票金额、duty-税金、filePath-上传地址、
	 * 		mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag
	 * ]
	 */
	@RequestMapping(value = "/getById/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getById(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			Invoice bean = invoiceService.getById(id);
			result.put("data", bean);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "获取失败："+e.getMessage());	
		}
		
		return result;
		
	}
	
	/**
	 * 删除
	 * @author  ww 
	 * @date 2016年12月20日 下午12:46:55
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/delete/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> delete(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			invoiceService.delete(id, operId);
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
	 * @date 2016年12月20日 下午12:47:35
	 * @parameter  id
	 * @return
	 */
	@RequestMapping(value = "/submit/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> submit(HttpServletRequest request, 
			HttpServletResponse response,HttpSession session,
			@PathVariable int id) throws Exception
	{
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try {
			String operId = CommonUtil.getOperId(request);
			invoiceService.submit(id, operId);
			result.put("code", "200");
			result.put("msg", "成功");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("msg", "提交失败："+e.getMessage());	
		}
		return result;
		
	}

	/**
	 * 打印
	 * @author  ww 
	 * @date 2016年12月20日 下午1:18:13
	 * @parameter  
	 * @parameter  
	 * {
	 * 		invoiceNo-发票号 ,startTime-开票时间开始,endTime-结束,title-收款方,mark-备注
	 * }   
	 * @return
	 * list
	 * {
	 * 		bean[
	 * 				id、invoiceNo-发票号、operateTime-开票时间、title-收款方、amount-开票金额、duty-税金、filePath-上传地址、
	 * 				mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag
	 * 		]
	 * }
	 */
	@RequestMapping(value = "/getPrintData",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getPrintData(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<Invoice> list = invoiceService.getByConditions(params);
			
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
	 * @author  ww 
	 * @date 2016年12月20日 下午1:21:15
	 * @parameter  
	 * {
	 * 		invoiceNo-发票号 ,startTime-开票时间开始,endTime-结束,title-收款方,mark-备注
	 * } 
	 * @return
	 * list
	 * {
	 * 		bean[
	 * 				id、invoiceNo-发票号、operateTime-开票时间、title-收款方、amount-开票金额、duty-税金、filePath-上传地址、
	 * 				mark-备注、status、insertTime、insertUser、updateTime、updateUser、delFlag
	 * 		]
	 * }
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("invoiceNo") String invoiceNo,
			@RequestParam("title") String title,
			@RequestParam("mark") String mark,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("invoiceNo", invoiceNo);
		params.put("title", title);
		params.put("mark", mark);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		Map<String, Object> formatData = invoiceService.getExportData(params);

		String fileName = "发票信息导出Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
	/**
	 * 查询系统页面
	 * @author  ww 
	 * @date 2016年12月20日 下午12:48:38
	 * @parameter  
	 * @return
	 */
	@RequestMapping(value = "/adminIndex",method=RequestMethod.GET)		
	public ModelAndView adminIndex(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("/operationMng/invoice/adminIndex");		
		return mv;		
	}
}
