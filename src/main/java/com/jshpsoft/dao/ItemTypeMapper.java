package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ItemType;

/** 
 * 项目类型mapper
 * @author  army.liu
 */
public interface ItemTypeMapper {
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<ItemType> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<ItemType> getByConditions(Map<String, Object> params) throws Exception ;
	
	public ItemType getById(int id) throws Exception ;
	
	public void insert(ItemType bean)  throws Exception;

	public int update(ItemType bean) throws Exception;
	
}
