package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.SystemOperateLog;
import com.jshpsoft.util.Pager;

/**
 * 用户service
 * @author Administrator
 *
 */
public interface SystemOperateLogService {

	public int insert(SystemOperateLog bean);
	
	public Pager<SystemOperateLog> getPageData(Map<String, Object> params) throws Exception;
}
