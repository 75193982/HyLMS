package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OutSourcingBusiness;

/**
 * @author  ww 
 * @date 2016年11月26日 下午5:58:15
 */
public interface OutSourcingBusinessMapper {

	public OutSourcingBusiness getById(Integer id) throws Exception ;

	public List<OutSourcingBusiness> getByConditions(Map<String, Object> params)  throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<OutSourcingBusiness> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;

	public void insert(OutSourcingBusiness bean)  throws Exception;

	public int update(OutSourcingBusiness bean) throws Exception;
	
	public List<OutSourcingBusiness> getBrandNameByOs(Map<String, Object> params) throws Exception;
}
