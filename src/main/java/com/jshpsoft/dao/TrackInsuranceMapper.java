package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackInsurance;

/**
 * 保费dao
* @author  fengql 
* @date 2016年10月20日 上午10:37:08
 */
public interface TrackInsuranceMapper {
	
	public void insert(TrackInsurance bean) throws Exception;
	
	public List<TrackInsurance> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void update(TrackInsurance bean) throws Exception;
	
	public List<TrackInsurance> getByConditions(Map<String, Object> params) throws Exception;
	
	public TrackInsurance getById(Integer id)throws Exception;
	
	public int updateById(TrackInsurance bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	public List<TrackInsurance> getTrackInsuranceByCarNumber(Map<String, Object> params) throws Exception;
}
