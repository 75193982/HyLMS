package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OilCardOperateLog;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月23日 下午3:41:05
 */
public interface OilCardOperateLogService {
	
	public void save(OilCardOperateLog bean,String oper) throws Exception;
	
	public void delete(int id, String oper) throws Exception;
	
	public Pager<OilCardOperateLog> getPageData(Map<String, Object> params) throws Exception;
	
	public OilCardOperateLog getById(Integer id) throws Exception;
	
	public void submit(int id, String oper) throws Exception;
	
	public OilCardOperateLog dosure(int id, String oper) throws Exception;
	
	public void sureSave(Map<String, Object> params) throws Exception;
	
	public List<OilCardOperateLog> getByConditions(Map<String, Object> params) throws Exception;

}
