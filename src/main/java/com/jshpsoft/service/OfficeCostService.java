package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CostApply;

/**
 * 办公费用报表
* @author  fengql 
* @date 2017年1月13日 下午1:13:21
 */
public interface OfficeCostService {
	
	/**
	 * 获取办公费用报表
	* @author  fengql 
	* @date 2017年1月13日 下午1:12:52 
	* @parameter  
	* @return
	 */
	public List<CostApply> getReportData(Map<String, Object> params) throws Exception;
	
	/**
	 * 导出办公费用报表
	* @author  fengql 
	* @date 2017年1月13日 下午1:13:07 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportReport(Map<String, Object> params)throws Exception;
	
}
