package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleTrackChangeApply;
import com.jshpsoft.util.Pager;

/**
 * 在途换车管理service
* @author  fengql 
* @date 2016年10月8日 下午5:19:09
 */
public interface TrackChangeMngService {
	
	/**
	 * 根据参数获取在途换车列表数据-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<ScheduleTrackChangeApply> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取调度单下拉数据
	* @author  fengql 
	* @date 2016年10月9日 下午1:21:57 
	* @parameter  
	* @return
	 */
	public List<ScheduleBill> getSchBillNo(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存换车申请
	* @author  fengql 
	* @date 2016年10月8日 下午5:25:02 
	* @parameter  
	* @return
	 */
	public void save(ScheduleTrackChangeApply bean, String oper) throws Exception;
	
	/**
	 * 获取换车申请明细
	* @author  fengql 
	* @date 2016年10月9日 下午1:30:53 
	* @parameter  
	* @return
	 */
	public ScheduleTrackChangeApply getById(Integer id) throws Exception;
	
	/**
	 * 提交换车申请
	* @author  fengql 
	* @date 2016年10月8日 下午5:29:13 
	* @parameter  
	* @return
	 */
	public void submit(Integer id, String oper) throws Exception;
	
	/**
	 * 更新换车申请
	* @author  fengql 
	* @date 2016年10月9日 下午1:32:43 
	* @parameter  
	* @return
	 */
	public void update(ScheduleTrackChangeApply bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年10月8日 下午5:30:19 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 审核通过
	* @author  fengql 
	* @date 2016年10月9日 下午1:37:44 
	* @parameter  
	* @return
	 */
	public void auditSuccess(Map<String, Object> params, String oper) throws Exception;
	
	/**
	 * 审核不通过
	* @author  fengql 
	* @date 2016年10月9日 下午1:39:26 
	* @parameter  
	* @return
	 */
	public void auditFail(Map<String, Object> params, String oper) throws Exception;
	
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
	public void auditForConfirm(Map<String, Object> params, String oper) throws Exception;

}
