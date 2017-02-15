package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ProcessDetail;

/** 
 * 流程步骤mapper
 * @author  army.liu
 */
public interface ProcessDetailMapper {
	
	public List<ProcessDetail> getByConditions(Map<String, Object> params) throws Exception ;
	
	public ProcessDetail getById(int id) throws Exception ;
	
	public void insert(ProcessDetail bean)  throws Exception;

	public int update(ProcessDetail bean) throws Exception;
	
	public void deleteByProcessId(Integer processId) throws Exception ;

}
