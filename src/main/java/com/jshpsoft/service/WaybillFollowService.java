package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.Waybill;
import com.jshpsoft.domain.WaybillLog;
import com.jshpsoft.util.Pager;

/**
 * 运单跟踪service
* @author  fengql 
* @date 2016年11月26日 下午1:51:31
 */
public interface WaybillFollowService {

	/**
	 * 获取待跟踪的运单信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<Waybill> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据运单id获取运单跟踪信息
	* @author  fengql 
	* @date 2016年11月26日 下午1:58:03 
	* @parameter  
	* @return
	 */
	public WaybillLog getByWaybillId(Integer waybillId) throws Exception;	
	
	/**
	 * 更新运单跟踪信息
	* @author  fengql 
	* @date 2016年11月26日 下午1:55:59 
	* @parameter  
	* @return
	 */
	public void update(WaybillLog bean, String oper) throws Exception;
	
	/**
	 * 完成确认运单跟踪信息
	* @author  fengql 
	* @date 2016年11月26日 下午2:01:21 
	* @parameter  
	* @return
	 */
	public void sure(Integer waybillId) throws Exception;
}
