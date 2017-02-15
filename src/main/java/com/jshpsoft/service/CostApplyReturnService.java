package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.CostApplyReturn;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月8日 下午1:06:03
 */
public interface CostApplyReturnService {
	
	public Pager<CostApplyReturn> getPageData(Map<String, Object> params)  throws Exception;

	public void save(CostApplyReturn bean, String operId) throws Exception;

	public CostApplyReturn getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;
	
	public void submit(Integer id, String operId) throws Exception;

	public void auditSuccess(Integer detailId, int status, int operId) throws Exception;

	public void auditForConfirm(Integer detailId, int status, int operId) throws Exception;

	public void auditFail(Integer detailId, int status, int operId) throws Exception;
}
