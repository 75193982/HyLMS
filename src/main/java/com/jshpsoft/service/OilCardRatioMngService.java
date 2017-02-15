package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OilCardRatioSetting;
import com.jshpsoft.util.Pager;

/**
 * 油卡结算比率service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface OilCardRatioMngService {

	/**
	 * 根据参数获取油卡结算比率信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<OilCardRatioSetting> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取油卡结算比率信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<OilCardRatioSetting> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存油卡结算比率数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(OilCardRatioSetting bean, String oper) throws Exception;
	
	/**
	 * 根据id获取油卡结算比率
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public OilCardRatioSetting getById(Integer id) throws Exception;
	
	/**
	 * 更新油卡结算比率数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(OilCardRatioSetting bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
}
