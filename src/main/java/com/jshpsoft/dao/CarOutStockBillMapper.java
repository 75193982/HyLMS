package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarOutStockBill;

/**
 * 商品车出库单dao
* @author  fengql 
* @date 2016年9月30日 上午11:04:13
 */
public interface CarOutStockBillMapper {

	public void insertByParams(Map<String, Object> params) throws Exception;
	
	public List<CarOutStockBill> getOutBillPrintData(String scheduleBillNo) throws Exception;
}
