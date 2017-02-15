package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TaskHistory;

/**
 * 
 * @Description: 历史任务dao
 * @author army.liu
 * @date 2016年10月8日 上午10:20:06
 *
 */
public interface TaskHistoryMapper {
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<TaskHistory> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<TaskHistory> getByConditions(Map<String, Object> params) throws Exception ;
	
	public List<TaskHistory> getTaskList(Map<String, Object> params) throws Exception ;
	
	public TaskHistory getById(int id) throws Exception ;
	
	public void insert(TaskHistory bean)  throws Exception;

	public int update(TaskHistory bean) throws Exception;
	
}
