package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.BalanceBill;
import com.jshpsoft.util.Pager;

/**
 * 对账管理service  上游
* @author  fengql 
* @date 2016年11月4日 下午2:38:16
 */
public interface BalanceBillMngDownService {

	/**
	 * 根据参数获取对账信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<BalanceBill> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据id获取对账信息
	* @author  fengql 
	* @date 2016年11月4日 下午2:47:38 
	* @parameter  
	* @return
	 */
	public BalanceBill getById(Integer id) throws Exception;
	
	/**
	 * 获取对账详细信息-用于查看打印
	* @author  fengql 
	* @date 2016年11月4日 下午3:58:39 
	* @parameter  
	* @return
	 */
	public BalanceBill getDetailPrintData(Integer id) throws Exception;
	
	/**
	 * 更新对账数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(BalanceBill bean, String oper) throws Exception;
	
	/**
	 * 确认对账信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void sure(Integer id, String oper) throws Exception;

	/**
	 * 打印列表
	* @author  fengql 
	* @date 2016年11月4日 下午3:52:33 
	* @parameter  
	* @return
	 */
	public List<BalanceBill> getPrint(Map<String, Object> params) throws Exception;
	
	/**
	 * 导出列表
	* @author  fengql 
	* @date 2016年11月4日 下午3:52:46 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
}
