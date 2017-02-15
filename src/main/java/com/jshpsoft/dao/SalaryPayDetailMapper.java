package com.jshpsoft.dao;

import com.jshpsoft.domain.SalaryPayDetail;

import java.util.List;
import java.util.Map;

public interface SalaryPayDetailMapper {
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<SalaryPayDetail> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<SalaryPayDetail> getByConditions(Map<String, Object> params) throws Exception ;

    int insert(SalaryPayDetail record) throws Exception ;

    int update(SalaryPayDetail record) throws Exception ;

	public SalaryPayDetail getById(Integer id) throws Exception ;

	public void deleteByParentId(Integer parentId) throws Exception ;
	
}