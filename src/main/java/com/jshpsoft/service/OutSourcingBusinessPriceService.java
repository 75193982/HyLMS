package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OutSourcingBusinessPrice;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月3日 上午8:48:01
 */
public interface OutSourcingBusinessPriceService {

	public void save(OutSourcingBusinessPrice bean,String oper) throws Exception;
	
	public void delete(int id, String oper) throws Exception;
	
	public Pager<OutSourcingBusinessPrice> getPageData(Map<String, Object> params) throws Exception;
	
	public OutSourcingBusinessPrice getById(Integer id) throws Exception;
	
	public List<OutSourcingBusinessPrice> getLib(Map<String, Object> params) throws Exception;
	
}
