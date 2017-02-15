package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TrackTyreStock;
import com.jshpsoft.util.Pager;

/**
 * 轮胎库存管理service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface TrackTyreMngService {
	
	/**
	 * 根据参数获取轮胎信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<TrackTyreStock> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取轮胎信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<TrackTyreStock> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存轮胎数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(TrackTyreStock bean, String oper) throws Exception;
	
	/**
	 * 根据id获取轮胎
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TrackTyreStock getById(Integer id) throws Exception;
	
	/**
	 * 更新轮胎数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(TrackTyreStock bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
}
