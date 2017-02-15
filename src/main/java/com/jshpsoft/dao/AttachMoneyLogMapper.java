package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.AttachMoneyLog;

/**
 * 额外计费dao
* @author  fengql 
* @date 2016年10月25日 上午11:28:29
 */
public interface AttachMoneyLogMapper {
	
	public void insert(AttachMoneyLog bean) throws Exception;
	
	public List<AttachMoneyLog> getByConditions(Map<String, Object> params) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
}
