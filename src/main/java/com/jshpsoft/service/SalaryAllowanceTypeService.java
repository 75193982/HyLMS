package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.SalaryAllowanceType;
import com.jshpsoft.util.Pager;

public interface SalaryAllowanceTypeService {

	public Pager<SalaryAllowanceType> getPageData(Map<String, Object> params)  throws Exception;

	public void save(SalaryAllowanceType bean, String operId) throws Exception;

	public SalaryAllowanceType getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;

	public List<SalaryAllowanceType> getByConditions(Map<String, Object> params) throws Exception;
	
}
