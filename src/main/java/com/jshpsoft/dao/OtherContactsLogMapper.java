package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OtherContactsLog;

/**
 * @author  ww 
 * @date 2016年10月25日 下午2:13:37
 */
public interface OtherContactsLogMapper {
	
	public void insert(OtherContactsLog bean) throws Exception;
	
	public void updateByConId(Map<String, Object> params) throws Exception;
	
	public List<OtherContactsLog> getLogList(int otherContactId) throws Exception;

}
