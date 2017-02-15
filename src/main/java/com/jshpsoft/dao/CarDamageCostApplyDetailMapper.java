package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageCostApplyDetail;

/**
 * 折损费用申请明细dao
 * @author  army.liu 
 */
public interface CarDamageCostApplyDetailMapper {
	
	public void insert(CarDamageCostApplyDetail bean) throws Exception;
	
	public List<CarDamageCostApplyDetail> getByConditions(Map<String, Object> params) throws Exception;
	
	public void deleteByParentId(Integer parentId) throws Exception;
	
	public int updateByParentId(Map<String, Object> params) throws Exception;
}
