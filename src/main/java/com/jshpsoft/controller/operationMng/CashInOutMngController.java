package com.jshpsoft.controller.operationMng;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
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

import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.service.CashInOutMngService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.POIUtil;
import com.jshpsoft.util.Pager;

/**
 * 收支管理Controller
* @author  fengql 
* @date 2016年10月26日 下午1:14:53
 */
@Controller
@RequestMapping("/operationMng/cashInOutMng")
public class CashInOutMngController {
	
	@Autowired  
	private CashInOutMngService cashInOutMngService;
	
	/**
	 * 收支管理页面
	* @author  fengql 
	* @date 2016年10月26日 下午1:27:12 
	* @parameter  
	* @return
	 */
	@RequestMapping(value = "/index",method=RequestMethod.GET)		
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/cashInOutMng/index");		
		return mv;		
	}
	
	/**
	 * 获取收支列表数据
	* @author  fengql 
	* @date 2016年9月21日 上午10:13:01
	* @parameter  params [ type-类型(String)、status-状态 (String)、mark-事由(String,模糊查询)、departmentId-部门,businessType-类别（直接传中文  1.折损费用申请 2.油卡 3.预付申请  4.折损出库 5.费用申请6.核销费用申请7.保费申请8.轮胎入库登记9.驾驶员报销折现）
	* 						startTime-开始时间(String)、endTime-结束时间(String) 没有值传''
	* 						pageStartIndex -页开始索引
	 * 						pageSize -页大小
	 * 						sEcho -前台带过来的参数，不动返回回去的
	* 					 ]
	* 
	* @return		{
	 * 					records:[ id-id号、type-类型、mark-事由、money-金额、status-状态、insertUser-插入人、insertTime-插入时间  ]
	 * 			0		totalCounts -总记录数
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
			Pager<CashInOut> pager = cashInOutMngService.getPageData(params);
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
	 * 保存收支信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:17:01 
	* @parameter  bean [ type-类型(String)、mark-事由(String)、money-金额(double)  ]
	* @return
	 */
	@RequestMapping(value = "/save",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> save(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CashInOut bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "保存失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			cashInOutMngService.save(bean, oper);
			
			result.put("code", "200");
			result.put("msg", "成功");
			
		}catch(Exception e){
			e.printStackTrace();
			result.put("msg", "保存失败："+e.getMessage());		
		}		
		return result;
	}
	
	/**
	 * 获取收支信息-用于修改
	* @author  fengql 
	* @date 2016年9月21日 上午10:27:01
	* @parameter  id-id号(int) 必传
	* @return	  bean [ id-id号、type-类型、mark-事由、money-金额、status-状态、insertUser-插入人、insertTime-插入时间  ]
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
			CashInOut bean = cashInOutMngService.getById(id);
			
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
	 * 修改收支信息
	* @author  fengql 
	* @date 2016年9月21日 上午10:31:01 
	* @parameter  bean [ id-id号(int)、type-类型(String)、mark-事由(String)、money-金额(double) ]
	* @return
	 */
	@RequestMapping(value = "/update",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> update(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody CashInOut bean
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "修改失败");
		
		try{
			String oper = CommonUtil.getOperId(request);//操作员
			cashInOutMngService.update(bean, oper);
			
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
			cashInOutMngService.updateById(id, oper);
			
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
	* @author  fengql 
	* @date 2016年10月14日 下午1:30:45 
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
			cashInOutMngService.submit(id, oper);
			
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
	* @author  fengql 
	* @date 2016年10月26日 下午2:19:54 
	* @parameter  params [ type-类型(String)、status-状态(String) 、mark-事由(String,模糊查询)、departmentId-部门,businessType-类别（直接传中文  1.折损费用申请 2.油卡 3.预付申请  4.折损出库 5.费用申请6.核销费用申请7.保费申请8.轮胎入库登记9.驾驶员报销折现）
	* 					startTime-开始时间(String)、endTime-结束时间(String) ]  没有值的传''
	* 
	* @return	list [ id-id号、type-类型、mark-事由、money-金额、status-状态、insertUser-插入人、insertTime-插入时间  ]
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
			List<CashInOut> list = cashInOutMngService.getPrint(params);
				
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
	* @author  fengql 
	* @date 2016年10月26日 下午2:19:54 
	* @parameter  params [ type-类型(String)、status-状态(String)、mark-事由(String,模糊查询)、departmentId-部门,businessType-类别（直接传中文  1.折损费用申请 2.油卡 3.预付申请  4.折损出库 5.费用申请6.核销费用申请7.保费申请8.轮胎入库登记9.驾驶员报销折现）
	* 					startTime-开始时间(String)、endTime-结束时间(String)]  没有值的传''
	* 
	* @return	list [ type-类型、mark-事由、money-金额、status-状态、insertUser-插入人、insertTime-插入时间  ]
	 */
	@RequestMapping(value = "/export", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void export(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("type") String type,
			@RequestParam("status") String status,
			@RequestParam("mark") String mark,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam("departmentId") String departmentId ,
			@RequestParam("businessType") String businessType
			) throws Exception {

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("status", status);
		params.put("mark", mark);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("departmentId", departmentId);
		params.put("businessType", businessType);
		Map<String, Object> formatData = cashInOutMngService.getExportData(params);

		String fileName = "收支管理Excel";
		String fileExtend = "xls";
		POIUtil.exportToExcel(request, response, formatData, fileName,
				fileExtend);

	}
	
	/**
	 * 现金收入查询页面
	 *@author  lvhao 
	 *@date 2016年12月19日 下午2:19:54 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/cashInoutSearch",method=RequestMethod.GET)		
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/cashInOutMng/cashInoutSearch");		
		return mv;		
	}
	
	/**
	 * 现金收入查询不分页 ，打印接口getPrint
	* @author  lvhao 
	* @date 2016年12月19日 下午2:19:54 
	* @parameter  params [ type-类型(String)、status-状态(String) 、mark-事由(String,模糊查询)、departmentId-部门,businessType-类别（直接传中文  1.折损费用申请 2.油卡 3.预付申请  4.折损出库 5.费用申请6.核销费用申请7.保费申请8.轮胎入库登记9.驾驶员报销折现）
	* 					startTime-开始时间(String)、endTime-结束时间(String) ]  没有值的传''
	* 
	* @return	list [ id-id号、type-类型、mark-事由、money-金额、status-状态、insertUser-插入人、insertTime-插入时间  ，businessType-类别]
	 */
	@RequestMapping(value = "/getcashInoutSearch",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getcashInoutSearch(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			Pager<CashInOut> pager = cashInOutMngService.getPageData(params);
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
	 * 汇总查询页面
	 *@author  lvhao 
	 *@date 2016年12月19日 下午2:19:54 
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/cashInoutSummarySearch",method=RequestMethod.GET)		
	public ModelAndView cashInoutSummarySearch(HttpServletRequest request, HttpServletResponse response,HttpSession session) throws IOException {
		ModelAndView mv = new ModelAndView("operationMng/cashInOutMng/cashInoutSummarySearch");		
		return mv;		
	}
	/**
	 * 汇总查询、打印
	* @author  lvhao 
	* @date 2016年12月19日 下午2:19:54 
	* @parameter  params [ type-类型(String)、status-状态(String) 、mark-事由(String,模糊查询)、departmentId-部门,businessType-类别（直接传中文  1.折损费用申请 2.油卡 3.预付申请  4.折损出库 5.费用申请6.核销费用申请7.保费申请8.轮胎入库登记9.驾驶员报销折现）
	* 					startTime-开始时间(String)、endTime-结束时间(String) ]  没有值的传''
	* 
	* @return	{inCount-总收入 ，outCount-总支出，结余 - balance ，year -当前年月 ，   list [ exportTime-月/日，departmentName-部门，insertUser-经办人，mark-摘要，money-支出或收入，type-类型]}
	 */
	@RequestMapping(value = "/getcashInoutSummarySearch",method=RequestMethod.POST,headers={"Content-Type=application/json"})
	@ResponseBody
	public Map<String, Object> getcashInoutSummarySearch(HttpServletRequest request, 
			HttpServletResponse response,
			HttpSession session,
			@RequestBody Map<String, Object> params
			) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", "300");
		result.put("msg", "获取失败");
		
		try{
			List<CashInOut> list = cashInOutMngService.getPrint(params);
			SimpleDateFormat exportDateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_4);
			double inCount = 0 ;//总收入
			double outCount = 0 ;//总支出
			for (CashInOut cashInOut : list) {
				 cashInOut.setExportTime(exportDateFormat.format(cashInOut.getInsertTime()));
				 switch (cashInOut.getType()) {
				 case Constants.CashInOutType.IN:
					inCount += cashInOut.getMoney() ;
					break;
				 case Constants.CashInOutType.OUT:
					outCount += cashInOut.getMoney() ;
					break;
				 default:
					break;
				}
			}
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_6);
			SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_SHORT);
			String startTime=params.get("startTime")+"";
			String endTime=params.get("endTime")+"";
			if(null != list && list.size() > 0)
			{
				if(null == startTime || "".equals(startTime))
				{
					if(null != list.get(0).getInsertTime())
					{
						startTime = simpleDateFormat.format(list.get(0).getInsertTime());
					}
				}
				else
				{
					startTime = simpleDateFormat.format(simpleDateFormat2.parse(startTime));
				}
				if(null == endTime || "".equals(endTime))
				{
					if(null != list.get(list.size()-1).getInsertTime())
					{
						endTime = simpleDateFormat.format(list.get(list.size()-1).getInsertTime());
					}
				}
				else
				{
					endTime = simpleDateFormat.format(simpleDateFormat2.parse(endTime));
				}
			}
			result.put("inCount", inCount);//总收入
			result.put("outCount", outCount);//总支出
			result.put("balance", inCount - outCount);//结余
			result.put("year", startTime+"-"+endTime);//当前年月
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
	 * 汇总查询导出
	* @author  lvhao 
	* @date 2016年12月19日 下午2:19:54 
	* @parameter  params [ type-类型(String)、status-状态(String) 、mark-事由(String,模糊查询)、departmentId-部门,businessType-类别（直接传中文  1.折损费用申请 2.油卡 3.预付申请  4.折损出库 5.费用申请6.核销费用申请7.保费申请8.轮胎入库登记9.驾驶员报销折现）
	* 					startTime-开始时间(String)、endTime-结束时间(String) ]  没有值的传''
	* 
	* @return	list [ type-类型、mark-事由、money-金额、status-状态、insertUser-插入人、insertTime-插入时间  ]
	 */
	@RequestMapping(value = "/exportcashInoutSummary", method = RequestMethod.POST, headers={"Content-Type=application/x-www-form-urlencoded"})
	@ResponseBody
	public void exportSummary(HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam("type") String type,
			@RequestParam("status") String status,
			@RequestParam("mark") String mark,
			@RequestParam("startTime") String startTime,
			@RequestParam("endTime") String endTime,
			@RequestParam("departmentId") String departmentId ,
			@RequestParam("businessType") String businessType
			) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("status", status);
		params.put("mark", mark);
		params.put("startTime", startTime);
		params.put("endTime", endTime);
		params.put("departmentId", departmentId);
		params.put("businessType", businessType);
		String fileName = "财务表格";
		String fileExtend = "xls";
		POIUtil.addDownloadHeader(request, response, fileName, fileExtend);
		List<CashInOut> list = cashInOutMngService.getPrint(params);
		SimpleDateFormat exportDateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_4);
		double inCount = 0 ;//总收入
		double outCount = 0 ;//总支出
		for (CashInOut cashInOut : list) {
			 cashInOut.setExportTime(exportDateFormat.format(cashInOut.getInsertTime()));
			 switch (cashInOut.getType()) {
			 case Constants.CashInOutType.IN:
				inCount += cashInOut.getMoney() ;
				break;
			 case Constants.CashInOutType.OUT:
				outCount += cashInOut.getMoney() ;
				break;
			 default:
				break;
			}
		}
		ServletOutputStream outStream = response.getOutputStream();
		Map<String, Object> root=new HashMap<String, Object>();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_CUSTOM_6);
		SimpleDateFormat simpleDateFormat2 = new SimpleDateFormat(Constants.DATE_TIME_FORMAT_SHORT);
		root.put("inCount", inCount);//总收入
		root.put("outCount", outCount);//总支出
		root.put("balance", inCount - outCount);//结余
		root.put("list", list);
		if(null != list && list.size() > 0)
		{
			if(null == startTime || "".equals(startTime))
			{
				if(null != list.get(0).getInsertTime())
				{
					startTime = simpleDateFormat.format(list.get(0).getInsertTime());
				}
			}
			else
			{
				startTime = simpleDateFormat.format(simpleDateFormat2.parse(startTime));
			}
			if(null == endTime || "".equals(endTime))
			{
				if(null != list.get(list.size()-1).getInsertTime())
				{
					endTime = simpleDateFormat.format(list.get(list.size()-1).getInsertTime());
				}
			}
			else
			{
				endTime = simpleDateFormat.format(simpleDateFormat2.parse(endTime));
			}
		}
		root.put("year", startTime+"-"+endTime);//查询时间段
		root.put("template", "CashInOut.ftl");  
		InputStream in= new POIUtil() {
		}.exportComplexExcel(root, ".xls", request);
		int c;
		while((c=in.read())!=-1){
			 outStream.write(c);
        }
		outStream.flush();
	}
	
	
}
