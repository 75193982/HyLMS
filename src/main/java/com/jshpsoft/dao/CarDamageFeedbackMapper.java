package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageFeedback;

/**
 * 折损反馈dao
 * @author army.liu 
 * @date 2016年10月18日 下午4:26:29
 */
public interface CarDamageFeedbackMapper {

	public void insert(CarDamageFeedback bean)  throws Exception;
	
	public void update(CarDamageFeedback bean)  throws Exception;
	
	public List<CarDamageFeedback> getByConditions(Map<String, Object> params) throws Exception;
	
	public List<CarDamageFeedback> getPageList(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public CarDamageFeedback getById(Integer id)throws Exception;
	
}
