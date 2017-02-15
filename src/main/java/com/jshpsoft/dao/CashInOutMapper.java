package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CashInOut;

/**
 * 现金收支dao
* @author  fengql 
* @date 2016年10月18日 下午4:26:29
 */
public interface CashInOutMapper {

	public void insert(CashInOut bean)  throws Exception;
	
	public void update(CashInOut bean)  throws Exception;
	
	public List<CashInOut> getByConditions(Map<String, Object> params) throws Exception;
	
	public List<CashInOut> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public CashInOut getById(Integer id)throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
}
