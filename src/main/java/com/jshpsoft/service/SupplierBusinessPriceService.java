package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.SupplierBusinessPrice;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年11月24日 下午4:35:06
 */
public interface SupplierBusinessPriceService {
	
	public void save(SupplierBusinessPrice bean,String oper) throws Exception;
	
	public void delete(int id, String oper) throws Exception;
	
	public Pager<SupplierBusinessPrice> getPageData(Map<String, Object> params) throws Exception;
	
	public SupplierBusinessPrice getById(Integer id) throws Exception;

}
