package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ScheduleBillChangeApply;

/**
 * 调度修改申请dao
 * @author  army.liu 
 */
public interface ScheduleBillChangeApplyMapper {

	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<ScheduleBillChangeApply> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<ScheduleBillChangeApply> getByConditions(Map<String, Object> params)  throws Exception;
	
	public void insert(ScheduleBillChangeApply bean)  throws Exception;

	public int update(ScheduleBillChangeApply bean) throws Exception;
	
	public ScheduleBillChangeApply getById(Integer id) throws Exception;
	
}
