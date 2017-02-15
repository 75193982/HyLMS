package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Invoice;


/**
 * @author  ww 
 * @date 2016年12月20日 上午10:49:10
 */
public interface InvoiceMapper {

	public List<Invoice> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void insert(Invoice bean) throws Exception;
	
	public List<Invoice> getByConditions(Map<String, Object> params) throws Exception;
	
	public Invoice getById(int id) throws Exception;
	
	public void update(Invoice bean) throws Exception;
	
}
