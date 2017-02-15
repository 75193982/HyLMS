package com.jshpsoft.dao;

import com.jshpsoft.domain.SalaryPay;
import java.util.List;
import java.util.Map;

public interface SalaryPayMapper {
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<SalaryPay> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<SalaryPay> getByConditions(Map<String, Object> params) throws Exception ;

    int insert(SalaryPay record) throws Exception ;

    int update(SalaryPay record) throws Exception ;

	public SalaryPay getById(Integer id) throws Exception ;
}