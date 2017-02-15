package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OilCardStock;

/**
 * 油卡库存dao 
* @author  fengql 
* @date 2016年10月19日 上午9:19:23
 */
public interface OilCardStockMapper {

	public OilCardStock getById(Integer id) throws Exception ;

	public List<OilCardStock> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(OilCardStock bean)  throws Exception;

	public int update(OilCardStock bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<OilCardStock> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
