package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.CarDamageStockInOut;
import com.jshpsoft.domain.CarDamageStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年10月8日 下午2:29:42
 */
public interface CarDamageStockInOutService {
	//折损车入库管理 数据
	public Pager<Waybill> getRuPageData(Map<String, Object> params) throws Exception;
	//折损车入库保存
	public void saveRu(Waybill waybill,String stockId,int userId) throws Exception;
	//折损入库删除
	public void deleteWaybill(int id) throws Exception;
	//提交
	public int submitWaybill(Map<String, Object> params) throws Exception;
	//绑定折损车
	public void bindCarDamStock(Map<String, Object> params) throws Exception;
	//判断折损车是否存在该入库单号
	public List<CarDamageStock> checkRuWaybillId(Map<String, Object> params)throws Exception;
	
	//绑定折损车
	public void bindDamAttachment(Map<String, Object> params) throws Exception;
	
	//查询入库单详细信息
	public Waybill checkWaybill(int id) throws Exception; 
	
	
	
	//折损车出库登记数据
	public Pager<CarDamageStockInOutDetail> getPageData(Map<String, Object> params) throws Exception;
	
	//折损车出库登记数据 -- 不分页
	public List<CarDamageStock> getCarDamRuList(Map<String, Object> params) throws Exception;
	
	public void save(CarDamageStockInOut bean,String stockId,String userName) throws Exception;
	
	public void update(CarDamageStockInOut bean,String userName)throws Exception;
	
	public void delete(int id,String userName)throws Exception;
	
	public void submit(int id,String userId)throws Exception;
	
	public List<CarDamageStockInOut> getListData()throws Exception;
	
	public CarDamageStockInOut getById(int id)throws Exception;
	//折损车出库管理数据
	public Pager<CarDamageStockInOut> getCarDamOutData(Map<String, Object> params) throws Exception;
	
	public List<CarDamageStockInOutDetail> getByParentId(int id) throws Exception;
	
	/**
	 * 复核通过
	 * @param detailId 运单号
	 * @param status 状态
	 * @param userId 用户id
	 * @return
	 * @throws Exception
	 */
	public void auditSuccess(int detailId , int status , int userId) throws Exception;
	
	/**
	 * 复核不通过
	 * @param detailId 运单号
	 * @param status 状态
	 * @param userId 用户id
	 * @return
	 * @throws Exception
	 */
	public void auditFail(int detailId , int status , int userId) throws Exception;
	
	/**
	 * 
	 * @Description: 确认操作（只改状态）
	 * @author army.liu 
	 * @param @param detailId
	 * @param @param status
	 * @param @param operId    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void auditForConfirm(int detailId, int status, int operId) throws Exception;
}
