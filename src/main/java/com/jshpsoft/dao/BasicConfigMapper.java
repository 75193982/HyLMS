package com.jshpsoft.dao;

import com.jshpsoft.domain.BasicConfig;

/** 
 * 常用配置mapper
 * @author  army.liu
 */
public interface BasicConfigMapper {
	
	public BasicConfig getByConfigName(String configName) throws Exception ;

	public void insert(BasicConfig bean) throws Exception ;

	public void update(BasicConfig bean) throws Exception ;
	
}
