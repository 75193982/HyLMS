package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.SendCarCommand;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月3日 上午10:59:23
 */
public interface SendCarCommandService {
	public List<SendCarCommand> getByConditions(Map<String, Object> params) throws Exception;
	
	public Pager<SendCarCommand> getPageData(Map<String, Object> params) throws Exception;
	
	public void save(SendCarCommand bean, String oper) throws Exception;
	
	public void delete(Integer id, String oper) throws Exception;
	
	public SendCarCommand getById(Integer id) throws Exception;

	public SendCarCommand getNewOne(String carNumber) throws Exception;
	
	public void submit(Integer id,String oper) throws Exception;
	
	/**
	 * 审核确认
	 * @author  ww 
	 * @date 2016年12月3日 下午2:29:23
	 * @parameter  
	 * @return
	 */
	public void auditForConfirm(int id, int status, int oper) throws Exception;

}
