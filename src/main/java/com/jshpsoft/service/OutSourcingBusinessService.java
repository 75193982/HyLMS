package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.OutSourcingBusiness;
import com.jshpsoft.util.Pager;

/** 承运商业务
 * @author  ww 
 * @date 2016年12月3日 上午8:45:44
 */
public interface OutSourcingBusinessService {
	
	/**
	 * 根据参数获取承运商业务信息
	* @author  ww
	* @date 2016年12月3日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<OutSourcingBusiness> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 分页
	 * @author  ww 
	 * @date 2016年11月26日 下午3:05:04
	 * @parameter  
	 * @return
	 */
	public Pager<OutSourcingBusiness> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存、修改品牌设置
	 * @author  ww 
	 * @date 2016年11月26日 下午3:01:56
	 * @parameter  
	 * @return
	 */
	public void save(OutSourcingBusiness bean, String oper) throws Exception;
	
	/**
	 * 删除
	 * @author  ww 
	 * @date 2016年11月26日 下午3:03:13
	 * @parameter  
	 * @return
	 */
	public void delete(Integer id, String oper) throws Exception;
	
	/**
	 * 根据id获取
	 * @author  ww 
	 * @date 2016年11月26日 下午3:03:59
	 * @parameter  
	 * @return
	 */
	public OutSourcingBusiness getById(Integer id) throws Exception;
	
	/**
	 * 设置保存
	 * @author  ww 
	 * @date 2016年12月3日 下午1:14:38
	 * @parameter  
	 * @return
	 */
	public void siteSave(HttpServletRequest request,OutSourcingBusiness bean,String oper) throws Exception;
	
	/**
	 * 获取品牌
	 * @author  ww 
	 * @date 2017年1月5日 上午9:55:08
	 * @parameter  
	 * @return
	 */
	public List<OutSourcingBusiness> getSupBrandName(Map<String, Object> params) throws Exception;
	
	public List<OutSourcingBusiness> getBrandNameByOs(Map<String, Object> params) throws Exception;
	

}
