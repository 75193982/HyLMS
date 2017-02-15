package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackInsuranceDetail;

/**
 * 保费明细dao
* @author  fengql 
* @date 2016年10月20日 上午10:38:16
 */
public interface TrackInsuranceDetailMapper {
	
	public void insert(TrackInsuranceDetail bean) throws Exception;
	
	public void update(TrackInsuranceDetail bean) throws Exception;

	public List<TrackInsuranceDetail> getByConditions(Map<String, Object> params) throws Exception;
	
	public void deleteByParentId(Integer parentId) throws Exception;
	
	public int updateByParentId(Map<String, Object> params) throws Exception;
}
