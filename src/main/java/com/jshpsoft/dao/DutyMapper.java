package com.jshpsoft.dao;

import com.jshpsoft.domain.Duty;

import java.util.List;
import java.util.Map;

public interface DutyMapper {
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<Duty> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<Duty> getByConditions(Map<String, Object> params) throws Exception ;
	

    int insert(Duty record) throws Exception ;

    int update(Duty record) throws Exception ;

	public Duty getById(Integer id) throws Exception ;
}