package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;
import com.jshpsoft.domain.TransportPriceSetting;

/**
 * 驳板价格管理dao
* @author  fengql 
* @date 2016年9月26日 上午10:47:11
 */
public interface TransportPriceMapper {

	public TransportPriceSetting getById(Integer id) throws Exception ;

	public List<TransportPriceSetting> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(TransportPriceSetting bean)  throws Exception;

	public int update(TransportPriceSetting bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<TransportPriceSetting> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
