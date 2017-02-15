package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Fine;

/**
 * @author  ww 
 * @date 2016年12月3日 上午10:25:31
 */
public interface FineMngService {
	
	public void save(Fine bean,String operId)  throws Exception;
	
	public List<Fine> getByConditions(Map<String, Object> params)  throws Exception;
	
	public Fine getById(Integer id) throws Exception;

}
