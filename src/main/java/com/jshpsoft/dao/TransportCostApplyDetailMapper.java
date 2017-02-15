package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportCostApplyDetail;

/**
 * 装运费用核算申请明细dao
* @author  fengql 
* @date 2016年10月21日 上午11:21:53
 */
public interface TransportCostApplyDetailMapper {
	
	public void insert(TransportCostApplyDetail bean) throws Exception;
	
	public List<TransportCostApplyDetail> getByConditions(Map<String, Object> params) throws Exception;
	
	public void deleteByParentId(Integer parentId) throws Exception;
	
	public int updateByParentId(Map<String, Object> params) throws Exception;

	public void update(TransportCostApplyDetail cost) throws Exception;
}
