package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ProcessDetail;
import com.jshpsoft.domain.ProcessInfo;
import com.jshpsoft.util.Pager;

public interface ProcessService {

	public Pager<ProcessInfo> getPageData(Map<String, Object> params)  throws Exception;

	public void save(ProcessInfo bean, String operId) throws Exception;

	public ProcessInfo getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;

	public List<ProcessDetail> getProcessDetailList(Integer processId) throws Exception;

	public void saveProcessDetailList(ProcessInfo bean, String operId) throws Exception;

	/**
	 * 
	 * @Description: 修改业务流程状态：enabled-Y，表示启用。N-表示停用
	 * @author army.liu 
	 * @param @param id
	 * @param @param enabled
	 * @param @param operId    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void modifyStatus(Integer id, String enabled, String operId)throws Exception;

	/**
	 * 
	 * @Description: 获取办公申请的相关流程
	 * @author army.liu 
	 * @param @param stockId
	 * @param @return    设定文件
	 * @return List<ProcessInfo>    返回类型
	 * @throws
	 * @see
	 */
	public List<ProcessInfo> getProcessListForOffice(Integer stockId)throws Exception;
	
}
