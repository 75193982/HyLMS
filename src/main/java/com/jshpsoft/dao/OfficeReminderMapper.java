package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OfficeReminder;

/**
 * 备忘信息dao
* @author  fengql 
* @date 2016年10月19日 下午4:27:45
 */
public interface OfficeReminderMapper {

	public OfficeReminder getById(Integer id) throws Exception ;

	public void insert(OfficeReminder bean)  throws Exception;

	public int update(OfficeReminder bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<OfficeReminder> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
