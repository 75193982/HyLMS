package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.OutSourcingBusinessPrice;

/**
 * @author  ww 
 * @date 2016年11月26日 下午5:58:36
 */
public interface OutSourcingBusinessPriceMapper {
	
	/**
	 * 保存
	 * @author  ww 
	 * @date 2016年11月24日 下午4:45:52
	 * @parameter  
	 * @return
	 */
	public void insert(OutSourcingBusinessPrice bean) throws Exception;
	
	/**
	 * 修改 删除
	 * @author  ww 
	 * @date 2016年11月24日 下午4:45:57
	 * @parameter  
	 * @return
	 */
	public void update(OutSourcingBusinessPrice bean) throws Exception;

	/**
	 * 根据品牌删除
	 * @author  ww 
	 * @date 2016年11月24日 下午4:46:04
	 * @parameter  
	 * @return
	 */
	public void updateByBusinessId(OutSourcingBusinessPrice bean) throws Exception;
	
	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<OutSourcingBusinessPrice> getPageList(Map<String, Object> params) throws Exception;
	
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
	public OutSourcingBusinessPrice getById(int id) throws Exception;
	
	public List<OutSourcingBusinessPrice> getByConditions(Map<String, Object> params)  throws Exception;
	
	/**
	 * 获得承运商的库区
	 * @author  ww 
	 * @date 2016年12月17日 下午5:10:55
	 * @parameter  
	 * @return
	 */
	public List<OutSourcingBusinessPrice> getLibNameByOs (Map<String, Object> params)  throws Exception;

}
