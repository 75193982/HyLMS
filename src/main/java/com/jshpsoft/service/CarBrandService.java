package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.util.Pager;

/**
 * 汽车品牌service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface CarBrandService {

	/**
	 * 根据参数获取汽车品牌信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<CarBrand> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取汽车品牌信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<CarBrand> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存汽车品牌数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(CarBrand bean, String oper) throws Exception;
	
	/**
	 * 根据id获取汽车品牌
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public CarBrand getById(Integer id) throws Exception;
	
	/**
	 * 更新汽车品牌数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(CarBrand bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 根据品牌id获取车型
	* @author  fengql 
	* @date 2016年10月31日 上午11:05:36 
	* @parameter  
	* @return
	 */
	public List<CarBrand> getCarTypeList(Integer id) throws Exception;
	
	/**
	 * 设置保存
	 * @author  ww 
	 * @date 2016年11月24日 下午1:26:35
	 * @parameter  
	 * @return
	 */
	public void siteSave(HttpServletRequest request,Map<String, Object> params,String oper) throws Exception;
}
