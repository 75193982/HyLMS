package com.jshpsoft.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.dao.BusinessOperateLogMapper;
import com.jshpsoft.domain.BusinessOperateLog;
import com.jshpsoft.service.BusinessOperateLogService;

@Service
public class BusinessOperateLogServiceImpl implements BusinessOperateLogService {

	@Autowired
	private BusinessOperateLogMapper businessOperateLogMapper;
	
	@Override
	public int insertLog(BusinessOperateLog bean) {
		//TODO
		
		return businessOperateLogMapper.insert(bean);
		
	}

	
}
