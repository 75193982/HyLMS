package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.BalancePriceSetting;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.util.Pager;

/**
 * 供应商service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface SupplierService {

	/**
	 * 根据参数获取供应商信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<Supplier> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取供应商信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<Supplier> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存供应商数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(Supplier bean, String oper) throws Exception;
	
	/**
	 * 根据id获取供应商
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public Supplier getById(Integer id) throws Exception;
	
	/**
	 * 更新供应商数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(Supplier bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 根据供应商id获取库
	* @author  fengql 
	* @date 2016年10月8日 下午1:38:17 
	* @parameter  
	* @return
	 */
	public List<Supplier> getSupplierStockList(Integer supplierId) throws Exception;

	/**
	 * @Description: 获取供应商的结算价格设置信息
	 * @author army.liu 
	 * @param @param id
	 * @param @return    设定文件
	 * @return List<BalancePriceSetting>    返回类型
	 * @throws
	 * @see
	 */
	public List<BalancePriceSetting> getBalanceSettingInfo(Integer supplierId) throws Exception;
	
	/**
	 * @Description: 保存供应商的结算价格设置信息
	 * @author army.liu 
	 * @param @param bean
	 * @param @param oper    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void saveBalanceSetting(Supplier bean, String oper) throws Exception;

}
