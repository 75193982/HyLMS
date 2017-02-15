package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportPrepayApplyDetail;

/**
 * 装运预付申请明细dao
* @author  fengql 
* @date 2016年10月21日 上午11:21:53
 */
public interface TransportPrepayApplyDetailMapper {
	
	public void insert(TransportPrepayApplyDetail bean) throws Exception;
	
	public List<TransportPrepayApplyDetail> getByConditions(Map<String, Object> params) throws Exception;
	
	public void deleteByParentId(Integer parentId) throws Exception;
	
	public int updateByParentId(Map<String, Object> params) throws Exception;
}
