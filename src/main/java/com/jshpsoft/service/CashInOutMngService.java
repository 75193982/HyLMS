package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.util.Pager;

/**
 * 现金收支管理service
* @author  fengql 
* @date 2016年10月26日 上午10:55:09
 */
public interface CashInOutMngService {
	
	/**
	 * 根据参数获取收支信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<CashInOut> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存收支信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(CashInOut bean, String oper) throws Exception;
	
	/**
	 * 根据id获取收支信息-用于编辑
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public CashInOut getById(Integer id) throws Exception;
	
	/**
	 * 更新收支信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(CashInOut bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 提交收支信息
	* @author  fengql 
	* @date 2016年10月11日 下午4:55:08 
	* @parameter  id号，oper-操作者id
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月19日 下午1:14:07 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
		
	/**
	 * 根据参数获取收支信息-打印
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<CashInOut> getPrint(Map<String, Object> params) throws Exception;

}
