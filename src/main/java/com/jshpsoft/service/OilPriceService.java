package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OilPrice;
import com.jshpsoft.util.Pager;

/**
 * 油价service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface OilPriceService {

	/**
	 * 根据参数获取油价信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<OilPrice> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取油价信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<OilPrice> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存油价数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(OilPrice bean, String oper) throws Exception;
	
	/**
	 * 根据id获取油价
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public OilPrice getById(Integer id) throws Exception;
	
	/**
	 * 更新油价数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(OilPrice bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 获取油价信息-去除重复的
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<OilPrice> getOilPriceList() throws Exception;
}
