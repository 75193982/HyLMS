package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.util.Pager;

/**
 * 装运预付申请管理service
* @author  fengql 
* @date 2016年10月21日 下午1:21:37
 */
public interface TransportPrepayMngService {
	
	/**
	 * 根据参数获取装运预付信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<TransportPrepayApply> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存装运预付申请
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(TransportPrepayApply bean, String oper) throws Exception;
	
	/**
	 * 根据id获取装运预付申请
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TransportPrepayApply getById(Integer id) throws Exception;
	
	/**
	 * 更新装运预付申请
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(TransportPrepayApply bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 提交装运预付申请
	* @author  fengql 
	* @date 2016年10月11日 下午4:55:08 
	* @parameter  id号，oper-操作者id
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 根据参数获取装运预付信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<TransportPrepayApply> getFinancePrint(Map<String, Object> params) throws Exception;
		
	/**
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月19日 下午1:14:07 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
	
	/**
	 * 装运预付申请审核通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:01 
	* @parameter  id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditSuccess(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 装运预付申请审核不通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:11 
	* @parameter  id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditFail(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 装运预付申请状态更新
	 * @author  fengql 
	 * @date 2016年10月11日 下午5:00:11 
	 * @parameter  id号，status-状态，oper-操作者id
	 * @return
	 */
	public void auditForConfirm(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 根据参数获取装运预付信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<TransportPrepayApply> getByConditions(Map<String, Object> params) throws Exception;
}
