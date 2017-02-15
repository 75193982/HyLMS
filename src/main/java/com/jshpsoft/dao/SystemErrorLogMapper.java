package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.jshpsoft.domain.SystemErrorLog;

@Service
public interface SystemErrorLogMapper {

	int insert(SystemErrorLog bean);

    List<SystemErrorLog> getByConditions(Map<String, Object> params);
    
    public List<SystemErrorLog> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public SystemErrorLog getById(int id) throws Exception;
}
