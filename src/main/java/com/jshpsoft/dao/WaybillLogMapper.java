package com.jshpsoft.dao;

import com.jshpsoft.domain.WaybillLog;

/**
 * 运单跟踪
* @author  fengql 
* @date 2016年11月26日 下午2:03:15
 */
public interface WaybillLogMapper {

	public WaybillLog getByWaybillId(Integer waybillId) throws Exception ;

	public void insert(WaybillLog bean)  throws Exception;

	public int update(WaybillLog bean) throws Exception;
}
