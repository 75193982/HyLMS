package com.jshpsoft.dao;

import com.jshpsoft.domain.SalaryPayAllowanceDetail;
import java.util.List;
import java.util.Map;

public interface SalaryPayAllowanceDetailMapper {
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<SalaryPayAllowanceDetail> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<SalaryPayAllowanceDetail> getByConditions(Map<String, Object> params) throws Exception ;

    int insert(SalaryPayAllowanceDetail record) throws Exception ;

    int update(SalaryPayAllowanceDetail record) throws Exception ;

	public SalaryPayAllowanceDetail getById(Integer id) throws Exception ;
}