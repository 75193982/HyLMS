package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarStockInOutDetail;

/**
 * 商品车出入库明细表dao
* @author  fengql 
* @date 2016年9月28日 下午1:57:26
 */
public interface CarStockInOutDetailMapper {

	public void insert(CarStockInOutDetail bean)  throws Exception;
	
	public int update(CarStockInOutDetail bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;

	public List<CarStockInOutDetail> getByConditions(Map<String, Object> params)  throws Exception;
	
	public void insertByParams(Map<String, Object> params) throws Exception;
	
	public int updateByBusinessId(Map<String, Object> params) throws Exception;
	
	public List<CarStockInOutDetail> getDetailByParentId(Map<String, Object> params) throws Exception;
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
