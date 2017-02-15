package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.util.Pager;

/**
 * 成本管理service
* @author  fengql 
* @date 2016年10月25日 上午9:51:12
 */
public interface CostMngService {
	
	/**
	 * 根据参数获取成本信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<BalanceCar> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取总金额
	* @author  fengql 
	* @date 2016年12月7日 上午10:51:46 
	* @parameter  
	* @return
	 */
	public double getSumPrice(Map<String, Object> params) throws Exception;
	
	/**
	 * 打印数据
	* @author  fengql 
	* @date 2016年10月25日 上午10:17:33 
	* @parameter  
	* @return
	 */
	public List<BalanceCar> getPrint(Map<String, Object> params) throws Exception;
		
	/**
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月19日 下午1:14:07 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
	
	/**
	 * 对账
	* @author  fengql 
	* @date 2016年11月4日 下午1:52:28 
	* @parameter  
	* @return
	 */
	public void balance(Integer id, String oper) throws Exception;
	
	/**
	 * 
	 * @author  ww 
	 * @date 2017年1月10日 下午1:23:50
	 * @parameter  
	 * @return
	 */
	public BalanceCar getBalanceCar(BalanceCar bean) throws Exception;
}
