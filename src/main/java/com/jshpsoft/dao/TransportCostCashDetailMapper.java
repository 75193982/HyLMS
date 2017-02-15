package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportCostCashDetail;

/**
 * 装运费用现金明细dao
* @author  fengql 
* @date 2016年10月21日 上午11:21:53
 */
public interface TransportCostCashDetailMapper {
	
	public void insert(TransportCostCashDetail bean) throws Exception;
	
	public List<TransportCostCashDetail> getByConditions(Map<String, Object> params) throws Exception;
	
	public void deleteByDetailId(Integer detailId) throws Exception;
	
	public int updateByDetailId(Map<String, Object> params) throws Exception;

	public TransportCostCashDetail getById(Integer id) throws Exception;
}
