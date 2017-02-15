package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarOutStockBill;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleBillChangeApply;
import com.jshpsoft.domain.ScheduleTrackChangeApply;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.util.Pager;

/**
 * 调度管理service
* @author  fengql 
* @date 2016年9月29日 下午1:18:15
 */
public interface ScheduleMngService {

	/**
	 * 根据参数获取调度单信息-分页
	* @author  fengql 
	* @date 2016年9月29日 下午1:23:21 
	* @parameter  
	* @return
	 */
	public Pager<ScheduleBill> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取配件列表数据-分页
	* @author  fengql 
	* @date 2016年9月29日 下午2:52:10 
	* @parameter  
	* @return
	 */
	public Pager<CarAttachmentStock> getPageCarAttachmentData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存/更新调度单信息
	* @author  fengql 
	* @date 2016年9月29日 下午3:27:05 
	* @parameter  
	* @return
	 */
	public void save(ScheduleBill bean, String oper) throws Exception;
	
	/**
	 * 追加预付
	* @author  fengql 
	* @date 2016年11月26日 上午10:31:50 
	* @parameter  
	* @return
	 */
	public void addPrepay(TransportPrepayApply bean, String oper) throws Exception;
	
	/**
	 * 根据scheduleBillNo更新--删除标记
	* @author  fengql 
	* @date 2016年9月29日 下午5:03:07 
	* @parameter  
	* @return
	 */
	public void updateByBillNo(String scheduleBillNo, String oper) throws Exception;

	/**
	 * 根据scheduleBillNo获取调度单详情
	* @author  fengql 
	* @date 2016年9月29日 下午5:09:11 
	* @parameter  
	* @return
	 */
	public ScheduleBill getDetailData(String scheduleBillNo) throws Exception;
	
	/**
	 * 复核调度单
	* @author  fengql 
	* @date 2016年9月30日 上午9:35:02 
	* @parameter  
	* @return
	 */
	/*public void verify(Map<String, Object> params, String oper) throws Exception;*/
	
	/**
	 * 仓管员确认调度单
	* @author  fengql 
	* @date 2016年9月30日 上午9:35:33 
	* @parameter  
	* @return
	 */
	/*public void stockVerify(Map<String, Object> params, String oper, String stockId) throws Exception;*/
	
	/**
	 * 驾驶员确认调度单
	* @author  fengql 
	* @date 2016年9月30日 上午9:36:35 
	* @parameter  
	* @return
	 */
	/*public void driverVerify(Map<String, Object> params, String oper, String stockId) throws Exception;*/
	
	/**
	 * 到达每个4S店确认完成
	* @author  fengql 
	* @date 2016年9月30日 上午9:37:16 
	* @parameter  
	* @return
	 */
	public void finish(Map<String, Object> params, String oper) throws Exception;
	
	/**
	 * 调度单完成
	* @author  fengql 
	* @date 2016年11月10日 下午4:13:18 
	* @parameter  
	* @return
	 */
	public void finishAll(Map<String, Object> params, String oper) throws Exception;
	
	/**
	 * 保存换车申请
	* @author  fengql 
	* @date 2016年9月30日 上午9:38:55 
	* @parameter  
	* @return
	 */
	public void trackChangeApply(ScheduleTrackChangeApply bean, String oper) throws Exception;
	
	/**
	 * 提交调度单
	* @author  fengql 
	* @date 2016年9月30日 上午9:33:14 
	* @parameter  
	* @return
	 */
	public void submit(String scheduleBillNo, String oper) throws Exception;
	
	/**
	 * 审核通过--驾驶员确认
	* @author  fengql 
	* @date 2016年10月13日 下午1:14:30 
	* @parameter  
	* @return
	 */
	public void auditSuccess(String scheduleBillNo, String status, String oper) throws Exception;
	
	/**
	 * 审核不通过-复核
	 * @author  fengql 
	 * @date 2016年10月13日 下午1:14:58 
	 * @parameter  
	 * @return
	 */
	public void auditFail(int detailId, int status, int operId) throws Exception;

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
	
	/**
	 * 根据参数获取调度单信息
	* @author  fengql 
	* @date 2016年9月29日 下午1:23:21 
	* @parameter  
	* @return
	 */
	public List<ScheduleBill> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取商品车出库单数据
	* @author  fengql 
	* @date 2016年11月11日 下午1:53:46 
	* @parameter  
	* @return
	 */
	public List<CarOutStockBill> getCarOutStockBillData(String scheduleBillNo) throws Exception;
	
	/**
	 * 仓管员、驾驶员
	 * 获取调度单列表数据   
	* @author  fengql 
	* @date 2016年11月26日 下午3:50:35 
	* @parameter  
	* @return
	 */
	public Pager<ScheduleBill> getOwnPageData(Map<String, Object> params) throws Exception;

	/**
	 * @Description: 获取未报销的最早一条调度单信息
	 * @author army.liu 
	 * @param @param params
	 * @param @return    设定文件
	 * @return ScheduleBill    返回类型
	 * @throws
	 * @see
	 */
	public ScheduleBill getEnabledScheduleBillInfo(Map<String, Object> params) throws Exception;

	/**
	 * @Description: 保存快速调度数据
	 * @author army.liu 
	 * @param @param bean
	 * @param @param userIdFromSession    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void saveForFast(ScheduleBill bean, int userIdFromSession) throws Exception;

	/**
	 * 
	 * @Description: 根据调度单号获取快速调度的详细信息
	 * @author army.liu 
	 * @param @param scheduleBillNo
	 * @param @return    设定文件
	 * @return ScheduleBill    返回类型
	 * @throws
	 * @see
	 */
	public ScheduleBill getScheduleDetailForFast(String scheduleBillNo) throws Exception;

	/**
	 * 
	 * @Description: 申请修改调度单-快速调度
	 * @author army.liu 
	 * @param @param scheduleBillNo
	 * @param @param userIdFromSession    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void applyModifyScheduleForFast(String scheduleBillNo,
			int userId, String reason) throws Exception;

	/**
	 * 
	 * @Description: 获取调度修改申请分页数据
	 * @author army.liu 
	 * @param @param params
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return Pager<ScheduleBillChangeApply>    返回类型
	 * @throws
	 * @see
	 */
	public Pager<ScheduleBillChangeApply> getScheduleBillChangeApplyPageData(
			Map<String, Object> params) throws Exception;

	/**
	 * 
	 * @Description: 审核调度修改申请
	 * @author army.liu 
	 * @param @param scheduleBillApplyId
	 * @param @param auditResult
	 * @param @param auditSuggest
	 * @param @param userIdFromSession
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void auditScheduleBillChangeApply(String scheduleBillApplyIds,
			String auditResult, String auditSuggest, int userIdFromSession) throws Exception;
	
	/**
	 * 
	 * @Description: 根据快速调度单详细进行出库动作
	 * @author army.liu 
	 * @param @param scheduleBillNo
	 * @param @param oper
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void outStockForFastSchedule(String scheduleBillNo, String oper)throws Exception;
	
	/**
	 * 调度查询-汇总查询
	 * @author  ww 
	 * @date 2016年12月30日 上午9:48:25
	 * @parameter  params[stockId-仓库、insertUser-调度员id]
	 * @return
	 */
	public Pager<ScheduleBill> getGroupByUserPageData(Map<String, Object> params) throws Exception;
}
