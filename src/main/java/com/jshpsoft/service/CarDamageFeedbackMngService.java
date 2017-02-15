package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.CarDamageFeedback;
import com.jshpsoft.util.Pager;

/**
 * 折损反馈管理service
 * @author  army.liu 
 */
public interface CarDamageFeedbackMngService {
	
	/**
	 * 根据参数获取收支信息-分页
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	public Pager<CarDamageFeedback> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存收支信息
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	public void save(CarDamageFeedback bean, String oper) throws Exception;
	
	/**
	 * 根据id获取信息-用于编辑
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	public CarDamageFeedback getById(Integer id) throws Exception;
	
	/**
	 * 更新收支信息
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	public void update(CarDamageFeedback bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	 * @author  army.liu 
	 * @parameter  
	 * @return
	 */
	public void updateById(Integer id, String oper) throws Exception;

	/**
	 *  提交
	 * @author army.liu 
	 * @throws
	 * @see
	 */
	public void submit(Integer detailId, String oper) throws Exception;
	
	/**
	 * 确认操作（只改状态）
	 * @author army.liu 
	 * @throws
	 * @see
	 */
	public void auditForConfirm(int detailId, int status, int oper) throws Exception;
}
