
package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackTyreInOut;

/**
 * 轮胎出入库dao
* @author  fengql 
* @date 2016年10月14日 上午9:53:43
 */
public interface TrackTyreInOutMapper {
	
	public void insert(TrackTyreInOut bean) throws Exception;
	
	public List<TrackTyreInOut> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<TrackTyreInOut> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public TrackTyreInOut getById(Integer id)throws Exception;
	
	public void update(TrackTyreInOut bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	public TrackTyreInOut getByBillNo(String billNo)throws Exception;
}
