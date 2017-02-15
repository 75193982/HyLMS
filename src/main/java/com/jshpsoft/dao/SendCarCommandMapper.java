package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.SendCarCommand;


/**
 * @author  ww 
 * @date 2016年12月3日 上午10:58:43
 */
public interface SendCarCommandMapper {
	
	public SendCarCommand getById(Integer id) throws Exception ;

	public List<SendCarCommand> getByConditions(Map<String, Object> params)  throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<SendCarCommand> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;

	public void insert(SendCarCommand bean)  throws Exception;

	public int update(SendCarCommand bean) throws Exception;
	
	public SendCarCommand getTopOne(Map<String, Object> params) throws Exception;

}
