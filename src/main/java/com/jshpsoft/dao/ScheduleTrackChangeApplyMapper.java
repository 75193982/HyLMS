package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ScheduleTrackChangeApply;

/**
 * 换车变更申请dao
* @author  fengql 
* @date 2016年9月30日 下午4:24:53
 */
public interface ScheduleTrackChangeApplyMapper {

	public void insert(ScheduleTrackChangeApply bean)  throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<ScheduleTrackChangeApply> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public ScheduleTrackChangeApply getById(Integer id) throws Exception ;

	public int update(ScheduleTrackChangeApply bean) throws Exception;
	
	public List<ScheduleTrackChangeApply> getByConditions(Map<String, Object> params) throws Exception;
}
