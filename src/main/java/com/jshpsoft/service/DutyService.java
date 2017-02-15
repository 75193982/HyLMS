package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Duty;
import com.jshpsoft.util.Pager;

public interface DutyService {

	public Pager<Duty> getPageData(Map<String, Object> params)  throws Exception;

	public void save(Duty bean, String operId) throws Exception;

	public Duty getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;

	public List<Duty> getByConditions(Map<String, Object> params) throws Exception;
	
}
