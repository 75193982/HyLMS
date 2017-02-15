package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CashWaitingPayLog;

/**
 * 代付现金dao
 * @author  army.liu
 * @date 2016年12月12日 下午4:26:29
 */
public interface CashWaitingPayLogMapper {

	public void insert(CashWaitingPayLog bean)  throws Exception;
	
	public void update(CashWaitingPayLog bean)  throws Exception;
	
	public List<CashWaitingPayLog> getByConditions(Map<String, Object> params) throws Exception;
	
	public List<CashWaitingPayLog> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public CashWaitingPayLog getById(Integer id)throws Exception;
	
}
