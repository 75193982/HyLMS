package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.OfficeReminder;
import com.jshpsoft.util.Pager;

/**
 * 备忘信息service
* @author  fengql 
* @date 2016年10月19日 下午4:17:58
 */
public interface OfficeReminderService {
	
	/**
	 * 根据参数获取备忘信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<OfficeReminder> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存备忘信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(OfficeReminder bean, String oper) throws Exception;
	
	/**
	 * 根据id获取备忘信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public OfficeReminder getById(Integer id) throws Exception;
	
	/**
	 * 更新备忘信息
	* @author  fengql 
	* @date 2016年10月19日 下午4:21:39 
	* @parameter  
	* @return
	 */
	public void update(OfficeReminder bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
}
