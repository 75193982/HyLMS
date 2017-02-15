package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Message;

/** 
 * 消息mapper
 * @author  army.liu
 */
public interface MessageMapper {
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<Message> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<Message> getByConditions(Map<String, Object> params) throws Exception ;
	
	public Message getById(int id) throws Exception ;
	
	public void insert(Message bean)  throws Exception;

	public int update(Message bean) throws Exception;
	
	/**
	 * @Description: 获取用户未读消息数
	 * @author army.liu 
	 * @param @param userId
	 * @param @return    设定文件
	 * @return int    返回类型
	 * @throws
	 * @see
	 */
	public int getUnReadMsgCount(int userId) throws Exception;
}
