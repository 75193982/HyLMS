package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.TransportPriceSetting;
import com.jshpsoft.util.Pager;

/**
 * 驳板价格service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface TransportPriceMngService {

	/**
	 * 根据参数获取驳板价格信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<TransportPriceSetting> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取驳板价格信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<TransportPriceSetting> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存驳板价格数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(TransportPriceSetting bean, String oper) throws Exception;
	
	/**
	 * 根据id获取驳板价格
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TransportPriceSetting getById(Integer id) throws Exception;
	
	/**
	 * 更新驳板价格数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(TransportPriceSetting bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
}
