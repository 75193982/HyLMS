package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.SupplierBusinessPrice;

/**
 * @author  ww 
 * @date 2016年11月24日 下午3:49:18
 */
public interface SupplierBusinessPriceMapper {
	
	/**
	 * 保存
	 * @author  ww 
	 * @date 2016年11月24日 下午4:45:52
	 * @parameter  
	 * @return
	 */
	public void insert(SupplierBusinessPrice bean) throws Exception;
	
	/**
	 * 修改 删除
	 * @author  ww 
	 * @date 2016年11月24日 下午4:45:57
	 * @parameter  
	 * @return
	 */
	public void update(SupplierBusinessPrice bean) throws Exception;

	/**
	 * 根据品牌删除
	 * @author  ww 
	 * @date 2016年11月24日 下午4:46:04
	 * @parameter  
	 * @return
	 */
	public void updateByBusinessId(SupplierBusinessPrice bean) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<SupplierBusinessPrice> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据id获取
	 * @author  ww 
	 * @date 2016年11月25日 上午10:39:14
	 * @parameter  
	 * @return
	 */
	public SupplierBusinessPrice getById(int id) throws Exception;
	
	public List<SupplierBusinessPrice> getByConditions(Map<String, Object> params)  throws Exception;
	
	/**
	 * 得到去重的库区
	 * @author  ww 
	 * @date 2016年12月17日 上午8:51:11
	 * @parameter  
	 * @return
	 */
	public List<SupplierBusinessPrice> getLibNameBySup(Map<String, Object> params) throws Exception;
}
