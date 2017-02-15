package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackMaintenanceApply;
import com.jshpsoft.util.Pager;

/**
 * 维修保养管理service
* @author  fengql 
* @date 2016年10月17日 下午5:00:33
 */
public interface TrackMaintMngService {
	
	/**
	 * 根据参数获取维修保养信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<TrackMaintenanceApply> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存维修保养信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(TrackMaintenanceApply bean, String oper) throws Exception;
	
	/**
	 * 根据id获取维修保养信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TrackMaintenanceApply getById(Integer id) throws Exception;
	
	/**
	 * 更新维修保养信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(TrackMaintenanceApply bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 提交维修保养信息
	* @author  fengql 
	* @date 2016年10月11日 下午4:55:08 
	* @parameter  id-id号，oper-操作者id
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 维修保养信息审核通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:01 
	* @parameter  id-id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditSuccess(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 维修保养信息审核不通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:11 
	* @parameter  id-id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditFail(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 维修保养信息审核更新
	 * @author  fengql 
	 * @date 2016年10月11日 下午5:00:11 
	 * @parameter  id-id号，status-状态，oper-操作者id
	 * @return
	 */
	public void auditForConfirm(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 获取维修保养记录
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<TrackMaintenanceApply> getTrackMaintenanceApply(Map<String, Object> params)throws Exception;
}
