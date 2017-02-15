package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackTyreInOut;
import com.jshpsoft.util.Pager;

/**
 * 轮胎出入库单管理service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface TrackTyreInOutMngService {
	
	/**
	 * 根据参数获取轮胎出入库单信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<TrackTyreInOut> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取轮胎出入库单信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<TrackTyreInOut> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存轮胎出入库单信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(TrackTyreInOut bean, String oper) throws Exception;
	
	/**
	 * 根据id获取出入库单-用于编辑
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TrackTyreInOut getById(Integer id) throws Exception;
	
	/**
	 * 根据id获取出入库单及明细信息-用于查看
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TrackTyreInOut getDetailById(Integer id) throws Exception;
	
	/**
	 * 更新轮胎出入库单信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(TrackTyreInOut bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 提交轮胎出入库单
	* @author  fengql 
	* @date 2016年10月11日 下午4:55:08 
	* @parameter  id号，oper-操作者id
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 轮胎出入库单审核通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:01 
	* @parameter  id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditSuccess(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 轮胎出入库单审核不通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:11 
	* @parameter  id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditFail(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 轮胎出入库单审核更新
	 * @author  fengql 
	 * @date 2016年10月11日 下午5:00:11 
	 * @parameter  id号，status-状态，oper-操作者id
	 * @return
	 */
	public void auditForConfirm(Integer id, String status, String oper) throws Exception;
}
