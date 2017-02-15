package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackTyreStock;

/**
 * 轮胎库存dao
* @author  fengql 
* @date 2016年10月14日 上午9:54:51
 */
public interface TrackTyreStockMapper {
	
	public void insert(TrackTyreStock bean) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<TrackTyreStock> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void update(TrackTyreStock bean) throws Exception;
	
	public List<TrackTyreStock> getByConditions(Map<String, Object> params) throws Exception;
	
	public TrackTyreStock getById(Integer id)throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	public int updateByTyreNo(Map<String, Object> params) throws Exception;
}
