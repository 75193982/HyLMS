
package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackMaintenanceApply;

/**
 * 维修保养dao
* @author  fengql 
* @date 2016年10月17日 下午5:11:32
 */
public interface TrackMaintenanceApplyMapper {
	
	public void insert(TrackMaintenanceApply bean) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<TrackMaintenanceApply> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public TrackMaintenanceApply getById(Integer id)throws Exception;
	
	public void update(TrackMaintenanceApply bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	public List<TrackMaintenanceApply> getTrackMaintenanceApply(Map<String, Object> params) throws Exception;
	
	public List<TrackMaintenanceApply> getByConditions(Map<String, Object> params) throws Exception;
}
