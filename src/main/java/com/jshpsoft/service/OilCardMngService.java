package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.OilCardOperateLog;
import com.jshpsoft.domain.OilCardStock;
import com.jshpsoft.util.Pager;

/**
 * 油卡管理service
* @author  fengql 
* @date 2016年10月18日 下午3:08:40
 */
public interface OilCardMngService {
	
	/**
	 * 根据条件获取油卡信息-用于打印
	* @author  fengql 
	* @date 2016年10月18日 下午3:09:42 
	* @parameter  
	* @return
	 */
	public List<OilCardStock> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据条件获取油卡信息-分页
	* @author  fengql 
	* @date 2016年10月18日 下午3:11:11 
	* @parameter  
	* @return
	 */
	public Pager<OilCardStock> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 新增油卡信息
	* @author  fengql 
	* @date 2016年10月18日 下午3:11:55 
	* @parameter  
	* @return
	 */
	public void save(OilCardStock bean, String oper) throws Exception;
	
	/**
	 * 根据id获取油卡信息
	* @author  fengql 
	* @date 2016年10月18日 下午3:12:20 
	* @parameter  
	* @return
	 */
	public OilCardStock getById(Integer id) throws Exception;
	
	/**
	 * 更新油卡信息
	* @author  fengql 
	* @date 2016年10月18日 下午3:13:25 
	* @parameter  
	* @return
	 */
	public void update(OilCardStock bean, String oper) throws Exception;
	
	/**
	 * 根据id更新-删除标记
	* @author  fengql 
	* @date 2016年10月18日 下午3:12:59 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;

	/**
	 * 提交油卡信息
	* @author  fengql 
	* @date 2016年10月18日 下午3:14:58 
	* @parameter  
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 发放油卡
	* @author  fengql 
	* @date 2016年10月18日 下午3:15:46 
	* @parameter  params [id号、receiveUser-领取人(id)]
	* @return
	 */
	public void grant(Map<String, Object> params, String oper) throws Exception;
	
	/**
	 * 回收油卡
	* @author  fengql 
	* @date 2016年10月18日 下午3:18:40 
	* @parameter  params [id号、money-金额]
	* @return
	 */
	public void recover(Map<String, Object> params, String oper) throws Exception;
	
	/**
	 * 油卡充值
	* @author  fengql 
	* @date 2016年10月18日 下午3:19:59 
	* @parameter  params [id号、money-充值金额]
	* @return
	 */
	public void recharge(Map<String, Object> params, String oper) throws Exception;
	
	/**
	 * 获取油卡操作日志
	* @author  fengql 
	* @date 2016年10月18日 下午3:21:18 
	* @parameter  
	* @return
	 */
	public Pager<OilCardOperateLog> queryOilCardLog(Map<String, Object> params) throws Exception;
	
	/**
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月19日 下午1:14:07 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
	
	/**
	 * 导入
	 * @author  ww 
	 * @date 2016年12月28日 上午11:14:23
	 * @parameter  
	 * @return
	 */
	public void input(HttpServletRequest request,Map<String, Object> params,String oper) throws Exception;
}
