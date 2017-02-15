package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Department;

/**
 * @author  ww 
 * @date 2016年9月27日 上午9:53:06
 */
public interface DepartmentService {
	
	public List<Department> getByConditions(Map<String, Object> params)  throws Exception;
	
	public Department getById(int id) throws Exception ;
	
	public void insert(Department bean)  throws Exception;

	public int update(Department bean) throws Exception;

	public void delete(Map<String, Object> params) throws Exception ;
}
