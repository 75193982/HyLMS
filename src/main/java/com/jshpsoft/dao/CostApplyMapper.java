package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CostApply;

/**
 * @author  ww 
 * @date 2016年12月7日 上午10:34:03
 */
public interface CostApplyMapper {
	
	public List<CostApply> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void insert(CostApply bean) throws Exception;
	
	public List<CostApply> getByConditions(Map<String, Object> params) throws Exception;
	
	public CostApply getById(int id) throws Exception;
	
	public void update(CostApply bean) throws Exception;

	public List<CostApply> getReportData(Map<String, Object> params) throws Exception;
}
