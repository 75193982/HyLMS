package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportCostType;
import com.jshpsoft.util.Pager;

/**
 * 驾驶员报销费用类型service
 * @author  army.liu 
 */
public interface TransportCostTypeService {

	public Pager<TransportCostType> getPageData(Map<String, Object> params)  throws Exception;

	public void save(TransportCostType bean, String operId) throws Exception;

	public TransportCostType getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;
	
	public List<TransportCostType> getByConditions(Map<String, Object> params) throws Exception;

}
