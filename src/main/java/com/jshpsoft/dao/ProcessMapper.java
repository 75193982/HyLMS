package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ProcessInfo;

/** 
 * 流程mapper
 * @author  army.liu
 */
public interface ProcessMapper {
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<ProcessInfo> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<ProcessInfo> getByConditions(Map<String, Object> params) throws Exception ;
	
	public ProcessInfo getById(int id) throws Exception ;
	
	public void insert(ProcessInfo bean)  throws Exception;

	public int update(ProcessInfo bean) throws Exception;

}
