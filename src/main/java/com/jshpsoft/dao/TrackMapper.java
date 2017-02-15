package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Track;

/**
 * 运输车辆管理dao
* @author  fengql 
* @date 2016年9月26日 上午10:47:11
 */
public interface TrackMapper {

	public Track getById(Integer id) throws Exception ;

	public List<Track> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(Track bean)  throws Exception;

	public int update(Track bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<Track> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public int updateByNo(Map<String, Object> params) throws Exception;

	public Track getByCarNumber(String carNumber) throws Exception;
}
