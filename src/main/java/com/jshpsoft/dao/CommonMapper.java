package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.Department;
import com.jshpsoft.domain.Menu;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.ReportForSchedulebill;
import com.jshpsoft.domain.ReportForWaybill;
import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.Stock;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.Track;

/**
 * 一些公共的dao
* @author  fengql 
* @date 2016年9月26日 下午1:21:03
 */
public interface CommonMapper {

	public List<Department> getDepartmentList(Map<String, Object> params) throws Exception;

	public List<Stock> getStockList(Map<String, Object> params) throws Exception;
	
	public List<Role> getRoleList()throws Exception;
	
	public List<Menu> getMenuList ()throws Exception;
	
	public List<Supplier> getBasicSuppliersList(Map<String, Object> params) throws Exception;
	public List<CarBrand> getCarBrandList(Map<String, Object> params) throws Exception ;
	public List<CarShop> getCarShopList(Map<String, Object> params) throws Exception;
	
	public List<OutSourcing> getOutSourcingList(Map<String, Object> params) throws Exception;
	
	public List<Track> getTrackList(Map<String, Object> params) throws Exception;
	
	/**
	 * @Description: 运单中的车辆统计
	 * @author army.liu 
	 * @param @param params
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return List<ReportForWaybill>    返回类型
	 * @throws
	 * @see
	 */
	public List<ReportForWaybill> getReportForWaybillPageList(Map<String, Object> params) throws Exception;
	public int getReportForWaybillPageCount(Map<String, Object> params) throws Exception;
	public List<ReportForWaybill> getReportForWaybill(Map<String, Object> params) throws Exception;
	
	/**
	 * @Description: 调度单单中的车辆统计
	 * @author army.liu 
	 * @param @param params
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return List<ReportForWaybill>    返回类型
	 * @throws
	 * @see
	 */
	public List<ReportForSchedulebill> getReportForSchedulebillPageList(Map<String, Object> params) throws Exception;
	public int getReportForSchedulebillPageCount(Map<String, Object> params) throws Exception;
	public List<ReportForSchedulebill> getReportForSchedulebill(Map<String, Object> params) throws Exception;
	
	/**
	 * 快速调度下拉
	 * @author  ww 
	 * @date 2017年2月13日 下午5:10:24
	 * @parameter  
	 * @return
	 */
	public List<Supplier> getComSuppliersList() throws Exception;
	
}
