package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.CarDamageStockInOut;
import com.jshpsoft.domain.CarDamageStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.util.Pager;

/**
 * 折损车service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface CarDamageMngService {
	
	/**
	 * 根据参数获取折损车信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<CarDamageStock> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据折损车出入库id获取折损车库存信息
	 * @author  ww 
	 * @date 2016年11月9日 下午3:12:45
	 * @parameter  
	 * @return
	 */
	public Pager<CarDamageStock>getPageDataByCarDamInOutId(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取折损车运单信息
	* @author  fengql 
	* @date 2016年10月13日 上午9:56:35 
	* @parameter  
	* @return
	 */
	public List<Waybill> getWaybillNo(Map<String, Object> params)throws Exception ;
	
	/**
	 * 保存折损车数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(CarDamageStock bean, String oper) throws Exception;
	
	/**
	 * 根据id获取折损车
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public CarDamageStock getById(Integer id) throws Exception;
	
	/**
	 * 更新折损车数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(CarDamageStock bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 折损车出入库查询
	* @author  fengql 
	* @date 2016年10月13日 上午10:05:37 
	* @parameter  
	* @return
	 */
	public List<CarDamageStockInOut> getCarDamageInOutListData(Map<String, Object> params)throws Exception ;
	
	/**
	 * 提交运单
	* @author  fengql 
	* @date 2016年10月11日 下午4:55:08 
	* @parameter  waybillId-运单编号，oper-操作者
	* @return
	 */
	public void submit(Integer waybillId, String oper) throws Exception;
	
	/**
	 * 审核通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:01 
	* @parameter  waybillId-运单编号，oper-操作者
	* @return
	 */
	public void verifySuccess(Integer waybillId, String oper) throws Exception;
	
	/**
	 * 审核不通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:11 
	* @parameter  waybillId-运单编号，oper-操作者
	* @return
	 */
	public void verifyFail(Integer waybillId, String oper) throws Exception;
	
	
	/**
	 * 出库审核通过
	 * @author  ww 
	 * @date 2016年10月20日 下午4:32:49
	 * @parameter  折损车出库主表id，操作者id
	 * @return
	 */
	public void checkOK(int id,String userId)throws Exception;
	/**
	 * 出库审核不通过
	 * @author  ww 
	 * @date 2016年10月20日 下午4:32:49
	 * @parameter  折损车出库主表id，操作者id
	 * @return
	 */
	public void checkNo(int id,String userId)throws Exception;
	
	/**
	 * 根据父ID得到明细  分页
	 * @author  ww 
	 * @date 2016年12月19日 下午5:31:36
	 * @parameter  
	 * @return
	 */
	public Pager<CarDamageStockInOutDetail> getDetailByParentId(Map<String, Object> params) throws Exception;
}
