package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OilCardOperateLog;

/**
 * 油价日志dao
* @author  fengql 
* @date 2016年10月18日 下午4:31:52
 */
public interface OilCardOperateLogMapper {

	public void insert(OilCardOperateLog bean)  throws Exception;

	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<OilCardOperateLog> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public void update(OilCardOperateLog bean)  throws Exception;
	
	public OilCardOperateLog getById(int id) throws Exception;
	
	public List<OilCardOperateLog>getByConditions(Map<String,Object> params) throws Exception;
	
	public void updateById(Map<String,Object> params) throws Exception;
}
