package com.jshpsoft.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.Waybill;
import com.jshpsoft.util.Pager;
/**
 * 运单管理service
 * @author lvhao
 *
 */
public interface WaybillManageService {
	/**
	 * 新增运单
	 * @param waybill
	 * @throws Exception
	 */
	public void insertWaybill(Waybill waybill, HttpServletRequest req)throws Exception;
	/**
	 * 根据运单状态查询
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Pager<Waybill> getWaybillList(Map<String, Object> params)throws Exception;
	/**
	 * 根据id查询
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Waybill queryWaybill (int id)throws Exception;
	/**
	 * 删除运单
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int deleteWaybill(int id)throws Exception;
	
	/**
	 * 更新运单
	 * @param waybill
	 * @return
	 * @throws Exception
	 */
	public int updateWaybill(Waybill waybill, HttpServletRequest req)throws Exception;
	/**
	 * 提交运单
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int submitWaybill(Map<String, Object> params)throws Exception;
	/**
	 * 撤回运单
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int cancelWaybill(Map<String, Object> params)throws Exception;
	/**
	 * 查看运单详细
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public Waybill  checkWaybill(int id) throws Exception;
	
	/**
	 * 复核通过
	 * @param waybillId 运单号
	 * @param status 状态
	 * @param userId 用户id
	 * @return
	 * @throws Exception
	 */
	public void auditSuccess(int waybillId , int status , int userId) throws Exception;
	
	/**
	 * 复核不通过
	 * @param waybillId 运单号
	 * @param status 状态
	 * @param userId 用户id
	 * @return
	 * @throws Exception
	 */
	public void auditFail(int waybillId , int status , int userId) throws Exception;
	
	/**
	 * 
	 * @Description: 确认操作（只改状态）
	 * @author army.liu 
	 * @param @param waybillId
	 * @param @param status
	 * @param @param operId    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void auditForConfirm(int waybillId, int status, int operId) throws Exception;

}
