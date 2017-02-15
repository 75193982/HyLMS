package com.jshpsoft.dao;

import com.jshpsoft.domain.SalaryAllowanceType;
import java.util.List;
import java.util.Map;

public interface SalaryAllowanceTypeMapper {
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<SalaryAllowanceType> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<SalaryAllowanceType> getByConditions(Map<String, Object> params) throws Exception ;

    int insert(SalaryAllowanceType record) throws Exception ;

    int update(SalaryAllowanceType record) throws Exception ;

	public SalaryAllowanceType getById(Integer id) throws Exception ;
	
}