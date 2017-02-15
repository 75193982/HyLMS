package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.AppVersion;

/**
 * @author  ww 
 * @date 2016年10月24日 上午9:43:24
 */
public interface AppVersionMapper {
	
	public List<AppVersion> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void insert(AppVersion bean) throws Exception;
	
	public List<AppVersion> getByConditions(Map<String, Object> params) throws Exception;
	
	public AppVersion getById(int id) throws Exception;
	
	public void updateByConditions(AppVersion bean) throws Exception;

	public AppVersion getTopOne(Map<String, Object> params) throws Exception;
}
