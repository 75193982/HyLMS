package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.TransportCostApply;
import com.jshpsoft.util.Pager;

/**
 * 装运费用核算(驾驶员报销)管理service
* @author  fengql 
* @date 2016年10月21日 下午1:21:37
 */
public interface TransportCostMngService {
	
	/**
	 * 根据参数获取装运费用信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<TransportCostApply> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存装运费用申请
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(TransportCostApply bean, String oper,HttpServletRequest request) throws Exception;
	
	/**
	 * 根据id获取装运费用详情
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TransportCostApply getById(Integer id) throws Exception;
	
	/**
	 * 更新装运费用申请
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(TransportCostApply bean, String oper,HttpServletRequest request) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 提交装运费用申请
	* @author  fengql 
	* @date 2016年10月11日 下午4:55:08 
	* @parameter  id号，oper-操作者id
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 获取财务打印装运费用数据
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<TransportCostApply> getFinancePrint(Map<String, Object> params) throws Exception;
		
	/**
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月19日 下午1:14:07 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
	
	/**
	 * 装运费用核算申请审核通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:01 
	* @parameter  id号，status-状态，oper-操作者id, params-审核中填写的信息
	* @return
	 */
	public void auditSuccess(Integer id, String status, String oper, Map<String, Object> params) throws Exception;
	
	/**
	 * 装运费用核算审核不通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:11 
	* @parameter  id号，status-状态，oper-操作者id
	* @return
	 */
	public void auditFail(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 
	 * @Description: 装运费用核算审核更新
	 * @author army.liu 
	 * @param @param id
	 * @param @param status
	 * @param @param oper
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void auditForConfirm(Integer id, String status, String oper, Map<String, Object> params) throws Exception;
	
}
