package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.SalaryPay;
import com.jshpsoft.domain.SalaryPayDetail;
import com.jshpsoft.util.Pager;

public interface SalaryPayService {

	public Pager<SalaryPay> getPageData(Map<String, Object> params)  throws Exception;

	public void save(SalaryPay bean, String operId) throws Exception;

	public SalaryPay getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;

	public List<SalaryPay> getByConditions(Map<String, Object> params) throws Exception;

	public List<SalaryPay> getAllListData(Map<String, Object> params) throws Exception;
	
	public SalaryPay getByDetailInfo(Integer id) throws Exception;

	public void pay(Integer id, String string) throws Exception;

	public List<SalaryPayDetail> getTemplateData(String driverFlag, String salaryTime) throws Exception;

	public List<SalaryPayDetail> getDetailInfoForConditions(
			Map<String, Object> params) throws Exception;

	public Map<String, Object> getAllListDataForExportData(
			Map<String, Object> params) throws Exception;

	public Map<String, Object> getByDetailInfoForExportData(Integer id) throws Exception;

	
}
