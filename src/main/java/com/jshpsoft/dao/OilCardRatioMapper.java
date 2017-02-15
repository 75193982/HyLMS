package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OilCardRatioSetting;

/**
 * 油卡结算比率管理dao
* @author  fengql 
* @date 2016年9月26日 上午10:47:11
 */
public interface OilCardRatioMapper {

	public OilCardRatioSetting getById(Integer id) throws Exception ;

	public List<OilCardRatioSetting> getByConditions(Map<String, Object> params)  throws Exception;

	public void insert(OilCardRatioSetting bean)  throws Exception;

	public int update(OilCardRatioSetting bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<OilCardRatioSetting> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
