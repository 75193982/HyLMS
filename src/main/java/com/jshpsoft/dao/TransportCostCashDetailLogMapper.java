package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportCostCashDetailLog;

/**
 * 装运费用现金明细日志dao
 * @author  army.liu 
 */
public interface TransportCostCashDetailLogMapper {
	
	public void insert(TransportCostCashDetailLog bean) throws Exception;
	
	public int update(Map<String, Object> params) throws Exception;
	
	public List<TransportCostCashDetailLog> getByTransportCostCashDetailId(int transportCostCashDetailId) throws Exception;
	
}
