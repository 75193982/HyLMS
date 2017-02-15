package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Invoice;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月20日 上午11:01:30
 */
public interface InvoiceService {
	
	public void save(Invoice bean,String oper) throws Exception;
	
	public void delete(int id, String oper) throws Exception;
	
	public Pager<Invoice> getPageData(Map<String, Object> params) throws Exception;
	
	public Invoice getById(Integer id) throws Exception;
	
	public List<Invoice> getByConditions(Map<String,Object> params) throws Exception;
	
	public void submit(Integer id, String operId) throws Exception;
	
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;

	public void auditSuccess(Integer detailId, int status, int operId) throws Exception;

	public void auditForConfirm(Integer detailId, int status, int operId) throws Exception;

	public void auditFail(Integer detailId, int status, int operId) throws Exception;
 
}
