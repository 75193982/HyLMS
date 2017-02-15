package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ItemType;
import com.jshpsoft.util.Pager;

public interface ItemTypeService {

	public Pager<ItemType> getPageData(Map<String, Object> params)  throws Exception;

	public void save(ItemType bean, String operId) throws Exception;

	public ItemType getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;

	/**
	 * 
	 * @Description: 获取所有可用的列表数据
	 * @author army.liu 
	 * @param @return    设定文件
	 * @return List<ItemType>    返回类型
	 * @throws
	 * @see
	 */
	public List<ItemType> getAllData() throws Exception;
	
}
