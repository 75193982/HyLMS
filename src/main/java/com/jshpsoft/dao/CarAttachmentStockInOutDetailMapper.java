package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarAttachmentStockInOutDetail;


/**
 * @author  ww 
 * @date 2016年10月11日 下午2:45:15
 */
public interface CarAttachmentStockInOutDetailMapper {
	
	public void save(CarAttachmentStockInOutDetail bean) throws Exception;
	
	public void deleteByBusinessId(Map<String, Object> params)throws Exception;
	
	public List<CarAttachmentStockInOutDetail> getDetailByParentId(Map<String, Object> params) throws Exception;
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<CarAttachmentStockInOutDetail> getByConditions(Map<String, Object> params) throws Exception;
}
