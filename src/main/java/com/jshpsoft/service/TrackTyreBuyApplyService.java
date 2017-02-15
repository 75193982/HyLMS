package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackTyreBuyApply;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月10日 下午1:06:46
 */
public interface TrackTyreBuyApplyService {
	
	public List<TrackTyreBuyApply> getByConditions(Map<String, Object> params) throws Exception;
	
	public Pager<TrackTyreBuyApply> getPageData(Map<String, Object> params)  throws Exception;

	public void save(TrackTyreBuyApply bean, String operId) throws Exception;

	public TrackTyreBuyApply getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;
	
	public void submit(Integer id, String operId) throws Exception;
	
	public void sure(Integer id, String operId) throws Exception;
	
	public void auditSuccess(Integer detailId, int status, int operId) throws Exception;

	public void auditForConfirm(Integer detailId, int status, int operId) throws Exception;

	public void auditFail(Integer detailId, int status, int operId) throws Exception;

}
