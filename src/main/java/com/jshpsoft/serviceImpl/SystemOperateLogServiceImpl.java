package com.jshpsoft.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.dao.SystemOperateLogMapper;
import com.jshpsoft.domain.SystemOperateLog;
import com.jshpsoft.service.SystemOperateLogService;
import com.jshpsoft.util.Pager;

@Service("systemOperateLogService")
public class SystemOperateLogServiceImpl implements SystemOperateLogService {

	@Autowired
	private SystemOperateLogMapper systemOperateLogMapper;
	
	@Override
	public int insert(SystemOperateLog bean) {
		return systemOperateLogMapper.insert(bean);
		
	}

	@Override
	public Pager<SystemOperateLog> getPageData(Map<String, Object> params) throws Exception
	{
		String pageSize;
		try {
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		} catch (Exception e) {
			throw new RuntimeException("参数缺失或不正确");
		}
		List<SystemOperateLog> list = systemOperateLogMapper.getPageList(params);
		int totalCount = systemOperateLogMapper.getPageTotalCount(params);
		Pager<SystemOperateLog> pager = new Pager<SystemOperateLog>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

	
}
