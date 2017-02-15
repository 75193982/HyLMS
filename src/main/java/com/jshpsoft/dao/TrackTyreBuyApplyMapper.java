package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackTyreBuyApply;


/**
 * @author  ww 
 * @date 2016年12月10日 下午12:57:52
 */
public interface TrackTyreBuyApplyMapper {
	
	public List<TrackTyreBuyApply> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void insert(TrackTyreBuyApply bean) throws Exception;
	
	public List<TrackTyreBuyApply> getByConditions(Map<String, Object> params) throws Exception;
	
	public TrackTyreBuyApply getById(int id) throws Exception;
	
	public void update(TrackTyreBuyApply bean) throws Exception;

}
