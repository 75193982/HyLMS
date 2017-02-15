package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.Item;
import com.jshpsoft.domain.ProcessDetail;
import com.jshpsoft.domain.Task;
import com.jshpsoft.domain.TaskHistory;
import com.jshpsoft.util.Pager;

/**
 * 
 * @Description: 待办任务service
 * @author army.liu
 * @date 2016年10月8日 上午10:18:03
 *
 */
public interface TaskService {

	/**
	 * 
	 * @Description: 获取待办任务的列表分页数据
	 * @author army.liu 
	 * @param @param params
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return Pager<Task>    返回类型
	 * @throws
	 * @see
	 */
	public Pager<Task> getPageData(Map<String, Object> params)  throws Exception;

	/**
	 * 
	 * @Description: 获取待办任务的详细信息
	 * @author army.liu 
	 * @param itemId
	 * @return Map<String,Object>
	 * @throws
	 * @see
	 */
	public Map<String, Object> getDetailInfoForItem(Integer itemId) throws Exception;
	
	/**
	 * 
	 * @Description: 保存待办任务审核结果
	 * @author army.liu 
	 * @param taskId
	 * @param operId
	 * @param mark
	 * @param successFlag : Y-审核通过,N-审核不通过
	 * @param attachFilePath 
	 * @param params 
	 * @param attachFilePath2 
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void audit(String taskId, String operId, String mark, String successFlag, String attachFileName, String attachFilePath, Map<String, Object> params, HttpServletRequest req) throws Exception;
	
	public void save(Task bean, String operId) throws Exception;

	public Task getById(Integer id) throws Exception;
	
	public void delete(Integer id, String operId) throws Exception;

	/**
	 * 
	 * @Description: 获取办公申请的分页数据
	 * @author army.liu 
	 * @param @param params
	 * @param @return    设定文件
	 * @return Pager<Item>    返回类型
	 * @throws
	 * @see
	 */
	public Pager<Item> getPageDataForItem(Map<String, Object> params) throws Exception;

	/**
	 * 
	 * @Description: 保存办公申请
	 * @author army.liu 
	 * @param @param bean
	 * @param @param operId    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void saveForItem(Item bean, int operId) throws Exception;
	
	/**
	 * 
	 * @Description: 删除办公申请
	 * @author army.liu 
	 * @param @param itemId
	 * @param @param operId    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void deleteForItem(int itemId, int operId) throws Exception;

	/**
	 * 
	 * @Description: 提交办公申请
	 * @author army.liu 
	 * @param @param bean
	 * @param @param operId    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void submitForItem(int itemId, int operId) throws Exception;
	
    /**
     * 导出办公费用信息
     * @author  ww 
     * @date 2016年10月21日 下午1:02:51
     * @parameter  
     * @return
     */
    public Map<String, Object> getExportDataForItem(Map<String, Object> params) throws Exception;
    
    /**
     * 得到打印数据
     * @author  ww 
     * @date 2016年10月21日 下午2:24:00
     * @parameter  
     * @return
     */
    public List<Item> getListForItem(Map<String, Object> params) throws Exception;

	/**
	 * 
	 * @Description: 获取流程步骤信息
	 * @author army.liu 
	 * @param @param processDetailId
	 * @param @return    设定文件
	 * @return ProcessDetail    返回类型
	 * @throws
	 * @see
	 */
	public ProcessDetail getProcessDetailInfo(Integer processDetailId) throws Exception;

	/**
	 * 
	 * @Description: 获取已办事项的分页列表
	 * @author army.liu 
	 * @param @param params
	 * @param @return    设定文件
	 * @return Pager<TaskHistory>    返回类型
	 * @throws
	 * @see
	 */
	public Pager<TaskHistory> getPageDataForHasDo(Map<String, Object> params) throws Exception;
	
	/**
	 * 
	 * @Description: 办公申请审核通过
	 * @author army.liu 
	 * @param @param id
	 * @param @param status
	 * @param @param oper
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void auditSuccess(Integer id, String status, String oper, Map<String, Object> params) throws Exception;
	
	/**
	 * 
	 * @Description: 办公申请审核不通过
	 * @author army.liu 
	 * @param @param id
	 * @param @param status
	 * @param @param oper
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void auditFail(Integer id, String status, String oper) throws Exception;
	
	/**
	 * 
	 * @Description: 办公申请审核更新
	 * @author army.liu 
	 * @param @param id
	 * @param @param status
	 * @param @param oper
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void auditForConfirm(Integer id, String status, String oper, Map<String, Object> params) throws Exception;

		/**
	 * 
	 * @Description: 获取操作历史的详细信息
	 * @author gll
	 * @param itemId
	 * @return Map<String,Object>
	 * @throws
	 * @see
	 */
	public Map<String, Object> getDetailInfoDetailId(Map<String, Object> params) throws Exception;

	/**
	 * 
	 * @Description: 取消待办事项-将接收人设置空，更新删除标记
	 * @author army.liu 
	 * @param @param taskId
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void cancelTask(Integer taskId) throws Exception;
	
}
