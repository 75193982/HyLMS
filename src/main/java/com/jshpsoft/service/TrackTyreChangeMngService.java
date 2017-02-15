package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.TrackTyreChangeApply;
import com.jshpsoft.util.Pager;

/**
 * 轮胎更换管理service
* @author  fengql 
* @date 2016年10月27日 上午9:50:13
 */
public interface TrackTyreChangeMngService {
	
	/**
	 * 根据参数获取轮胎更换信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<TrackTyreChangeApply> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取轮胎更换信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<TrackTyreChangeApply> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存轮胎更换数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(TrackTyreChangeApply bean, String oper) throws Exception;
	
	/**
	 * 根据id获取轮胎更换信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TrackTyreChangeApply getById(Integer id) throws Exception;
	
	/**
	 * 更新轮胎更换数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(TrackTyreChangeApply bean, String oper) throws Exception;
	
	/**
	 * 上传轮胎照片
	* @author  fengql 
	* @date 2016年10月27日 上午11:27:35 
	* @parameter  
	* @return
	 */
	public void updateTyrePic(Map<String, Object> params,HttpServletRequest req) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 提交轮胎更换申请
	* @author  fengql 
	* @date 2016年10月11日 下午4:55:08 
	* @parameter  id号，oper-操作者id
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 轮胎更换申请审核通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:01 
	* @parameter  id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditSuccess(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 轮胎更换申请审核不通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:11 
	* @parameter  id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditFail(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 轮胎更换申请审核更新
	 * @author  fengql 
	 * @date 2016年10月11日 下午5:00:11 
	 * @parameter  id号，status-状态，oper-操作者id
	 * @return
	 */
	public void auditForConfirm(Integer id, String status, String oper) throws Exception;
}
