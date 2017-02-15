package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarShop;
import com.jshpsoft.util.Pager;

/**
 * 4S店service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface CarShopService {

	/**
	 * 根据参数获取4S店信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<CarShop> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取4S店信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<CarShop> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存4S店数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(CarShop bean, String oper) throws Exception;
	
	/**
	 * 根据id获取4S店
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public CarShop getById(Integer id) throws Exception;
	
	/**
	 * 更新4S店数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(CarShop bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
}
