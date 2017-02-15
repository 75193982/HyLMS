package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.TrackRepairApply;
import com.jshpsoft.util.Pager;

/**
 * 折损维修登记service
* @author  lvhao 
* @date 2016年12月21日 上午8:35:59
 */
public interface TrackRepairApplyService {
	/**
	 * 获取列表
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Pager<TrackRepairApply> getPageData(Map<String, Object> params)  throws Exception;
	/**
	 * 保存
	 * @param apply
	 * @return
	 * @throws Exception
	 */
	public int save(TrackRepairApply apply)  throws Exception;
	
	/**
	 * 折损库存
	 * @return
	 * @throws Exception
	 */
	public List<CarDamageStock> getDamageStocks()throws Exception;
	
	/**
	 * 获取详细
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public TrackRepairApply getDetail(int id)throws Exception;
	
	
	/**
	 * 修改
	 * @param apply
	 * @return
	 * @throws Exception
	 */
	public int update(TrackRepairApply apply)  throws Exception;
	
	
	/**
	 * 删除
	 * @param apply
	 * @return
	 * @throws Exception
	 */
	public int delete(TrackRepairApply apply)  throws Exception;
	
	/**
	 * 提交
	 * @param apply
	 * @return
	 * @throws Exception
	 */
	public int submit(TrackRepairApply apply)  throws Exception;
	
	/**
	 * 确认
	 * @param apply
	 * @return
	 * @throws Exception
	 */
	public int confirm(TrackRepairApply apply)  throws Exception;
	
	
	/**
	 * 根据查询
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<TrackRepairApply>  getPrint(Map<String, Object> params)throws Exception;
	
	
	/**
	 * 导出数据
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
	
}
