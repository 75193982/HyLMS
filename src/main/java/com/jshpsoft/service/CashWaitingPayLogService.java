package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.CashWaitingPayLog;
import com.jshpsoft.util.Pager;

/**
 * 代付现金service
 * @author  army.liu
 * @date 2016年12月12日 下午4:26:29
 */
public interface CashWaitingPayLogService {
	
	/**
	 * 根据参数获取收支信息-分页
	 * @author army.liu
	 * @date 2016年12月12日 下午4:26:29
	 * @parameter  
	 * @return
	 */
	public Pager<CashWaitingPayLog> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存收支信息
	 * @author army.liu
	 * @date 2016年12月12日 下午4:26:29 
	 * @parameter  
	 * @return
	 */
	public void save(CashWaitingPayLog bean, String oper) throws Exception;
	
	/**
	 * 根据id获取收支信息-用于编辑
	 * @author army.liu
	 * @date 2016年12月12日 下午4:26:29
	 * @parameter  
	 * @return
	 */
	public CashWaitingPayLog getById(Integer id) throws Exception;
	
	/**
	 * 支付收支信息
	 * @author army.liu
	 * @date 2016年12月12日 下午4:26:29
	 * @parameter  
	 * @return
	 */
	public void pay(int id, String oper) throws Exception;
	
}
