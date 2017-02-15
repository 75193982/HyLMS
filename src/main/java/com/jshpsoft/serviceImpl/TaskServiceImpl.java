package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarDamageCostApplyMapper;
import com.jshpsoft.dao.CarDamageFeedbackMapper;
import com.jshpsoft.dao.CarDamageStockInOutMapper;
import com.jshpsoft.dao.CarShopMapper;
import com.jshpsoft.dao.ItemMapper;
import com.jshpsoft.dao.ItemTypeMapper;
import com.jshpsoft.dao.ProcessDetailMapper;
import com.jshpsoft.dao.ProcessMapper;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.ScheduleTrackChangeApplyMapper;
import com.jshpsoft.dao.SendCarCommandMapper;
import com.jshpsoft.dao.SupplierMapper;
import com.jshpsoft.dao.TaskHistoryMapper;
import com.jshpsoft.dao.TaskMapper;
import com.jshpsoft.dao.TrackMaintenanceApplyMapper;
import com.jshpsoft.dao.TrackTyreBuyApplyMapper;
import com.jshpsoft.dao.TrackTyreChangeApplyMapper;
import com.jshpsoft.dao.TrackTyreInOutDetailMapper;
import com.jshpsoft.dao.TrackTyreInOutMapper;
import com.jshpsoft.dao.TransportCostApplyDetailMapper;
import com.jshpsoft.dao.TransportCostApplyMapper;
import com.jshpsoft.dao.TransportCostCashDetailMapper;
import com.jshpsoft.dao.TransportPrepayApplyMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.CarDamageCostApply;
import com.jshpsoft.domain.CarDamageFeedback;
import com.jshpsoft.domain.CarDamageStockInOut;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.CostApply;
import com.jshpsoft.domain.CostApplyReturn;
import com.jshpsoft.domain.Item;
import com.jshpsoft.domain.ItemType;
import com.jshpsoft.domain.ProcessDetail;
import com.jshpsoft.domain.ProcessInfo;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleTrackChangeApply;
import com.jshpsoft.domain.SendCarCommand;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.Task;
import com.jshpsoft.domain.TaskHistory;
import com.jshpsoft.domain.TrackMaintenanceApply;
import com.jshpsoft.domain.TrackTyreBuyApply;
import com.jshpsoft.domain.TrackTyreChangeApply;
import com.jshpsoft.domain.TrackTyreInOut;
import com.jshpsoft.domain.TrackTyreInOutDetail;
import com.jshpsoft.domain.TransportCostApply;
import com.jshpsoft.domain.TransportCostApplyDetail;
import com.jshpsoft.domain.TransportCostCashDetail;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CostApplyReturnService;
import com.jshpsoft.service.CostApplyService;
import com.jshpsoft.service.TaskService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("taskService")
public class TaskServiceImpl implements TaskService {

	@Autowired
	private TaskMapper taskMapper;
	
	@Autowired
	private TaskHistoryMapper taskHistoryMapper;
	
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private TransportCostCashDetailMapper transportCostCashDetailMapper;
	@Autowired
	private ItemMapper itemMapper;
	@Autowired
	private TransportCostApplyDetailMapper transportCostApplyDetailMapper;
	@Autowired
	private ItemTypeMapper itemTypeMapper;
	
	@Autowired
	private ProcessMapper processMapper;
	
	@Autowired
	private ProcessDetailMapper processDetailMapper;
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private ScheduleTrackChangeApplyMapper scheduleTrackChangeApplyMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CarShopMapper carShopMapper;
	
	@Autowired
	private SupplierMapper supplierMapper;
	
	@Autowired
	private TransportPrepayApplyMapper transportPrepayApplyMapper;
	
	@Autowired
	private TrackTyreInOutMapper trackTyreInOutMapper;
	
	@Autowired
	private TrackMaintenanceApplyMapper trackMaintenanceApplyMapper;
	
	@Autowired
	private TrackTyreInOutDetailMapper trackTyreInOutDetailMapper;
	
	@Autowired
	private TransportCostApplyMapper transportCostApplyMapper;
	
	@Autowired
	private TrackTyreChangeApplyMapper trackTyreChangeApplyMapper;
	
	@Autowired
	private CarDamageCostApplyMapper carDamageCostApplyMapper;
	
	@Autowired
	private CarDamageStockInOutMapper carDamageStockInOutMapper;
	
	@Autowired
	private CarDamageFeedbackMapper carDamageFeedbackMapper;
	
	@Autowired
	private SendCarCommandMapper sendCarCommandMapper;
	
	@Autowired
	private CostApplyService costApplyService;
	
	@Autowired
	private TrackTyreBuyApplyMapper trackTyreBuyApplyMapper;
	
	@Autowired
	private CostApplyReturnService costApplyReturnService;
	
	@Override
	@SystemServiceLog(description="查询我的任务列表信息")
	public Pager<Task> getPageData(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		List<Task> list = taskMapper.getPageList(params);
		if( null != list && list.size()> 0 ){
			for(int i=0; i<list.size(); i++){
				Task task = list.get(i);
				//提交人（来源）
				String insertUserId = task.getInsertUser();
				if( StringUtils.isNotEmpty(insertUserId) ){
					User user = userMapper.getById( Integer.parseInt(insertUserId));
					if( null != user ){
						list.get(i).setInsertUserName( user.getName() );						
					}
				}
				//接收人
				if(StringUtils.isNotEmpty(task.getReceiveUserId()))
				{
					User user = userMapper.getById( Integer.parseInt(task.getReceiveUserId()));
					if( null != user ){
						list.get(i).setReceiveUserName(user.getName());
						list.get(i).setDepartmentName(user.getDepartmentName());
					}
				}
				//当前步骤
				if(null != task.getProcessDetailId())
				{
					int processDetailId = task.getProcessDetailId();
					ProcessDetail p =  processDetailMapper.getById(processDetailId);
					list.get(i).setProcessDetailName(p.getName());
				}
				//获取当前待办是否是回到新建人处：流程步骤。orderno = 0 && insertUser == session.user
				list.get(i).setCancelFlag("N");
				Integer processDetailId = task.getProcessDetailId();
				if( null != processDetailId ){
					ProcessDetail pd = processDetailMapper.getById(processDetailId);
					if( null != pd && pd.getOrderNo() == 0 ){
						list.get(i).setCancelFlag("Y");
					}
				}
				
			}
		}
		int totalCount = taskMapper.getPageTotalCount(params);
		
		Pager<Task> pager = new Pager<Task>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="获取待办任务的详细信息")
	public Map<String, Object> getDetailInfoForItem(Integer itemId) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		
		//查询项目信息
		Item item = itemMapper.getById(itemId);
		//其中，申请人信息
		Integer applyUserId = item.getApplyUserId();
		//仓库id-运单、调度单有用
		int stockId = 0;
		if( null != applyUserId ){
			User user = userMapper.getById( applyUserId );
			if( null != user ){
				item.setApplyUserName( user.getName() );
				if( StringUtils.isNotEmpty(user.getStockId()) ){
					stockId = Integer.parseInt(user.getStockId());
				}
			}
			
		}
		//流程名称
		ProcessInfo p = processMapper.getById(item.getProcessId());
		ItemType it = itemTypeMapper.getById(p.getItemTypeId());
		item.setProcessName(it.getName());
		result.put("item", item);
		
		//查询操作日志信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("itemId", itemId+"");
		List<TaskHistory> logList = taskHistoryMapper.getByConditions(params);
		if( null != logList && logList.size() > 0 ){
			for(int i=0; i<logList.size(); i++){
				TaskHistory log = logList.get(i);
				//操作人信息
				String operateUserId = log.getOperateUserId();
				if( StringUtils.isNotEmpty(operateUserId) ){
					User user = userMapper.getById( Integer.parseInt(operateUserId));
					if( null != user ){
						logList.get(i).setOperateUserName( user.getName() );
					}
					
				}
				//流程步骤信息
				Integer processDetailId = log.getProcessDetailId();
				if( null != processDetailId ){
					ProcessDetail pd = processDetailMapper.getById(processDetailId);
					if( null != pd ){
						logList.get(i).setProcessDetailName( pd.getName() );
					}
					
				}
				
			}
		}
		result.put("logList", logList);
		
		Integer processId = item.getProcessId();
		//项目为非办公申请时，查询业务表：运单、调度单、换车申请、驾驶员报销申请
		if( null != item && null != item.getDetailId() && 0 != item.getDetailId() ){
			
			Integer detailId = item.getDetailId();
			if( commonService.getProcessId( stockId, Constants.ProcessType.YD ).equals( processId.toString() ) ){//运单
				Waybill wb = waybillMapper.getById( detailId );
				//经销单位名称
				if( null != wb.getCarShopId() ){
					CarShop cs = carShopMapper.getById(wb.getCarShopId());
					if( null != cs ){
						wb.setCarShopName(cs.getName());
					}
					
				}
				//供应商名称
				if( null != wb.getSupplierId() ){
					Supplier s = supplierMapper.getById(wb.getSupplierId());
					if( null != s ){
						wb.setSupplierName(s.getName());
					}
					
				}
				result.put("detail", wb);
				result.put("businessType", Constants.ProcessType.YD );
				
			}else if( commonService.getProcessId(stockId,  Constants.ProcessType.DDD ).equals( processId.toString() ) ){//调度单
				ScheduleBill scheduleBill = scheduleBillMapper.getById(detailId);
				//获取驾驶员的电话号码
				int driverId = scheduleBill.getDriverId();
				User user = userMapper.getById(driverId);
				if( null != user ){
					scheduleBill.setMobile( user.getMobile() );
				}
				result.put("detail", scheduleBill);
				result.put("businessType", Constants.ProcessType.DDD );
				
			}else if( commonService.getProcessId(0, Constants.ProcessType.HCSQD ).equals( processId.toString() ) ){//换车申请单
				ScheduleTrackChangeApply ca = scheduleTrackChangeApplyMapper.getById(detailId);
				result.put("detail", ca);
				result.put("businessType", Constants.ProcessType.HCSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.ZYYFSQD ).equals( processId.toString() ) ){//装运预付申请单
				TransportPrepayApply bean = transportPrepayApplyMapper.getById(detailId);
				//获取驾驶员的电话号码
				int driverId = bean.getDriverId();
				User user = userMapper.getById(driverId);
				if( null != user ){
					bean.setMobile( user.getMobile() );
				}
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.ZYYFSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.ZYFYHSSQD ).equals( processId.toString() ) ){//装运费用核算申请单
				TransportCostApply bean = transportCostApplyMapper.getById(detailId);
				if(null != bean && null != bean.getScheduleBillNo() && !"".equals(bean.getScheduleBillNo()))
				{
					String scheduleBillNo = bean.getScheduleBillNo();
					Map<String, Object> paramsPrepay = new HashMap<String, Object>();
					paramsPrepay.put("scheduleBillNo", scheduleBillNo);
					paramsPrepay.put("delFlag", Constants.DelFlag.N);
					List<TransportPrepayApply> prepayList = transportPrepayApplyMapper.getByConditions(paramsPrepay);
					if(null != prepayList && prepayList.size()>0 ){
						bean.setPrepayList(prepayList);
					}
					params.put("parentId", bean.getId());
					params.put("delFlag", Constants.DelFlag.N);
					List<TransportCostApplyDetail> costList = transportCostApplyDetailMapper.getByConditions(params);
					if(null != costList && costList.size()>0 ){
						bean.setCostList(costList);
						for(int i=0;i<costList.size();i++){
							//获取费用现金明细
							Map<String, Object> paramsCash = new HashMap<String, Object>();
							paramsCash.put("detailId", costList.get(i).getId());
							paramsCash.put("delFlag", Constants.DelFlag.N);
							List<TransportCostCashDetail> cashList = transportCostCashDetailMapper.getByConditions(paramsCash);
							costList.get(i).setCashList(cashList);
						}
					}
				}
				
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.ZYFYHSSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.LTCRKSQD ).equals( processId.toString() ) ){//轮胎出入库申请单
				TrackTyreInOut bean = trackTyreInOutMapper.getById(detailId);
				
				Map<String, Object> newParams = new HashMap<String, Object>();
				newParams.put("parentId", detailId);
				newParams.put("delFlag", Constants.DelFlag.N);
				List<TrackTyreInOutDetail> detailList = trackTyreInOutDetailMapper.getByConditions(newParams);
				bean.setDetailList(detailList);
				
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.LTCRKSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.LTCGSQD ).equals( processId.toString() ) ){//轮胎采购申请单
				TrackTyreBuyApply bean = trackTyreBuyApplyMapper.getById(detailId);
				
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.LTCGSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.WXBYSQD ).equals( processId.toString() ) ){//维修保养申请单
				TrackMaintenanceApply bean = trackMaintenanceApplyMapper.getById(detailId);
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.WXBYSQD );
				
			}else if( commonService.getProcessId(0, Constants.ProcessType.LTGHSQD ).equals( processId.toString() ) ){//轮胎更换申请单
				TrackTyreChangeApply bean = trackTyreChangeApplyMapper.getById(detailId);
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.LTGHSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.ZSFKSQD ).equals( processId.toString() ) ){//折损反馈申请单
				CarDamageFeedback bean = carDamageFeedbackMapper.getById(detailId);
				Integer carShopId=bean.getCarShopId();
				if(carShopId!=null&&carShopId!=0){
					String carShopName=carShopMapper.getCarNameById(carShopId).getName();
					bean.setCarShopName(carShopName);
				}				
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.ZSFKSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.ZSFYSQD ).equals( processId.toString() ) ){//折损费用申请单
				CarDamageCostApply bean = carDamageCostApplyMapper.getById(detailId);
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.ZSFYSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.ZSCRKSQD ).equals( processId.toString() ) ){//折损出入库申请单
				CarDamageStockInOut bean = carDamageStockInOutMapper.getById(detailId);
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.ZSCRKSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.PCZLSQD ).equals( processId.toString() ) ){//派车指令申请单
				SendCarCommand bean = sendCarCommandMapper.getById(detailId);
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.PCZLSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.FYSQD ).equals( processId.toString() ) ){//费用申请单
				CostApply bean = costApplyService.getById(detailId);
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.FYSQD );
				
			}else if( commonService.getProcessId(0,  Constants.ProcessType.HXFYSQD ).equals( processId.toString() ) ){//核销费用申请单
				CostApplyReturn bean = costApplyReturnService.getById(detailId);
				result.put("detail", bean);
				result.put("businessType", Constants.ProcessType.HXFYSQD );
				
			}
			
		}else{
			result.put("detail", item);
			result.put("businessType", Constants.ProcessType.BGFYSQD );//办公费用申请
			
		}
			
		return result;
	}

	@Override
	@SystemServiceLog(description="保存待办任务的审核结果")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void audit(String taskId, String operId, String mark, String successFlag,String attachFileName, String attachFilePath , Map<String, Object> params, HttpServletRequest req) throws Exception {
		if( StringUtils.isEmpty(taskId) ){
			throw new RuntimeException("待办任务编号为空");
		}
		
		Task task = taskMapper.getById( Integer.parseInt(taskId) );
		if( null == task ){
			throw new RuntimeException("待办任务信息不存在");
		}
		
		Integer itemId = task.getItemId();
		Item item = itemMapper.getById(itemId);
		if( null == item ){
			throw new RuntimeException("待办任务对应的项目信息不存在");
		}
		
		//记录历史操作日志
		TaskHistory log = new TaskHistory();
		log.setItemId( itemId );
		log.setOperateTime( new Date() );
		log.setOperateUserId( operId );
		int currProcessDetailId = task.getProcessDetailId();//当前流程步骤主键
		log.setProcessDetailId( currProcessDetailId );
		log.setMark(mark);
		//附件处理
		if( StringUtils.isNotEmpty(attachFileName) ){
			String newFilePath = commonService.reStoreFile( Constants.UploadType.TASK, attachFilePath , req);
			log.setAttachFilePath( newFilePath );
			log.setAttachFileName(attachFileName);
		}
		log.setSuccessFlag(successFlag);
		taskHistoryMapper.insert(log);
		
		//删除我的待办
		task.setDelFlag(Constants.DelFlag.Y);
		taskMapper.updateBySelective(task);
		
		//业务表状态更新
		commonService.updateProcessStatus(successFlag, currProcessDetailId, itemId, Integer.parseInt(operId), params);
		
	}

	@Override
	@SystemServiceLog(description="保存任务信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(Task bean, String operId) throws Exception {
		
		Integer id = bean.getId();
		if( null == id ){
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			taskMapper.insert(bean);
			
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			taskMapper.updateBySelective(bean);
			
		}
		
	}

	@Override
	@SystemServiceLog(description="查询任务基本信息")
	public Task getById(Integer id) throws Exception {
		return taskMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除任务信息")
	public void delete(Integer id, String operId) throws Exception {
		Task bean = taskMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		taskMapper.updateBySelective(bean);
	}

	@Override
	@SystemServiceLog(description="查询项目分页信息")
	public Pager<Item> getPageDataForItem(Map<String, Object> params)  throws Exception{
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
			
		}
		
		List<Item> list = itemMapper.getPageList(params);
		int totalCount = itemMapper.getPageTotalCount(params);
		
		Pager<Item> pager = new Pager<Item>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存项目信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void saveForItem(Item bean, int operId)  throws Exception{
		Integer id = bean.getId();
		if( null == id ){
			bean.setStatus(Constants.ItemStatus.NEW);
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId+"");
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId+"");
			bean.setApplyUserId(operId);
			itemMapper.insert(bean);
			
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId+"");
			itemMapper.updateBySelective(bean);
			
		}
		
	}

	@Override
	@SystemServiceLog(description="删除项目信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void deleteForItem(int itemId, int operId)  throws Exception{
		Item bean = itemMapper.getById(itemId);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime( new Date() );
		bean.setUpdateUser(operId+"");
		bean.setDelFlag(Constants.DelFlag.Y);
		itemMapper.updateBySelective(bean);
		
	}

	@Override
	@SystemServiceLog(description="提交项目信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submitForItem(int itemId, int operId) throws Exception {
		Item bean = itemMapper.getById(itemId);
		bean.setApplyTime(new Date());
		bean.setUpdateTime( new Date() );
		bean.setUpdateUser(operId+"");
		bean.setStatus(Constants.OfficeApply.SUBMIT);
		itemMapper.updateBySelective(bean);
		
		//添加流程
		commonService.createNextProcess(itemId, operId);
		
	}

	@Override
	public ProcessDetail getProcessDetailInfo(Integer processDetailId)
			throws Exception {
		
//		ProcessDetail pd = processDetailMapper.getById(processDetailId);
//		int currProcessDetailId = pd.getId();
//		
//		Integer processId = pd.getProcessId();
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("processId", processId);
//		List<ProcessDetail> list = processDetailMapper.getByConditions(params);
//		if( null != list && list.size() > 0 ){
//			for(int i=0; i<list.size(); i++){
//				ProcessDetail detail = list.get(i);
//				if( currProcessDetailId == detail.getId() && i != list.size() -1  ){
//					
//					return list.get(i+1);
//				}
//			}
//		}
		
		return processDetailMapper.getById(processDetailId);
	}

	@Override
	@SystemServiceLog(description="查询已办事项列表信息")
	public Pager<TaskHistory> getPageDataForHasDo(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
			
		}
		
		List<TaskHistory> list = taskHistoryMapper.getPageList(params);
		if( null != list && list.size()> 0 ){
			for(int i=0; i<list.size(); i++){
//				TaskHistory taskHistory = list.get(i);
//				//提交人
//				String insertUserId = task.getInsertUser();
//				if( StringUtils.isNotEmpty(insertUserId) ){
//					User user = userMapper.getById( Integer.parseInt(insertUserId));
//					if( null != user ){
//						list.get(i).setInsertUserName( user.getName() );
//					}
//					
//				}
				
			}
		}
		int totalCount =  taskHistoryMapper.getPageTotalCount(params);
		
		Pager<TaskHistory> pager = new Pager<TaskHistory>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="导出办公费用信息")
	public Map<String, Object> getExportDataForItem(Map<String, Object> params)
			throws Exception {
		Map<String, Object> formatData = new HashMap<String, Object>();
		
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet1");
		formatData.put("sheetList", sheetList);
		
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "办公费用数据");
		sheetData.put("titleMergeSize", 8);
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("部门");
		tableHeadList.add("申请类型");
		tableHeadList.add("申请人");
		tableHeadList.add("申请时间");
		tableHeadList.add("申请金额");
		tableHeadList.add("预付金额");
		tableHeadList.add("项目描述");
		sheetData.put("tableHeader", tableHeadList);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<List<String>> tableData = new ArrayList<List<String>>();
		
		params.put("systemFlag", Constants.SystemFlag.N);//item表中只取非系统标记
		List<Item>  itemList = itemMapper.getByConditions(params);
		if(null != itemList && itemList.size() > 0)
		{
			for(int i = 0;i<itemList.size();i++)
			{
				List<String> rowData = new ArrayList<String>();
				rowData.add(String.valueOf(i+1));
				if(null != itemList.get(i).getDepName() && !"".equals(itemList.get(i).getDepName()))
				{
					rowData.add(itemList.get(i).getDepName());
				}
				else
				{
					rowData.add("");
				}
				if(null != itemList.get(i).getTypeName() && !"".equals(itemList.get(i).getTypeName()))
				{
					rowData.add(itemList.get(i).getTypeName());
				}
				else
				{
					rowData.add("");
				}
				if(null != itemList.get(i).getApplyUserName() && !"".equals(itemList.get(i).getApplyUserName()))
				{
					rowData.add(itemList.get(i).getApplyUserName());
				}
				else
				{
					rowData.add("");
				}
				if(null != itemList.get(i).getApplyTime() && !"".equals(itemList.get(i).getApplyTime()))
				{
					rowData.add(sdf.format(itemList.get(i).getApplyTime()));
				}
				else
				{
					rowData.add("");
				}
				if(null != itemList.get(i).getAmount() && !"".equals(itemList.get(i).getAmount()))
				{
					rowData.add(String.valueOf(itemList.get(i).getAmount()));
				}
				else
				{
					rowData.add("0");
				}
				if(null != itemList.get(i).getCashAdvance() && !"".equals(itemList.get(i).getCashAdvance()))
				{
					rowData.add(String.valueOf(itemList.get(i).getCashAdvance()));
				}
				else
				{
					rowData.add("0");
				}
				if(null != itemList.get(i).getItemName() && !"".equals(itemList.get(i).getItemName()))
				{
					rowData.add(itemList.get(i).getItemName());
				}
				else
				{
					rowData.add("");
				}
				tableData.add(rowData);
				//rowData.clear();
			}
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		return formatData;
	}

	@Override
	@SystemServiceLog(description="得到办公费用信息")
	public List<Item> getListForItem(Map<String, Object> params)
			throws Exception {
		params.put("systemFlag", Constants.SystemFlag.N);//item表中只取非系统标记
		return itemMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="办公申请审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Integer id, String status, String oper, Map<String, Object> params)
			throws Exception {
		Item bean = itemMapper.getById(id);
		bean.setApplyTime(new Date());
		bean.setUpdateTime( new Date() );
		bean.setUpdateUser(oper+"");
		bean.setStatus(Constants.OfficeApply.SUBMIT);
		if( null != params.get("prepareMoney") && StringUtils.isNotEmpty( params.get("prepareMoney").toString() )){
			bean.setCashAdvance( new BigDecimal( Double.parseDouble( params.get("prepareMoney").toString() ) ) );
		}
		itemMapper.updateBySelective(bean);
		
	}

	@Override
	@SystemServiceLog(description="办公申请审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Integer id, String status, String oper)
			throws Exception {
		Item bean = itemMapper.getById(id);
		bean.setApplyTime(new Date());
		bean.setUpdateTime( new Date() );
		bean.setUpdateUser(oper+"");
		bean.setStatus(status);
		itemMapper.updateBySelective(bean);
		
	}

	@Override
	@SystemServiceLog(description="办公申请审核更新")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditForConfirm(Integer id, String status, String oper,Map<String, Object> params)
			throws Exception {
		Item bean = itemMapper.getById(id);
		bean.setApplyTime(new Date());
		bean.setUpdateTime( new Date() );
		bean.setUpdateUser(oper+"");
		bean.setStatus(status);
		if( null != params.get("prepareMoney") && StringUtils.isNotEmpty( params.get("prepareMoney").toString() )){
			bean.setCashAdvance( new BigDecimal( Double.parseDouble( params.get("prepareMoney").toString() ) ) );
		}
		itemMapper.updateBySelective(bean);
		
	}
	
	@Override
	@SystemServiceLog(description="获取运单、调度单的流程历史操作信息")
	public Map<String, Object> getDetailInfoDetailId(Map<String, Object> paramsItem) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		int ProcessId=0 ;
		paramsItem.get("detailId");
		String type=(String) paramsItem.get("type");
		if("WD".equals(type)){
			Waybill detail = waybillMapper.getById( Integer.parseInt(paramsItem.get("detailId").toString() ));
			ProcessId=Integer.valueOf(commonService.getProcessId(detail.getStockId(), Constants.ProcessType.YD )).intValue() ;
		}else{
			ScheduleBill detail = scheduleBillMapper.getById( Integer.parseInt(paramsItem.get("detailId").toString() ));
			ProcessId=Integer.valueOf(commonService.getProcessId(detail.getStockId(), Constants.ProcessType.DDD )).intValue() ;	
		}
		//System.out.println(ProcessId);
		//System.out.println((int)detailId);				
		//paramsItem.put("detailId", detailId);
		paramsItem.put("ProcessId", ProcessId);
		Item item = itemMapper.getBydetilId(paramsItem);
		//其中，申请人信息
		Integer applyUserId = item.getApplyUserId();
		if( null != applyUserId ){
			User user = userMapper.getById( applyUserId );
			if( null != user ){
				item.setApplyUserName( user.getName() );
			}
			
		}
		//流程名称
		ProcessInfo p = processMapper.getById(item.getProcessId());
		ItemType it = itemTypeMapper.getById(p.getItemTypeId());
		item.setProcessName(it.getName());
		result.put("item", item);
		
		//查询操作日志信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("itemId", item.getId()+"");
		List<TaskHistory> logList = taskHistoryMapper.getByConditions(params);
		if( null != logList && logList.size() > 0 ){
			for(int i=0; i<logList.size(); i++){
				TaskHistory log = logList.get(i);
				//操作人信息
				String operateUserId = log.getOperateUserId();
				if( StringUtils.isNotEmpty(operateUserId) ){
					User user = userMapper.getById( Integer.parseInt(operateUserId));
					if( null != user ){
						logList.get(i).setOperateUserName( user.getName() );
					}
					
				}
				//流程步骤信息
				Integer processDetailId = log.getProcessDetailId();
				if( null != processDetailId ){
					ProcessDetail pd = processDetailMapper.getById(processDetailId);
					if( null != pd ){
						logList.get(i).setProcessDetailName( pd.getName() );
					}
					
				}
				
			}
		}
		result.put("logList", logList);
		
		
		return result;
	}

	@Override
	public void cancelTask(Integer taskId) throws Exception {
		Task task = taskMapper.getById(taskId);
		if( null != task ){
			task.setReceiveUserId("");
			task.setDelFlag(Constants.DelFlag.Y);
			taskMapper.updateBySelective(task);
			
		}
	}

}
