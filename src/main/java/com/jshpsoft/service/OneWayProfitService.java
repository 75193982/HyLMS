package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OneWayProfit;

/**
 * @author  ww 
 * @date 2017年1月9日 下午1:03:55
 */
public interface OneWayProfitService {
	
	public List<OneWayProfit> getListData(Map<String, Object> params) throws Exception;
	
	public Map<String, Object> getExportData(Map<String, Object> params) throws Exception;

}
