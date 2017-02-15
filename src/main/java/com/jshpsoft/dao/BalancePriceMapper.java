package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.BalancePriceSetting;
/**
 * 结算价格管理dao
* @author  fengql 
* @date 2016年9月26日 上午10:47:11
 */
public interface BalancePriceMapper {

	public BalancePriceSetting getById(Integer id) throws Exception ;

	public List<BalancePriceSetting> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(BalancePriceSetting bean)  throws Exception;

	public int update(BalancePriceSetting bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<BalancePriceSetting> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
