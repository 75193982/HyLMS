package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.SystemOperateLog;

public interface SystemOperateLogMapper {

	int insert(SystemOperateLog bean);

	public List<SystemOperateLog> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
}
