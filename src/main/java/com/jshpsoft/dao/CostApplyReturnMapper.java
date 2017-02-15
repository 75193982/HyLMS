package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CostApplyReturn;


/**
 * @author  ww 
 * @date 2016年12月8日 上午11:19:54
 */
public interface CostApplyReturnMapper {
	
public List<CostApplyReturn> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void insert(CostApplyReturn bean) throws Exception;
	
	public List<CostApplyReturn> getByConditions(Map<String, Object> params) throws Exception;
	
	public CostApplyReturn getById(int id) throws Exception;
	
	public void update(CostApplyReturn bean) throws Exception;

}
