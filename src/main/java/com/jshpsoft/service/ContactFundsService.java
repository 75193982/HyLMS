package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ContactFunds;
import com.jshpsoft.util.Pager;

/**
 * 供应商应收款service
* @author  fengql 
* @date 2017年1月9日 下午4:08:10
 */
public interface ContactFundsService {
	
	/**
	 * 根据参数获取款项列表-分页
	* @author  fengql 
	* @date 2017年1月9日 下午4:09:02 
	* @parameter  
	* @return
	 */
	public Pager<ContactFunds> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取款项列表-不分页
	 * @author  fengql 
	 * @date 2017年1月9日 下午4:09:02 
	 * @parameter  
	 * @return
	 */
	public List<ContactFunds> getPrintData(Map<String, Object> params) throws Exception;
	
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
	public void save(ContactFunds bean, String oper) throws Exception;
	
	/**
	 * 根据id获取明细
	* @author  fengql 
	* @date 2017年1月9日 下午4:10:19 
	* @parameter  
	* @return
	 */
	public ContactFunds getById(Integer id) throws Exception;
	
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
	 * 获取往来款报表
	* @author  fengql 
	* @date 2017年1月11日 上午10:37:20 
	* @parameter  
	* @return
	 */
	public List<ContactFunds> getReportData(Map<String, Object> params) throws Exception;
	
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
