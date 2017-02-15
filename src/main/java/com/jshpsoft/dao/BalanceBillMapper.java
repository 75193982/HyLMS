package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.BalanceBill;

/**
 * 对账信息dao
* @author  fengql 
* @date 2016年11月4日 下午2:19:24
 */
public interface BalanceBillMapper {

	public BalanceBill getById(Integer id) throws Exception ;

	public void insert(BalanceBill bean)  throws Exception;

	public int update(BalanceBill bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 上游对账
	 */
	public List<BalanceBill> getByConditionsUp(Map<String, Object> params)  throws Exception;
	
	public List<BalanceBill> getPageListUp(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCountUp(Map<String, Object> params) throws Exception;
	
	public BalanceBill getDetailByIdUp(Integer id) throws Exception ;
	
	/**
	 * 下游对账
	 */
	public List<BalanceBill> getByConditionsDown(Map<String, Object> params)  throws Exception;
	
	public List<BalanceBill> getPageListDown(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCountDown(Map<String, Object> params) throws Exception;
	
	public BalanceBill getDetailByIdDown(Integer id) throws Exception ;
}
