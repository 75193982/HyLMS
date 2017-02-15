package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackRepairApply;

/**
 * 折损维修登记mapper
 * @author  lvhao 
 * @date 2016年12月21日 上午8:35:59
 */
public interface TrackRepairApplyMapper {
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<TrackRepairApply> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存
	 * @param apply
	 * @return
	 * @throws Exception
	 */
	public int save(TrackRepairApply apply) throws Exception;
	
	
	public TrackRepairApply getDetail(int id) throws Exception;
	
	
	public int update(TrackRepairApply apply) throws Exception ;
	
	
	public List<TrackRepairApply> getByConditions(Map<String, Object> params) throws Exception;
}
