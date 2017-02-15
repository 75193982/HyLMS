package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageStockInOutDetail;
import com.jshpsoft.domain.CarDamageStockInOutDetailAndMark;

/**
 * @author  ww 
 * @date 2016年10月8日 下午4:35:56
 */
public interface CarDamageStockInOutDetailMapper {
	public void save(CarDamageStockInOutDetail bean) throws Exception;
	
	public void update(CarDamageStockInOutDetail bean)throws Exception;
	
	public void delete(Map<String, Object> params)throws Exception;
	
	public List<CarDamageStockInOutDetail> getByParent(int parentId)throws Exception;
	
	//折损车出库登记数据
		public List<CarDamageStockInOutDetail> getPageList(Map<String, Object> params) throws Exception;
		
		public int getPageTotalCount(Map<String, Object> params) throws Exception;
	//折损车出库管理数据
		public List<CarDamageStockInOutDetailAndMark> getCarDamList(Map<String, Object> params) throws Exception;
		
		public int getCarDamTotalCount(Map<String, Object> params) throws Exception;
		
	public CarDamageStockInOutDetail getByCarStockId(Integer carStockId)throws Exception;
	
	public int updateByBusinessId(Map<String, Object> params) throws Exception;
	
	public List<CarDamageStockInOutDetail> getByConditions(Map<String, Object> params)  throws Exception;
	
	public List<CarDamageStockInOutDetail> getOutDetailListByParentId(int id) throws Exception;
	
	//查询系统-折损出入库查询 查看明细
	public List<CarDamageStockInOutDetail> getDetailByParentId(Map<String, Object> params) throws Exception;
	public int getDetailPageTotalCount(Map<String, Object> params) throws Exception;
}
