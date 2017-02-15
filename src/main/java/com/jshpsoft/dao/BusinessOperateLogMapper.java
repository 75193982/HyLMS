package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.jshpsoft.domain.BusinessOperateLog;

@Service
public interface BusinessOperateLogMapper {

	int insert(BusinessOperateLog bean);

    List<BusinessOperateLog> getByConditions(Map<String, Object> params);
	
}
