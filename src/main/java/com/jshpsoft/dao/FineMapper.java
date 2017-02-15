package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Fine;

/**
 * @author  ww 
 * @date 2016年12月3日 上午10:18:12
 */
public interface FineMapper {
	
	public void insert(Fine bean)  throws Exception;
	
	public void update(Fine bean) throws Exception;
	
	public Fine getById(Integer id) throws Exception;
	
	public List<Fine> getByConditions(Map<String, Object> params)  throws Exception;

}
