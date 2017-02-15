package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.SupplierBusiness;
import com.jshpsoft.util.Pager;

/**
 * 供应商业务service
* @author  fengql 
* @date 2016年11月26日 上午10:00:53
 */
public interface SupplierBusinessService {

	/**
	 * 根据参数获取供应商业务信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<SupplierBusiness> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 分页
	 * @author  ww 
	 * @date 2016年11月26日 下午3:05:04
	 * @parameter  
	 * @return
	 */
	public Pager<SupplierBusiness> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存、修改品牌设置
	 * @author  ww 
	 * @date 2016年11月26日 下午3:01:56
	 * @parameter  
	 * @return
	 */
	public void save(SupplierBusiness bean, String oper) throws Exception;
	
	/**
	 * 删除
	 * @author  ww 
	 * @date 2016年11月26日 下午3:03:13
	 * @parameter  
	 * @return
	 */
	public void delete(Integer id, String oper) throws Exception;
	
	/**
	 * 根据id获取
	 * @author  ww 
	 * @date 2016年11月26日 下午3:03:59
	 * @parameter  
	 * @return
	 */
	public SupplierBusiness getById(Integer id) throws Exception;
	
	
}
