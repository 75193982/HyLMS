package com.jshpsoft.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.dao.SystemErrorLogMapper;
import com.jshpsoft.domain.SystemErrorLog;
import com.jshpsoft.service.SystemErrorLogService;
import com.jshpsoft.util.Pager;

@Service("systemErrorLogService")
public class SystemErrorLogServiceImpl implements SystemErrorLogService {

	@Autowired
	private SystemErrorLogMapper systemErrorLogMapper;
	
	@Override
	public int insert(SystemErrorLog bean) {
		return systemErrorLogMapper.insert(bean);
		
	}

	@Override
	public Pager<SystemErrorLog> getPageData(Map<String, Object> params)
			throws Exception 
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
		List<SystemErrorLog> list = systemErrorLogMapper.getPageList(params);
		int totalCount = systemErrorLogMapper.getPageTotalCount(params);
		Pager<SystemErrorLog> pager = new Pager<SystemErrorLog>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

	@Override
	public SystemErrorLog getById(int id) throws Exception {
		return systemErrorLogMapper.getById(id);
	}

	
}
