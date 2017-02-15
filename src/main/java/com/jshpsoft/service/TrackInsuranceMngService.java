package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.domain.TrackInsurancePayLog;
import com.jshpsoft.util.Pager;

/**
 * 保费管理service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface TrackInsuranceMngService {
	
	/**
	 * 根据参数获取保费信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<TrackInsurance> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取保费信息
	* @author  fengql 
	* @date 2016年10月20日 下午1:49:28 
	* @parameter  
	* @return
	 */
	public TrackInsurance getInsuranceBean(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存保费信息
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(TrackInsurance bean, String oper) throws Exception;
	
	/**
	 * 根据id获取保费
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public TrackInsurance getById(Integer id) throws Exception;
	
	/**
	 * 更新保费
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(TrackInsurance bean, String oper) throws Exception;
	
	/**
	 * 更新扫描件上传地址
	* @author  fengql 
	* @date 2016年10月20日 下午3:21:52 
	* @parameter  
	* @return
	 */
	public void updateFilePath(TrackInsurance bean,HttpServletRequest req) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 提交保费
	* @author  fengql 
	* @date 2016年10月20日 下午3:31:42 
	* @parameter  
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 保存支付/索赔保险费用
	* @author  fengql 
	* @date 2016年10月20日 下午4:38:44 
	* @parameter  
	* @return
	 */
	public void savePayLog(TrackInsurancePayLog bean, String oper) throws Exception;
	
	/**
	 * 根据参数获取保险费用
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<TrackInsurance> getPrintData(Map<String, Object> params) throws Exception;
		
	/**
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月19日 下午1:14:07 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
	
	/**
	 * 获取保费支付数据
	* @author  fengql 
	* @date 2016年10月20日 下午4:48:41 
	* @parameter  
	* @return
	 */
	public Pager<TrackInsurancePayLog> getPayPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 查看支付对应的明细
	* @author  fengql 
	* @date 2016年10月20日 下午4:51:49 
	* @parameter  
	* @return
	 */
	public List<TrackInsurancePayLog> getPayDetailList(Integer id) throws Exception;
	
	/**
	 * 支付
	 * @author  ww 
	 * @date 2016年12月9日 上午9:40:51
	 * @parameter  
	 * @return
	 */
	public void zhiFu(Integer id, String oper) throws Exception;
}
