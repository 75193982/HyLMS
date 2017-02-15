package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.domain.ScheduleBill;

/**
 * 调度单dao
* @author  fengql 
* @date 2016年9月29日 下午1:26:22
 */
public interface ScheduleBillMapper {

	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<ScheduleBill> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<ScheduleBill> getByConditions(Map<String, Object> params)  throws Exception;
	
	public void insert(ScheduleBill bean)  throws Exception;

	public int update(ScheduleBill bean) throws Exception;
	
	public int updateByBillNo(Map<String, Object> params) throws Exception;
	
	public ScheduleBill getByBillNo(String scheduleBillNo) throws Exception;

	/**
	 * 
	 * @Description: 获取调度单信息
	 * @author army.liu 
	 * @param @param id
	 * @param @return    设定文件
	 * @return ScheduleBill    返回类型
	 * @throws
	 * @see
	 */
	public ScheduleBill getById(Integer id) throws Exception;
	
	public List<ScheduleBill> getSchBillNo(Map<String, Object> params)  throws Exception;
	
	public List<ScheduleBill> getOwnPageList(Map<String, Object> params) throws Exception;

	public int getOwnPageTotalCount(Map<String, Object> params) throws Exception;

	public List<ScheduleBill> getEnabledScheduleBillInfo(Map<String, Object> params) throws Exception;

	
	public List<BalanceCar> getCostPageList(Map<String, Object> params) throws Exception;

	public int getCostPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<BalanceCar> getCostByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 调度查询-汇总查询
	 * @author  ww 
	 * @date 2016年12月30日 上午9:48:25
	 * @parameter  params[stockId-仓库、insertUser-调度员id]
	 * @return
	 */
	public List<ScheduleBill>getGroupByUser(Map<String, Object> params) throws Exception;
	
	public int getGroupByUserCount(Map<String, Object> params) throws Exception;
}
