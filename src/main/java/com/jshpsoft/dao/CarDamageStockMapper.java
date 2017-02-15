package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageStock;

/**
 * @author  ww 
 * @date 2016年10月9日 上午10:10:25
 */
public interface CarDamageStockMapper {
	
	public void save(CarDamageStock bean) throws Exception;
	
	public void update(CarDamageStock bean)throws Exception;
	
	public void delete(Map<String, Object> params)throws Exception;
	
	public CarDamageStock getById(int id)throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<CarDamageStock> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<CarDamageStock> getByConditions(Map<String, Object> params)  throws Exception;
	
	//不分页
	public List<CarDamageStock> getCarDamRuList(Map<String, Object> params) throws Exception;
	
	public int updateByWaybillId(Map<String, Object> params) throws Exception;
	
	//根据入库单查询折损车库存  判断是否有
	public int selectCountByWayId(Map<String, Object> params) throws Exception;
	//绑定折损车
	public void bindCarDamStock(Map<String, Object> params) throws Exception;
	//根据入库单号查询折损车
	public List<CarDamageStock> queryCarDamStock(int waybillId) throws Exception;
	
	/**
	 * 根据折损车出入库id获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<CarDamageStock> getCarDamPageListByCarDamInOutId(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getCountByCarDamInOutId(Map<String, Object> params) throws Exception;
}
