package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.Contract;
import com.jshpsoft.util.Pager;

/**
 * 合同service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface ContractService {

	/**
	 * 根据参数获取合同信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<Contract> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取合同信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<Contract> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存合同数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(Contract bean, String oper) throws Exception;
	
	/**
	 * 根据id获取合同
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public Contract getById(Integer id) throws Exception;
	
	/**
	 * 更新合同数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(Contract bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 更新附件地址
	* @author  fengql 
	* @date 2016年10月19日 下午3:46:17 
	* @parameter  
	* @return
	 */
	public void updateFilePath(Map<String, Object> params,HttpServletRequest req) throws Exception;

	/**
	 * 
	 * @Description: 提交合同
	 * @author army.liu 
	 * @param @param id
	 * @param @param oper    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void submit(Integer id, String oper) throws Exception;
}
