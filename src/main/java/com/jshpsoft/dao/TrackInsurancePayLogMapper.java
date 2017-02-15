package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackInsurancePayLog;

/**
 * 保费支付dao
* @author  fengql 
* @date 2016年10月20日 上午10:37:08
 */
public interface TrackInsurancePayLogMapper {
	
	public void insert(TrackInsurancePayLog bean) throws Exception;
	
	public List<TrackInsurancePayLog> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<TrackInsurancePayLog> getByConditions(Map<String, Object> params) throws Exception;

	public List<TrackInsurancePayLog> getGroupAmount() throws Exception;
}
