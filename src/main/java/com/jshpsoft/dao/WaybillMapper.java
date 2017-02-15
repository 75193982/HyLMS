package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.domain.Waybill;
public interface WaybillMapper {
	public void insertWaybill(Waybill waybill) throws Exception ;
	public List<Waybill> getWaybillList(Map<String, Object> params)throws Exception;
	public int getWaybillCount(Map<String, Object> params)throws Exception;
	public int deleteWaybill(int id) throws Exception ;
	public Waybill queryWaybill(int id) throws Exception ;
	
	public int updateWaybill(Waybill waybill) throws Exception ;
	
	public int submitWaybill(Map<String, Object> params) throws Exception;
	public Waybill checkWaybill(int id) throws Exception;

	public Waybill queryWaybillByWaybillNo(String waybillNo)throws Exception;

	
	public List<Waybill> getWaybillNo(Map<String, Object> params)throws Exception;
	
	//折损车
	public List<Waybill> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	/**
	 * 
	 * @Description: 主键获取运单
	 * @author army.liu 
	 * @param @param id
	 * @param @return    设定文件
	 * @return Waybill    返回类型
	 * @throws
	 * @see
	 */
	public Waybill getById(Integer id) throws Exception;
	
	public List<Waybill> getAllList(Map<String, Object> params)throws Exception;

	public List<BalanceCar> getInComePageList(Map<String, Object> params) throws Exception;
	
	public int getInComePageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<BalanceCar> getInComeByConditions(Map<String, Object> params) throws Exception;
	
	public List<Waybill> getByConditions(Map<String, Object> params) throws Exception;
	
}
