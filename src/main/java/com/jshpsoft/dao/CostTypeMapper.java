package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CostType;


/**
 * @author  ww 
 * @date 2016年12月7日 上午8:51:08
 */
public interface CostTypeMapper {
	
	public List<CostType> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void insert(CostType bean) throws Exception;
	
	public List<CostType> getByConditions(Map<String, Object> params) throws Exception;
	
	public CostType getById(int id) throws Exception;
	
	public void update(CostType bean) throws Exception;

}
