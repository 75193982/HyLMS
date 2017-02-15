package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.CarDamageCostApply;
import com.jshpsoft.util.Pager;

/**
 * 折损费用申请管理service
 * @author army.liu 
 */
public interface CarDamageCostMngService {
	
	/**
	 * 根据参数获取分页
	 * @author  army.liu  
	 * @parameter  
	 * @return
	 */
	public Pager<CarDamageCostApply> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 新增折损费用申请
	 * @author  army.liu  
	 * @parameter  
	 * @return
	 */
	public void save(CarDamageCostApply bean, String oper, HttpServletRequest req) throws Exception;
	
	/**
	 * 根据id获取折损费用申请
	 * @author  army.liu  
	 * @parameter  
	 * @return
	 */
	public CarDamageCostApply getById(Integer id) throws Exception;
	
	/**
	 * 更新折损费用申请
	 * @author  army.liu  
	 * @parameter  
	 * @return
	 */
	public void update(CarDamageCostApply bean, String oper, HttpServletRequest req) throws Exception;
	
	/**
	 * 删除折损费用申请
	 * @author  army.liu  
	 * @parameter  id号，oper-操作者id
	 * @return
	 */
	public void delete(Integer id, String oper) throws Exception;
	
	/**
	 * 提交折损费用申请
	 * @author  army.liu  
	 * @parameter  id号，oper-操作者id
	 * @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 折损费用申请审核通过
	 * @author  army.liu  
	 * @date 2016年10月11日 下午5:00:01 
	 * @parameter  id号，status-状态，oper-操作者id
	 * @return
	 */
	public void auditSuccess(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 折损费用申请审核不通过
	 * @author  army.liu  
	 * @date 2016年10月11日 下午5:00:11 
	 * @parameter  id号，status-状态，oper-操作者id
	 * @return
	 */
	public void auditFail(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 折损费用申请状态更新
	 * @author  army.liu  
	 * @date 2016年10月11日 下午5:00:11 
	 * @parameter  id号，status-状态，oper-操作者id
	 * @return
	 */
	public void auditForConfirm(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 根据参数获取信息
	 * @author  army.liu  
	 * @parameter  
	 * @return
	 */
	public List<CarDamageCostApply> getByConditions(Map<String, Object> params) throws Exception;
}
