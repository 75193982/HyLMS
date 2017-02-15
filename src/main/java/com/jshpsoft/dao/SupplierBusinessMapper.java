package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.SupplierBusiness;
/**
 * 供应商业务管理dao
* @author  fengql 
* @date 2016年9月26日 上午10:47:11
 */
public interface SupplierBusinessMapper {

	public SupplierBusiness getById(Integer id) throws Exception ;

	public List<SupplierBusiness> getByConditions(Map<String, Object> params)  throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<SupplierBusiness> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;

	public void insert(SupplierBusiness bean)  throws Exception;

	public int update(SupplierBusiness bean) throws Exception;
	
}
