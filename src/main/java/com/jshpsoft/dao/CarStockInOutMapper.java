package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarStockInOut;

/**
 * 商品车出入库表dao
* @author  fengql 
* @date 2016年9月28日 下午1:57:26
 */
public interface CarStockInOutMapper {
	
	public void insert(CarStockInOut bean)  throws Exception;
	
	public int update(CarStockInOut bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	public CarStockInOut getById(Integer id) throws Exception ;
	
	public List<CarStockInOut> getByConditions(Map<String, Object> params)  throws Exception;
	
	public int updateByBusinessId(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<CarStockInOut> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
