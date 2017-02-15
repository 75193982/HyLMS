package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.CarStockInOut;
import com.jshpsoft.domain.CarStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.util.Pager;

/**
 * 商品车入库、库存管理service
* @author  fengql 
* @date 2016年9月28日 下午1:11:18
 */
public interface CarStockMangeService {

	/**
	 * 获取运单信息
	* @author  fengql 
	* @date 2016年9月28日 下午1:12:37 
	* @parameter  
	* @return
	 */
	public List<Waybill> getWaybillNo(Map<String, Object> params)throws Exception ;
	
	/**
	 * 商品车入库
	* @author  fengql 
	* @date 2016年9月28日 下午1:33:07 
	* @parameter  
	* @return
	 */
	public void carStockIn(CarStock bean, String stockId, String oper)throws Exception ;
	
	/**
	 * 获取商品车库存
	* @author  fengql 
	* @date 2016年9月28日 下午3:09:44 
	* @parameter  
	* @return
	 */
	public List<CarStock> getCarListData(Map<String, Object> params)throws Exception;
	
	/**
	 * 获取商品车库存-分页
	* @author  fengql 
	* @date 2016年9月28日 下午3:09:44 
	* @parameter  
	* @return
	 */
	public Pager<CarStock> getPageData(Map<String, Object> params)throws Exception;
	
	/**
	 * 调度单获取商品车
	* @author  fengql 
	* @date 2016年11月7日 下午4:04:30 
	* @parameter  
	* @return
	 */
	public Pager<CarStock> getCarList(Map<String, Object> params)throws Exception;
	
	/**
	 * 根据id获取商品车信息
	* @author  fengql 
	* @date 2016年9月28日 下午3:24:11 
	* @parameter  
	* @return
	 */
	public CarStock getById(Integer id)throws Exception ;
	
	/**
	 * 更新商品车信息
	* @author  fengql 
	* @date 2016年9月28日 下午3:41:41 
	* @parameter  
	* @return
	 */
	public void update(CarStock bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月28日 下午3:42:41 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 商品车出入库查询
	* @author  fengql 
	* @date 2016年9月28日 下午4:23:12 
	* @parameter  
	* @return
	 */
	public Pager<CarStockInOut> getCarInOutListData(Map<String, Object> params)throws Exception ;
	
	/**
	 * 商品车出入库明细查看
	 * @author  ww 
	 * @date 2016年11月8日 下午3:13:11
	 * @parameter  
	 * @return
	 */
	public Pager<CarStockInOutDetail> getCarInOutListDetail(Map<String, Object> params)throws Exception ;
	
	
	
	/**
	 * 取消绑定商品车
	 * @author  lvhao 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int cancelBindCarStock(int id)throws Exception ;
	
//	/**
//	 * 提交运单
//	* @author  fengql 
//	* @date 2016年10月11日 下午4:55:08 
//	* @parameter  waybillId-运单编号，oper-操作者id
//	* @return
//	 */
//	public void submit(Integer waybillId, String oper) throws Exception;
//	
	/**
	 * 审核通过
	* @author  fengql 
	* @date 2016年10月11日 下午5:00:01 
	* @parameter  waybillId-运单编号，oper-操作者id
	* @return
	 */
	public void verifySuccess(Integer waybillId, String oper) throws Exception;
//	
//	/**
//	 * 审核不通过
//	* @author  fengql 
//	* @date 2016年10月11日 下午5:00:11 
//	* @parameter  waybillId-运单编号，oper-操作者id
//	* @return
//	 */
//	public void verifyFail(Integer waybillId, String oper) throws Exception;
	
//	/**
//	 * 商品车出库提交
//	* @author  fengql 
//	* @date 2016年10月13日 下午1:41:13 
//	* @parameter  scheduleBillNo-调度单号,oper-操作者id
//	* @return
//	 */
//	public void carOutSubmit(String scheduleBillNo, String oper) throws Exception;
	
	/**
	 * 商品车出库审核通过
	* @author  fengql 
	* @date 2016年10月13日 下午2:22:35 
	* @parameter  scheduleBillNo-调度单号,oper-操作者id
	* @return
	 */
	public void carOutVerifySuccess(String scheduleBillNo, String oper) throws Exception;
	
//	/**
//	 * 商品车出库审核不通过
//	* @author  fengql 
//	* @date 2016年10月13日 下午2:23:07 
//	* @parameter  scheduleBillNo-调度单号,oper-操作者id
//	* @return
//	 */
//	public void carOutVerifyFail(String scheduleBillNo, String oper) throws Exception;

	/**
	 * @Description: 获取调度单号的所有车
	 * @author army.liu 
	 * @param @param scheduleBillNo
	 * @param @return    设定文件
	 * @return List<CarStock>    返回类型
	 * @throws
	 * @see
	 */
	public List<CarStock> getCarListForScheduleBillNo(String scheduleBillNo) throws Exception;
}
