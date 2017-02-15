package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.OfficeReminderMapper;
import com.jshpsoft.domain.OfficeReminder;
import com.jshpsoft.service.OfficeReminderService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("officeReminderService")
public class OfficeReminderServiceImpl implements OfficeReminderService {
	
	@Autowired
	private OfficeReminderMapper officeReminderMapper;

	@Override
	@SystemServiceLog(description="查询备忘信息")
	public Pager<OfficeReminder> getPageData(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		params.put("delFlag", Constants.DelFlag.N);
		List<OfficeReminder> list = officeReminderMapper.getPageList(params);
		int totalCount = officeReminderMapper.getPageTotalCount(params);
		
		Pager<OfficeReminder> pager = new Pager<OfficeReminder>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增备忘信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(OfficeReminder bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("备忘信息为空");
		}
		
		//插入备忘信息
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		officeReminderMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取备忘")
	public OfficeReminder getById(Integer id) throws Exception {
		return officeReminderMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新备忘信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(OfficeReminder bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("备忘信息为空");
		}
		
		//更新备忘信息
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		officeReminderMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除备忘信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		officeReminderMapper.updateById(params);
	}

}
