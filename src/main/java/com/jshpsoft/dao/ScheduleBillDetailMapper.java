package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ScheduleBillDetail;

/**
 * 调度单明细dao
* @author  fengql 
* @date 2016年9月29日 下午1:26:22
 */
public interface ScheduleBillDetailMapper {

	public void insert(ScheduleBillDetail bean)  throws Exception;

	public int update(ScheduleBillDetail bean) throws Exception;
	
	public int updateByBillNo(Map<String, Object> params) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	public void delete(String scheduleBillNo)  throws Exception;
	
	public List<ScheduleBillDetail> getByBillNo(String scheduleBillNo) throws Exception;
	
	public List<ScheduleBillDetail> getStatusByBillNo(String scheduleBillNo) throws Exception;
	
	public List<ScheduleBillDetail> getByConditions(Map<String, Object> params)  throws Exception;
}
