package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.FleetProfitYM;

/**
 * @author  ww 
 * @date 2017年1月11日 上午10:53:20
 */
public interface FleetProfitService {
	
	public List<FleetProfitYM> getListData(Map<String,Object> params) throws Exception;
	
	public Map<String, Object> getExportData(Map<String, Object> params) throws Exception;

}
