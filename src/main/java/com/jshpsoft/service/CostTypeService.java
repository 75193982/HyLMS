package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CostType;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月7日 上午9:05:34
 */
public interface CostTypeService {

	public Pager<CostType> getPageData(Map<String, Object> params)  throws Exception;

	public void save(CostType bean, String operId) throws Exception;

	public CostType getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;
	
	public List<CostType> getByConditions(Map<String, Object> params) throws Exception;
	
}
