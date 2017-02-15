
package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageStockInOut;

/**
 * @author  ww 
 * @date 2016年10月8日 下午2:27:52
 */
public interface CarDamageStockInOutMapper {
	public void save(CarDamageStockInOut bean) throws Exception;
	
	public void update(CarDamageStockInOut bean)throws Exception;
	
	public void delete(Map<String, Object> params)throws Exception;
	
	public List<CarDamageStockInOut> getListData () throws Exception;
	
	public CarDamageStockInOut getById(int id)throws Exception;
	
	public CarDamageStockInOut getByCarStockId(Integer carStockId)throws Exception;
	
	public int updateByBusinessId(Map<String, Object> params) throws Exception;
	
	public List<CarDamageStockInOut> getByConditions(Map<String, Object> params)  throws Exception;
	
	//折损车出库登记数据
	public List<CarDamageStockInOut> getPageList(Map<String, Object> params) throws Exception;
			
	public int getPageTotalCount(Map<String, Object> params) throws Exception;

}
