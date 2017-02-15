package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarStock;

/**
 * 商品车库存service
 * @author lvhao
 * @date 2016年9月26日 下午3:02:44
 */
public interface CarStockService {
	/**
	 * 查询需要绑定的商品车
	 * @author lvhao
	 * @date 2016年9月26日 下午3:02:44
	 * @throws Exception
	 */
	public List<CarStock> queryCarStockByStatus(Map<String, Object> params)throws Exception ;
	/**
	 * 绑定商品车
	 * @author lvhao
	 * @date 2016年9月26日 下午3:02:44
	 * @return
	 * @throws Exception
	 */
	public int bindCarStock(Map<String, Object> params)throws Exception ;
	/**
	 * 批量绑定+取消
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int batchBindCarStock(Map<String, Object> params)throws Exception ;
}
