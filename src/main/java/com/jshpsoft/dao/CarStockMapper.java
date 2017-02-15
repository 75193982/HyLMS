package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarStock;
/**
 * 商品车dao
 * @author lvhao
 *
 */
public interface CarStockMapper {
	public List<CarStock> queryCarStockByStatus(Map<String, Object> params)
			throws Exception;
	public int bindCarStock(Map<String, Object> params) throws Exception;
	
	public int batchCancelBindCarStock(int id) throws Exception;
	public int submitCarStock(Map<String, Object> params) throws Exception ;
	
	public List<CarStock> queryCarStock(int waybillId) throws Exception ;
	
	public void insert(CarStock bean)  throws Exception;
	
	public List<CarStock> getByConditions(Map<String, Object> params)  throws Exception;
	
	public CarStock getById(Integer id) throws Exception ;
	
	public int update(CarStock bean) throws Exception;
	
	public int updateById(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<CarStock> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	/**
	 * 取消绑定的商品车
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int cancelBindCarStock(int id) throws Exception;
	
	public int updateByWaybillId(Map<String, Object> params) throws Exception;
	/**
	 * 查询绑定运单的数量
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int selectCountById(Map<String, Object> params) throws Exception;
}
