package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.util.Pager;

/**
 * 外协单位service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface OutSourcingService {

	/**
	 * 根据参数获取外协单位信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<OutSourcing> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取外协单位信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<OutSourcing> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存外协单位数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(OutSourcing bean, String oper) throws Exception;
	
	/**
	 * 根据id获取外协单位
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public OutSourcing getById(Integer id) throws Exception;
	
	/**
	 * 更新外协单位数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(OutSourcing bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
}
