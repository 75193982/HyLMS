package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OtherContacts;

/**
 * @author  ww 
 * @date 2016年10月24日 下午1:08:51
 */
public interface OtherContactsMapper {
	
	public List<OtherContacts> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void insert(OtherContacts bean) throws Exception;
	
	public List<OtherContacts> getByConditions(Map<String, Object> params) throws Exception;
	
	public OtherContacts getById(int id) throws Exception;
	
	public void updateByConditions(OtherContacts bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;

}
