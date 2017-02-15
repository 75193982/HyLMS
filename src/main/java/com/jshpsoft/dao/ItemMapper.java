package com.jshpsoft.dao;

import com.jshpsoft.domain.Item;

import java.util.List;
import java.util.Map;

public interface ItemMapper {
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<Item> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<Item> getByConditions(Map<String, Object> params) throws Exception ;
	
	public Item getById(int id) throws Exception ;
	
	public void insert(Item bean)  throws Exception;

	public int updateBySelective(Item bean) throws Exception;

	public Item getBydetilId(Map<String, Object> params) throws Exception;
}