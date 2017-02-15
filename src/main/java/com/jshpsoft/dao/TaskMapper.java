package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Task;

/**
 * 
 * @Description: 任务dao
 * @author army.liu
 * @date 2016年10月8日 上午10:20:06
 *
 */
public interface TaskMapper {
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<Task> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<Task> getByConditions(Map<String, Object> params) throws Exception ;
	
	public Task getById(int id) throws Exception ;
	
	public void insert(Task bean)  throws Exception;

	public int updateBySelective(Task bean) throws Exception;
	
}
