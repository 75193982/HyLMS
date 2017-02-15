package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackTyreChangeApply;

/**
 * 轮胎更换dao
* @author  fengql 
* @date 2016年10月27日 上午9:59:44
 */
public interface TrackTyreChangeApplyMapper {
	
	public void insert(TrackTyreChangeApply bean) throws Exception;

	public List<TrackTyreChangeApply> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void update(TrackTyreChangeApply bean) throws Exception;
	
	public List<TrackTyreChangeApply> getByConditions(Map<String, Object> params) throws Exception;
	
	public TrackTyreChangeApply getById(Integer id)throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
}
