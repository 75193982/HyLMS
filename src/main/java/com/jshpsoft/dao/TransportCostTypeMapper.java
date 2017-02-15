package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportCostType;


/**
 * @author  army.liu 
 */
public interface TransportCostTypeMapper {
	
	public List<TransportCostType> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void insert(TransportCostType bean) throws Exception;
	
	public List<TransportCostType> getByConditions(Map<String, Object> params) throws Exception;
	
	public TransportCostType getById(int id) throws Exception;
	
	public void update(TransportCostType bean) throws Exception;

}
