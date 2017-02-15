
package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportPrepayApply;

/**
 * 装运预付申请dao
* @author  fengql 
* @date 2016年10月21日 上午11:20:44
 */
public interface TransportPrepayApplyMapper {
	
	public void insert(TransportPrepayApply bean) throws Exception;
	
	public List<TransportPrepayApply> getByConditions(Map<String, Object> params) throws Exception;
	
	public List<TransportPrepayApply> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public TransportPrepayApply getById(Integer id)throws Exception;
	
	public void update(TransportPrepayApply bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	public int updateByBillNo(Map<String, Object> params) throws Exception;
	
	public List<TransportPrepayApply> getByBillNo(String scheduleBillNo) throws Exception;
}
