package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ContactFunds;

/**
 * 往来款
* @author  fengql 
* @date 2017年1月10日 下午2:17:22
 */
public interface ContactFundsMapper {
	
	public List<ContactFunds> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<ContactFunds> getByConditions(Map<String, Object> params) throws Exception;
	
	public ContactFunds getById(Integer id) throws Exception ;

	public void insert(ContactFunds bean)  throws Exception;

	public int update(ContactFunds bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	public List<ContactFunds> getReportData(Map<String, Object> params) throws Exception;

}
