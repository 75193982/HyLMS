package com.jshpsoft.service;

import com.jshpsoft.domain.BusinessOperateLog;

/**
 * 用户service
 * @author Administrator
 *
 */
public interface BusinessOperateLogService {

	public int insertLog(BusinessOperateLog bean);
	
	/*public List<BusinessOperateLog> getByConditions(Map<String, Object> params);*/
}
