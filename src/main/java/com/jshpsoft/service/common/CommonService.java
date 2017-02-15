package com.jshpsoft.service.common;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.Department;
import com.jshpsoft.domain.Menu;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.ReportForSchedulebill;
import com.jshpsoft.domain.ReportForWaybill;
import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.Stock;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.Track;
import com.jshpsoft.util.Pager;

/**
 * 一些公共的service
* @author  fengql 
* @date 2016年9月26日 上午11:12:18
 */
public interface CommonService {

	/**
	 * 获取部门数据
	* @author  fengql 
	* @date 2016年9月26日 上午11:16:55 
	* @parameter  
	* @return
	 */
	public List<Department> getDepartmentList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取仓库数据
	* @author  fengql 
	* @date 2016年9月26日 上午11:17:06 
	* @parameter  
	* @return
	 */
	public List<Stock> getStockList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取角色数据
	* @author  fengql 
	* @date 2016年9月26日 上午11:17:16 
	* @parameter  
	* @return
	 */
	public List<Role> getRoleList() throws Exception;
	
	/**
	 * 获取所有菜单
	 * @author  ww 
	 * @date 2016年9月27日 下午1:23:07
	 * @parameter  
	 * @return
	 */
	public List<Menu> getMenuList() throws Exception;
	
	
	/**
	 * 获取所有供应商
	 * @author  lvhao 
	 * @date 2016年9月27日 上午10:17:16 
	 * @return
	 * @throws Exception
	 */
	public List<Supplier> getBasicSuppliersList(Map<String, Object> params)throws Exception;
	
	/**
	 * 获取所有品牌
	 * @author  lvhao 
	 * @date 2016年9月27日 上午10:17:16 
	 * @return
	 * @throws Exception
	 */
	public List<CarBrand> getCarBrandList(Map<String, Object> params)throws Exception;
	
	/**
	 * 获取所有4S店
	 * @author  lvhao 
	 * @date 2016年9月27日 上午10:17:16 
	 * @return
	 * @throws Exception
	 */
	public List<CarShop> getCarShopList(Map<String, Object> params)throws Exception;
	
	/**
	 * 获取所有的外协单位
	* @author  fengql 
	* @date 2016年9月28日 上午10:20:01 
	* @parameter  
	* @return
	 */
	public List<OutSourcing> getOutSourcingList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取所有的运输车辆信息
	* @author  fengql 
	* @date 2016年10月9日 下午2:31:39 
	* @parameter  
	* @return
	 */
	public List<Track> getTrackList(Map<String, Object> params) throws Exception;
	
	/**
	 * 
	 * @Description: 获取提交的流程接收人
	 * @author army.liu 
	 * @param processId
	 * @return receiveUserId
	 * @throws
	 * @see
	 */
	public String getProcessStatusForSubmit(int processId) throws Exception;
	
	/**
	 * 
	 * @Description: 添加业务到流程中
	 * @author army.liu 
	 * @param 
	 * @return
	 * @throws
	 * @see
	 */
	public void addToProcess(String type, int detailId, int applyUserId, String itemName) throws Exception;
	
	/**
	 * 
	 * @Description: 添加业务到流程中-快速调度无流程使用
	 * @author army.liu 
	 * @param 
	 * @return
	 * @throws
	 * @see
	 */
	public void addToProcessForFastSchedule(String type, int detailId, int applyUserId, String itemName) throws Exception;
	
	/**
	 * 
	 * @Description: 添加业务到流程中-派车指令
	 * @author army.liu 
	 * @param 
	 * @return
	 * @throws
	 * @see
	 */
	public void addToProcessForPCZL(String type, int detailId, int applyUserId, String itemName, int receiveUserId) throws Exception;
	
	/**
	 * 
	 * @Description: 添加业务到流程中-折损费用申请
	 * @author army.liu 
	 * @param 
	 * @return
	 * @throws
	 * @see
	 */
	public void addToProcessForZSFYSQ(String type, int detailId, int applyUserId, String itemName) throws Exception;
	
	/**
	 * 
	 * @Description: 添加业务到流程中-费用申请
	 * @author army.liu 
	 * @param 
	 * @return
	 * @throws
	 * @see
	 */
	public void addToProcessForCostApply(String type, int detailId, int applyUserId, String itemName) throws Exception;
	/**
	 * 
	 * @Description: 添加业务到流程中-核销费用申请
	 * @author army.liu 
	 * @param 
	 * @return
	 * @throws
	 * @see
	 */
	public void addToProcessForCostApplyRetrun(String type, int detailId, int applyUserId, String itemName) throws Exception;

	/**
	 * 
	 * @Description: 更新项目对应的业务数据流程状态
	 * @author army.liu 
	 * @param @param successFlag Y-通过，N-不通过
	 * @param @param currProcessDetailId 流程步骤id
	 * @param @param itemId    设定文件
	 * @param operId
	 * @param params 
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void updateProcessStatus(String successFlag, int currProcessDetailId, Integer itemId, int operId, Map<String, Object> params) throws Exception;
	
	/**
	 * 
	 * @Description: 插入操作日志和下步待办
	 * @author army.liu 
	 * @param @param processType
	 * @param @param itemId
	 * @param @param operId
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void createNextProcess(Integer itemId, int operId ) throws Exception;
	
	/**
	 * 
	 * @Description: 插入操作日志和下步待办-派车指令
	 * @author army.liu 
	 * @param @param processType
	 * @param @param itemId
	 * @param @param operId
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void createNextProcessForPCZL(Integer itemId, int operId, int receiveUserId ) throws Exception;

	/**
	 * 
	 * @Description: 将临时目录文件重新存储
	 * @author army.liu 
	 * @param @param attachFilePath
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public String reStoreFile(String uploadType, String attachFilePath, HttpServletRequest req) throws Exception;
	
	/**
	 * 
	 * @Description: 将临时目录文件重新存储-批量处理
	 * @author army.liu 
	 * @param @param attachFilePath,多个分割
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public String reStoreFileForBatch(String uploadType, String attachFilePath, HttpServletRequest req) throws Exception;
	
	/**
	 * 
	 * @Description: 根据业务信息，获取任务id
	 * @author army.liu 
	 * @param @param type
	 * @param @param detailId
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public String getTaskIdByBusinessType(String type, String detailId) throws Exception;
	
	/**
	 * 
	 * @Description: 推送消息
	 * @author army.liu 
	 * @param @param msgContent
	 * @param @param receiveUserId
	 * @param @param detailId
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void pushMessage(String msgContent, int receiveUserId, String detailId) throws Exception;
	
	/**
	 * 
	 * @Description: 获取所有的配置值
	 * @author army.liu 
	 * @param @param configName
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public Map<String, String> getAllConfigValues() throws Exception;
	
	/**
	 * 
	 * @Description: 获取配置值
	 * @author army.liu 
	 * @param @param configName
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public String getConfigValue(int stockId, String configName) throws Exception;
	
	/**
	 * 
	 * @Description: 更新配置值
	 * @author army.liu 
	 * @param @param configName
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public void setConfigValue(String configName, String configValue, int oper)throws Exception;
	
	/**
	 * 
	 * @Description: 获取相应业务的流程id
	 * @author army.liu 
	 * @param @param type
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public String getProcessId(int stockId, String type) throws Exception;
	
	/**
	 * 
	 * @Description: 推送最新未读信息
	 * @author army.liu 
	 * @param @param receiveUserId
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public void pushLatestMsgCount(int receiveUserId) throws Exception;
	
	/**
	 * 
	 * @Description: 推送信息
	 * @author army.liu 
	 * @param @param receiveUserId
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public void pushMsgToUser(int receiveUserId, String content) throws Exception;
	
	/**
	 * 
	 * @author  ww 
	 * @date 2016年12月6日 下午5:36:03
	 * @parameter  
	 * @return
	 */
	public void addToProcessForZyyfsqd(String type, int detailId, int operId, String itemName, ScheduleBill sb) throws Exception;
	
	/**
	 * @Description: 生成业务单号
	 * @author army.liu 
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return int    返回类型
	 * @throws
	 * @see
	 */
	public String createBusinessBillNo(String businessType, int operId) throws Exception;
	
	/**
	 * 拼音
	 * @author  ww 
	 * @date 2016年12月13日 下午5:43:35
	 * @parameter  
	 * @return
	 */
	public String getPyCode(String name) throws Exception;
	
	/**
	 * 五笔
	 * @author  ww 
	 * @date 2016年12月13日 下午5:43:45
	 * @parameter  
	 * @return
	 */
	public String getWbCode(String name) throws Exception;

	/**
	 * 运单中的车辆统计
	 * @author army.liu 
	 * @parameter  
	 * @return
	 */
	public Pager<ReportForWaybill> getReportForWaybillPageData(Map<String, Object> params) throws Exception;
	public List<ReportForWaybill> getReportForWaybill(Map<String, Object> params) throws Exception;
	public Map<String, Object> getReportForWaybillExportData(Map<String, Object> params) throws Exception;
	
	/**
	 * 调度单中的车辆统计
	 * @author army.liu 
	 * @parameter  
	 * @return
	 */
	public Pager<ReportForSchedulebill> getReportForSchedulebillPageData(Map<String, Object> params) throws Exception;
	public List<ReportForSchedulebill> getReportForSchedulebill(Map<String, Object> params) throws Exception;
	public Map<String, Object> getReportForSchedulebillExportData(Map<String, Object> params) throws Exception;
	public double calculateTransportCost(ReportForSchedulebill bean);

	/**
	 * 
	 * @Description: 获取承运商中的公司车队的id
	 * @author army.liu 
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return int    返回类型
	 * @throws
	 * @see
	 */
	public int getOutSourcingIdForOwnCompany() throws Exception;

	/**
	 * 
	 * @Description: 获取与当前驾驶员有关的已经费用审核的驾驶员报销单的里程补助
	 * @author army.liu 
	 * @param @param userId
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return double    返回类型
	 * @throws
	 * @see
	 */
	public double getDriverSalaryDistanceAllowance(Integer userId, String salaryTime) throws Exception;
	
	/**
	 * 快速调度下拉
	 * @author  ww 
	 * @date 2017年2月13日 下午5:10:24
	 * @parameter  
	 * @return
	 */
	public List<Supplier> getComSuppliersList() throws Exception;

}
