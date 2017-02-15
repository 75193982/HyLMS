package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.OtherContacts;
import com.jshpsoft.domain.OtherContactsLog;
import com.jshpsoft.util.Pager;

/**
 * 其他往来款service
* @author  fengql 
* @date 2017年1月9日 下午4:08:10
 */
public interface OtherContactsService {
	
	/**
	 * 根据参数获取往来款列表-分页
	* @author  fengql 
	* @date 2017年1月9日 下午4:09:02 
	* @parameter  
	* @return
	 */
	public Pager<OtherContacts> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取往来款列表-不分页
	 * @author  fengql 
	 * @date 2017年1月9日 下午4:09:02 
	 * @parameter  
	 * @return
	 */
	public List<OtherContacts> getPrintData(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取往来款导出数据
	* @author  fengql 
	* @date 2017年1月12日 上午10:49:31 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getRecExportData(Map<String, Object> params)throws Exception;
	
	/**
	 * 获取往来款导出数据
	 * @author  fengql 
	 * @date 2017年1月12日 上午10:49:31 
	 * @parameter  
	 * @return
	 */
	public Map<String, Object> getPayExportData(Map<String, Object> params)throws Exception;
	
	/**
	 * 保存或更新
	* @author  fengql 
	* @date 2017年1月9日 下午4:10:09 
	* @parameter  
	* @return
	 */
	public void save(OtherContacts bean, String oper, HttpServletRequest req) throws Exception;
	
	/**
	 * 根据id获取明细
	* @author  fengql 
	* @date 2017年1月9日 下午4:10:19 
	* @parameter  
	* @return
	 */
	public OtherContacts getById(Integer id) throws Exception;
	
	/**
	 * 根据id更新--删除
	* @author  fengql 
	* @date 2017年1月9日 下午4:11:16 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 根据id提交
	* @author  fengql 
	* @date 2017年1月9日 下午4:12:01 
	* @parameter  
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 保存往来款核销记录
	* @author  fengql 
	* @date 2017年1月17日 上午10:02:22 
	* @parameter  
	* @return
	 */
	public void saveLog(OtherContactsLog bean, String oper) throws Exception;
	
	/**
	 * 获取核销记录
	* @author  fengql 
	* @date 2017年1月17日 上午10:05:35 
	* @parameter  
	* @return
	 */
	public List<OtherContactsLog> getLogById(Integer id) throws Exception;
	
	/**
	 * 获取往来款报表
	* @author  fengql 
	* @date 2017年1月11日 上午10:37:20 
	* @parameter  
	* @return
	 */
	public List<OtherContacts> getReportData(Map<String, Object> params) throws Exception;
	
	/**
	 * 导出应收往来款报表
	* @author  fengql 
	* @date 2017年1月11日 下午2:02:04 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getRecExportReport(Map<String, Object> params)throws Exception;
	
	/**
	 * 导出应付往来款报表
	* @author  fengql 
	* @date 2017年1月11日 下午2:14:16 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getPayExportReport(Map<String, Object> params)throws Exception;
	
}
