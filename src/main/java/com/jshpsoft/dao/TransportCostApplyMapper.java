
package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportCostApply;

/**
 * 装运费用核算申请dao
* @author  fengql 
* @date 2016年10月21日 上午11:20:44
 */
public interface TransportCostApplyMapper {
	
	public void insert(TransportCostApply bean) throws Exception;
	
	public List<TransportCostApply> getByConditions(Map<String, Object> params) throws Exception;
	
	public List<TransportCostApply> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public TransportCostApply getById(Integer id)throws Exception;
	
	public void update(TransportCostApply bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;

	public Integer getTotalDistanceForDriver(Map<String, Object> params) throws Exception;
}
