package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarAttachmentStockInOut;
import com.jshpsoft.domain.CarAttachmentStockInOutAndUser;

/**
 * @author  ww 
 * @date 2016年9月26日 下午2:48:53
 */
public interface CarAttachmentStockInOutMapper {

	public void save(CarAttachmentStockInOut bean) throws Exception;
	
	public void update(CarAttachmentStockInOut bean) throws Exception;
	
	//配件入库 根据运单修改状态
	public void updateByBusinessId(Map<String, Object> params)throws Exception;

	public void deleteByBusinessId(Map<String, Object> params)throws Exception;
	
	public void delete(Map<String, Object> params) throws Exception;
	
	//public List<CarAttachmentStockInOut> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 获得分页数据
	 * @author  ww 
	 * @date 2016年9月29日 上午9:08:42
	 * @parameter  
	 * @return
	 */
	public List<CarAttachmentStockInOutAndUser> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获得总页数
	 * @author  ww 
	 * @date 2016年9月29日 上午9:09:10
	 * @parameter  
	 * @return
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
}
