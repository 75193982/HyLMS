package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CostApply;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月7日 上午10:56:18
 */
public interface CostApplyService {
	
	public List<CostApply> getByConditions(Map<String, Object> params) throws Exception;
	
	public Pager<CostApply> getPageData(Map<String, Object> params)  throws Exception;

	public void save(CostApply bean, String operId) throws Exception;

	public CostApply getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;
	
	public void submit(Integer id, String operId) throws Exception;

	public void auditSuccess(Integer detailId, int status, int operId) throws Exception;

	public void auditForConfirm(Integer detailId, int status, int operId) throws Exception;

	public void auditFail(Integer detailId, int status, int operId) throws Exception;
	

}
