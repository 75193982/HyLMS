package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackTyreInOutDetail;

/**
 * 轮胎出入库明细dao
* @author  fengql 
* @date 2016年10月14日 上午9:53:28
 */
public interface TrackTyreInOutDetailMapper {
	
	public void insert(TrackTyreInOutDetail bean) throws Exception;
	
	public List<TrackTyreInOutDetail> getByConditions(Map<String, Object> params) throws Exception;
	
	public int updateByParentId(Map<String, Object> params) throws Exception;
	
	public void update(TrackTyreInOutDetail bean) throws Exception;
	
	public TrackTyreInOutDetail getById(Integer id)throws Exception;
}
