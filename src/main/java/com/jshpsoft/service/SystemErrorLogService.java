package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.SystemErrorLog;
import com.jshpsoft.util.Pager;

/**
 * 用户service
 * @author Administrator
 *
 */
public interface SystemErrorLogService {

	public int insert(SystemErrorLog bean);
	
	/*public List<SystemErrorLog> getByConditions(Map<String, Object> params);*/
	
	public Pager<SystemErrorLog> getPageData(Map<String, Object> params) throws Exception;
	
	public SystemErrorLog getById(int id) throws Exception;
}
