
package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageCostApply;

/**
 * 折损费用申请dao
 * @author  army.liu 
 */
public interface CarDamageCostApplyMapper {
	
	public void insert(CarDamageCostApply bean) throws Exception;
	
	public List<CarDamageCostApply> getByConditions(Map<String, Object> params) throws Exception;
	
	public List<CarDamageCostApply> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public CarDamageCostApply getById(Integer id)throws Exception;
	
	public void update(CarDamageCostApply bean) throws Exception;

}
