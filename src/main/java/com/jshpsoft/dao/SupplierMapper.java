package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Supplier;

/**
 * 供应商管理dao
* @author  fengql 
* @date 2016年9月26日 上午10:47:11
 */
public interface SupplierMapper {

	public Supplier getById(Integer id) throws Exception ;

	public List<Supplier> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(Supplier bean)  throws Exception;

	public int update(Supplier bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<Supplier> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
