package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarBrand;

/**
 * 汽车品牌管理dao
* @author  fengql 
* @date 2016年9月26日 上午10:47:11
 */
public interface CarBrandMapper {

	public CarBrand getById(Integer id) throws Exception ;

	public List<CarBrand> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(CarBrand bean)  throws Exception;

	public int update(CarBrand bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<CarBrand> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
