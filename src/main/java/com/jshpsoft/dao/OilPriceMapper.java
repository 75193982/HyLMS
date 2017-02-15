package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OilPrice;

/**
 * 油价管理dao
* @author  fengql 
* @date 2016年9月30日 下午5:19:22
 */
public interface OilPriceMapper {

	public OilPrice getById(Integer id) throws Exception ;

	public List<OilPrice> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(OilPrice bean)  throws Exception;

	public int update(OilPrice bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<OilPrice> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<OilPrice> getOilPriceList()  throws Exception;
}
