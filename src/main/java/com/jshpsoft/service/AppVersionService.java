package com.jshpsoft.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.AppVersion;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年10月24日 上午9:49:06
 */
public interface AppVersionService {
	
	public Pager<AppVersion> getPageData(Map<String, Object> params)  throws Exception;

	public void save(AppVersion bean, String operId) throws Exception;

	public AppVersion getById(Integer id) throws Exception;
	
	public void submit(Integer id, String operId) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;

	public void updateFilePath(Map<String,Object> params,HttpServletRequest request) throws Exception;
	
	public AppVersion getTopOne(Map<String, Object> params) throws Exception; 

}
