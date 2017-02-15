package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.Message;
import com.jshpsoft.util.Pager;

public interface MessageService {

	public Pager<Message> getPageData(Map<String, Object> params)  throws Exception;

	public Message getById(Integer id) throws Exception;
	
	public void updateRead(Integer id, String operId) throws Exception;

	public int getUnReadMsgCount(int userId) throws Exception;
}
