package com.jshpsoft.serviceImpl.common;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.socket.TextMessage;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.BasicConfigMapper;
import com.jshpsoft.dao.CarAttachmentStockMapper;
import com.jshpsoft.dao.CarDamageFeedbackMapper;
import com.jshpsoft.dao.CarShopMapper;
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.CommonMapper;
import com.jshpsoft.dao.CostApplyMapper;
import com.jshpsoft.dao.CostApplyReturnMapper;
import com.jshpsoft.dao.DepartmentMapper;
import com.jshpsoft.dao.DicPyMapper;
import com.jshpsoft.dao.DicWbMapper;
import com.jshpsoft.dao.ItemMapper;
import com.jshpsoft.dao.MessageMapper;
import com.jshpsoft.dao.OutSourcingMapper;
import com.jshpsoft.dao.ProcessDetailMapper;
import com.jshpsoft.dao.ProcessMapper;
import com.jshpsoft.dao.ScheduleBillDetailMapper;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.ScheduleTrackChangeApplyMapper;
import com.jshpsoft.dao.StockMapper;
import com.jshpsoft.dao.SupplierMapper;
import com.jshpsoft.dao.TaskHistoryMapper;
import com.jshpsoft.dao.TaskMapper;
import com.jshpsoft.dao.TransportCostApplyMapper;
import com.jshpsoft.dao.TransportPrepayApplyMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.domain.BasicConfig;
import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.CarDamageFeedback;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.CostApply;
import com.jshpsoft.domain.CostApplyReturn;
import com.jshpsoft.domain.Department;
import com.jshpsoft.domain.DicPy;
import com.jshpsoft.domain.DicWb;
import com.jshpsoft.domain.Item;
import com.jshpsoft.domain.Menu;
import com.jshpsoft.domain.Message;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.ProcessDetail;
import com.jshpsoft.domain.ProcessInfo;
import com.jshpsoft.domain.ReportForSchedulebill;
import com.jshpsoft.domain.ReportForWaybill;
import com.jshpsoft.domain.Role;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.Stock;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.Task;
import com.jshpsoft.domain.TaskHistory;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TrackTyreInOut;
import com.jshpsoft.domain.TransportCostApply;
import com.jshpsoft.domain.TransportCostCashDetailLog;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarDamageCostMngService;
import com.jshpsoft.service.CarDamageFeedbackMngService;
import com.jshpsoft.service.CarDamageStockInOutService;
import com.jshpsoft.service.CostApplyReturnService;
import com.jshpsoft.service.CostApplyService;
import com.jshpsoft.service.IncomeMngService;
import com.jshpsoft.service.MessageService;
import com.jshpsoft.service.ScheduleMngService;
import com.jshpsoft.service.SendCarCommandService;
import com.jshpsoft.service.TaskService;
import com.jshpsoft.service.TrackChangeMngService;
import com.jshpsoft.service.TrackMaintMngService;
import com.jshpsoft.service.TrackTyreBuyApplyService;
import com.jshpsoft.service.TrackTyreChangeMngService;
import com.jshpsoft.service.TrackTyreInOutMngService;
import com.jshpsoft.service.TrackTyreRuService;
import com.jshpsoft.service.TransportCostMngService;
import com.jshpsoft.service.TransportPrepayMngService;
import com.jshpsoft.service.WaybillManageService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.JPushUtils;
import com.jshpsoft.util.Pager;
import com.jshpsoft.websocket.SystemWebSocketHandler;

/**
 * 一些公共serviceimpl
* @author  fengql 
* @date 2016年9月26日 上午11:13:15
 */
@Service("commonService")
public class CommonServiceImpl implements CommonService {
	
	@Autowired
	private CommonMapper commonMapper;

	@Autowired
	private ItemMapper itemMapper;
	
	@Autowired
	private ProcessMapper processMapper;
	
	@Autowired
	private ProcessDetailMapper processDetailMapper;
	
	@Autowired
	private TaskHistoryMapper taskHistoryMapper;
	
	@Autowired
	private TaskMapper taskMapper;
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private ScheduleBillDetailMapper scheduleBillDetailMapper;
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private CarStockMapper carStockMapper;
	
	@Autowired
	private CarAttachmentStockMapper carAttachmentMngMapper;
	
	@Autowired
	private ScheduleTrackChangeApplyMapper scheduleTrackChangeApplyMapper;
	
	@Autowired
	private WaybillManageService waybillManageService;
	
	@Autowired
	private ScheduleMngService scheduleMngService;
	
	@Autowired
	private MessageMapper messageMapper;
	
	@Autowired
	private TrackChangeMngService trackChangeMngService;
	
	@Autowired
	private BasicConfigMapper basicConfigMapper;
	
	@Autowired
	private TransportPrepayApplyMapper transportPrepayApplyMapper;
	
	@Autowired
	private TransportPrepayMngService transportPrepayMngService;
	
	@Autowired
	private TrackMaintMngService trackMaintMngService;
	
	@Autowired
	private TrackTyreRuService trackTyreRuService;
	
	@Autowired
	private TrackTyreInOutMngService trackTyreInOutMngService;
	
	@Autowired
	private TransportCostMngService transportCostMngService;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private CashInOutMapper cashInOutMapper;
	
	@Autowired
	private TrackTyreChangeMngService trackTyreChangeMngService;
	
	@Autowired
	private CarDamageFeedbackMngService carDamageFeedbackMngService;
	
	@Autowired
	private CarDamageFeedbackMapper carDamageFeedbackMapper;
	
	@Autowired
	private CarDamageCostMngService carDamageCostMngService;
	
	@Autowired
	private CarDamageStockInOutService carDamageStockInOutService;
	
	@Autowired
	private SendCarCommandService sendCarCommandService;
	
	@Autowired
	private CostApplyService costApplyService;
	
	@Autowired
	private CostApplyReturnService costApplyReturnService;
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	private CostApplyMapper costApplyMapper;
	
	@Autowired
	private CostApplyReturnMapper costApplyReturnMapper;
	
	@Autowired
	private StockMapper stockMapper;
	
	@Autowired
	private DicPyMapper dicPyMapper;
	
	@Autowired
	private DicWbMapper dicWbMapper;
	
	@Autowired
	private CarShopMapper carShopMapper;
	
	@Autowired
	private OutSourcingMapper outSourcingMapper;
	
	@Autowired
	private SupplierMapper supplierMapper;
	
	@Autowired
	private TrackTyreBuyApplyService trackTyreBuyApplyService;
	
	@Autowired
	private IncomeMngService incomeMngService;
	
	@Autowired
	private TransportCostApplyMapper transportCostApplyMapper;
	
	@Autowired
	private CommonService commonService;
	
	private static SystemWebSocketHandler systemWebSocketHandler;
	
	static{
		systemWebSocketHandler = new SystemWebSocketHandler();
    }
	
	@Override
	@SystemServiceLog(description="获取所有的部门信息")
	public List<Department> getDepartmentList(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return commonMapper.getDepartmentList(params);
	}

	@Override
	@SystemServiceLog(description="获取所有的仓库信息")
	public List<Stock> getStockList(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return commonMapper.getStockList(params);
	}

	@Override
	@SystemServiceLog(description="获取所有的角色信息")
	public List<Role> getRoleList() throws Exception {
		//params.put("delFlag", Constants.DelFlag.N);
		return commonMapper.getRoleList();
	}

	@Override
	public List<Supplier> getBasicSuppliersList(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return commonMapper.getBasicSuppliersList(params);
	}

	@Override
	public List<CarBrand> getCarBrandList(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return commonMapper.getCarBrandList(params);
	}

	@Override
	public List<CarShop> getCarShopList(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return commonMapper.getCarShopList(params);
	}

	@Override
	@SystemServiceLog(description="获取所有的菜单信息")
	public List<Menu> getMenuList() throws Exception {
		
		return commonMapper.getMenuList();
	}
	
	@Override
	@SystemServiceLog(description="获取所有的外协单位信息")
	public List<OutSourcing> getOutSourcingList(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return commonMapper.getOutSourcingList(params);
	}

	@Override
	public List<Track> getTrackList(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		List<Track> list = commonMapper.getTrackList(params);
		
		//获取调度单中的车辆信息-1，2，3，4
		params = new HashMap<String, Object>();
		params.put("delFlag", Constants.DelFlag.N);
		params.put("statusIn", Constants.ScheduleBillStatus.UNSURE+","+Constants.ScheduleBillStatus.UNSURE_DRIVER+","+Constants.ScheduleBillStatus.ONWAY);
		List<ScheduleBill> schList = scheduleBillMapper.getByConditions(params);
		
		//获取运输车辆的状态
		for(int i=0;i<list.size();i++){
			
			list.get(i).setStatus("空闲");
			for(int j=0;j<schList.size();j++){
				if(list.get(i).getNo().equals(schList.get(j).getCarNumber())){
					if(schList.get(j).getStatus().equals(Constants.ScheduleBillStatus.ONWAY)){
						list.get(i).setStatus("在途");
					}else{
						list.get(i).setStatus("待装车");
					}
					break;
				}
			}
			
		}
		
		return list;
	}

	@Override
	@SystemServiceLog(description="添加业务申请到流程中")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void addToProcess(String type, int detailId, int operId, String itemName) throws Exception {
		
		String processId = "";
		try{
			//仓库id-运单、调度单有用
			int stockId = 0;
			User user = userMapper.getById( operId );
			if( null != user ){
				if( StringUtils.isNotEmpty(user.getStockId()) ){
					stockId = Integer.parseInt(user.getStockId());
				}
			}
			processId = getProcessId( stockId, type );
			
		}catch(Exception e){
			throw new RuntimeException("配置文件中的流程id获取失败");
		}
		
		ProcessInfo process = processMapper.getById( Integer.parseInt(processId) );
		if( null == process ||  Constants.DelFlag.Y.equals(process.getDelFlag()) ){
			throw new RuntimeException("流程id对应的数据不存在或已删除");
		}
		
		//生成项目记录
		Item item = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("detailId", detailId);
		params.put("processId", processId);
		List<Item> items = itemMapper.getByConditions(params);
		if( null != items && items.size() > 0 ){
			item = items.get(0);
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.updateBySelective( item );
			
			//删除当前的待办任务
			params = new HashMap<String, Object>();
			params.put("itemId", item.getId());
			params.put("userId", operId);
			params.put("delFlag", Constants.DelFlag.N);
			List<Task> tasks = taskMapper.getByConditions(params);
			if( null != tasks && tasks.size() > 0 ){
				for(int i=0; i<tasks.size(); i++){
					Task task = tasks.get(i);
					task.setDelFlag(Constants.DelFlag.Y);
					task.setUpdateUser(operId+"");
					task.setUpdateTime(new Date());
					taskMapper.updateBySelective(task);
					
				}
			}
			
		}else{
			item = new Item();
			item.setBusinessType( type );
			item.setDetailId( detailId );
			item.setItemName( itemName );
			item.setProcessId( Integer.parseInt(processId) );
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setApplyTime( new Date() );
			item.setApplyUserId( operId );
			item.setDelFlag( Constants.DelFlag.N );
			item.setInsertTime( new Date() );
			item.setInsertUser( operId+"" );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.insert( item );
		}
		
		//插入操作日志和下步待办
		createNextProcess( item.getId(), operId );
		
	}
	
	@Override
	@SystemServiceLog(description="添加业务申请到流程中-快速调度无流程")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void addToProcessForFastSchedule(String type, int detailId, int operId, String itemName) throws Exception {
		
		String processId = "";
		try{
			//仓库id-运单、调度单有用
			int stockId = 0;
			User user = userMapper.getById( operId );
			if( null != user ){
				if( StringUtils.isNotEmpty(user.getStockId()) ){
					stockId = Integer.parseInt(user.getStockId());
				}
			}
			processId = getProcessId( stockId, type );
			
		}catch(Exception e){
			throw new RuntimeException("配置文件中的流程id获取失败");
		}
		
		ProcessInfo process = processMapper.getById( Integer.parseInt(processId) );
		if( null == process ||  Constants.DelFlag.Y.equals(process.getDelFlag()) ){
			throw new RuntimeException("流程id对应的数据不存在或已删除");
		}
		
		//生成项目记录
		Item item = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("detailId", detailId);
		params.put("processId", processId);
		List<Item> items = itemMapper.getByConditions(params);
		if( null != items && items.size() > 0 ){
			item = items.get(0);
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.updateBySelective( item );
			
			//删除当前的待办任务
			params = new HashMap<String, Object>();
			params.put("itemId", item.getId());
			params.put("userId", operId);
			params.put("delFlag", Constants.DelFlag.N);
			List<Task> tasks = taskMapper.getByConditions(params);
			if( null != tasks && tasks.size() > 0 ){
				for(int i=0; i<tasks.size(); i++){
					Task task = tasks.get(i);
					task.setDelFlag(Constants.DelFlag.Y);
					task.setUpdateUser(operId+"");
					task.setUpdateTime(new Date());
					taskMapper.updateBySelective(task);
					
				}
			}
			
		}else{
			item = new Item();
			item.setBusinessType( type );
			item.setDetailId( detailId );
			item.setItemName( itemName );
			item.setProcessId( Integer.parseInt(processId) );
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setApplyTime( new Date() );
			item.setApplyUserId( operId );
			item.setDelFlag( Constants.DelFlag.N );
			item.setInsertTime( new Date() );
			item.setInsertUser( operId+"" );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.insert( item );
		}
		
		//插入操作日志和下步待办
		createNextProcessForFastSchedule( item.getId(), operId );
		
	}
	
	@Override
	@SystemServiceLog(description="添加业务申请到流程中")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void addToProcessForPCZL(String type, int detailId, int operId, String itemName, int receiveUserId) throws Exception {
		
		String processId = "";
		try{
			processId = getProcessId(0, type );
		}catch(Exception e){
			throw new RuntimeException("配置文件中的流程id获取失败");
		}
		
		ProcessInfo process = processMapper.getById( Integer.parseInt(processId) );
		if( null == process ||  Constants.DelFlag.Y.equals(process.getDelFlag()) ){
			throw new RuntimeException("流程id对应的数据不存在或已删除");
		}
		
		//生成项目记录
		Item item = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("detailId", detailId);
		params.put("processId", processId);
		List<Item> items = itemMapper.getByConditions(params);
		if( null != items && items.size() > 0 ){
			item = items.get(0);
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.updateBySelective( item );
			
			//删除当前的待办任务
			params = new HashMap<String, Object>();
			params.put("itemId", item.getId());
			params.put("userId", operId);
			params.put("delFlag", Constants.DelFlag.N);
			List<Task> tasks = taskMapper.getByConditions(params);
			if( null != tasks && tasks.size() > 0 ){
				for(int i=0; i<tasks.size(); i++){
					Task task = tasks.get(i);
					task.setDelFlag(Constants.DelFlag.Y);
					task.setUpdateUser(operId+"");
					task.setUpdateTime(new Date());
					taskMapper.updateBySelective(task);
					
				}
			}
			
		}else{
			item = new Item();
			item.setBusinessType(type);
			item.setDetailId( detailId );
			item.setItemName( itemName );
			item.setProcessId( Integer.parseInt(processId) );
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setApplyTime( new Date() );
			item.setApplyUserId( operId );
			item.setDelFlag( Constants.DelFlag.N );
			item.setInsertTime( new Date() );
			item.setInsertUser( operId+"" );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.insert( item );
		}
		
		//插入操作日志和下步待办
		createNextProcessForPCZL( item.getId(), operId , receiveUserId);
		
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void addToProcessForZyyfsqd(String type, int detailId, int operId, String itemName, ScheduleBill sb) throws Exception {
		
		String processId = "";
		try{
			processId = getProcessId(0, type );
		}catch(Exception e){
			throw new RuntimeException("配置文件中的流程id获取失败");
		}
		
		ProcessInfo process = processMapper.getById( Integer.parseInt(processId) );
		if( null == process ||  Constants.DelFlag.Y.equals(process.getDelFlag()) ){
			throw new RuntimeException("流程id对应的数据不存在或已删除");
		}
		
		//生成项目记录
		Item item = new Item();
		item.setBusinessType(type);
		item.setDetailId( detailId );
		item.setItemName( itemName );
		item.setProcessId( Integer.parseInt(processId) );
		item.setStatus( Constants.ItemStatus.PROCESSING );
		item.setApplyTime( new Date() );
		item.setApplyUserId( operId );
		item.setDelFlag( Constants.DelFlag.N );
		item.setInsertTime( new Date() );
		item.setInsertUser( sb.getInsertUser()+"" );//调度单创建人
		item.setUpdateTime( new Date() );
		item.setUpdateUser( sb.getInsertUser()+"" );//调度单创建人
		itemMapper.insert( item );
		
		
		//获取当前流程的所有的流程步骤
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processId", processId );
		params.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions( params );
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
		
		//生成新建的操作日志记录
		TaskHistory log = new TaskHistory();
		log.setItemId( item.getId() );
		log.setOperateTime( new Date() );
		log.setOperateUserId( sb.getInsertUser() + "" );
		log.setProcessDetailId( processDetailList.get(0).getId() );//流程第一个步骤
		log.setMark("新建");
		log.setSuccessFlag("Y");
		taskHistoryMapper.insert( log );
		
		//插入创建人提交预付的操作日志和预付下步待办
		if( processDetailList.size() > 1 ){
			//生成下一个流程步骤对应的代办记录
			Task nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(1).getId() );
			String receiveUserId = processDetailList.get(1).getOperateUserId();
			nextTask.setReceiveUserId( receiveUserId );
			nextTask.setItemId( item.getId() );
			nextTask.setDelFlag( Constants.DelFlag.N );
			nextTask.setInsertTime( new Date() );
			nextTask.setInsertUser( sb.getInsertUser() + "" );
			nextTask.setUpdateTime( new Date() );
			nextTask.setUpdateUser( sb.getInsertUser() + "" );
			taskMapper.insert( nextTask );
			
			//推送消息：
			String statusStr = "";
			if( Constants.ItemStatus.NEW.equals(item.getStatus()) ){
				statusStr = "新建";
			}else if( Constants.ItemStatus.PROCESSING.equals(item.getStatus()) ){
				statusStr = "流转中";
			}else if( Constants.ItemStatus.FINISHED.equals(item.getStatus()) ){
				statusStr = "已完成";
			}
			String content = "新消息：" + item.getItemName() + "[状态："+ statusStr +"]";
			pushMsgToUser( Integer.parseInt(receiveUserId), content );
			
		}
		
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void addToProcessForZSFYSQ(String type, int detailId, int operId, String itemName) throws Exception {
		
		String processId = "";
		try{
			processId = getProcessId(0, type );
		}catch(Exception e){
			throw new RuntimeException("配置文件中的流程id获取失败");
		}
		
		ProcessInfo process = processMapper.getById( Integer.parseInt(processId) );
		if( null == process ||  Constants.DelFlag.Y.equals(process.getDelFlag()) ){
			throw new RuntimeException("流程id对应的数据不存在或已删除");
		}
		
		//生成项目记录
		Item item = new Item();
		item.setBusinessType(type);
		item.setDetailId( detailId );
		item.setItemName( itemName );
		item.setProcessId( Integer.parseInt(processId) );
		item.setStatus( Constants.ItemStatus.PROCESSING );
		item.setApplyTime( new Date() );
		item.setApplyUserId( operId );
		item.setDelFlag( Constants.DelFlag.N );
		item.setInsertTime( new Date() );
		item.setInsertUser( operId+"" );//创建人
		item.setUpdateTime( new Date() );
		item.setUpdateUser( operId+"" );//创建人
		itemMapper.insert( item );
		
		//获取当前流程的所有的流程步骤
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processId", processId );
		params.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions( params );
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
		
		//获取流程第一步的起始节点，作为新建的第一个节点
		int currIndex = 0;
		for(int i=0; i<processDetailList.size(); i++){
			ProcessDetail processDetail = processDetailList.get(i);
			String operUserId = processDetail.getOperateUserId();
			if( StringUtils.isNotEmpty( operUserId ) && operId == Integer.parseInt(operUserId) ){
				currIndex = i;
				break;
			}
		}
		//生成新建的操作日志记录
		TaskHistory log = new TaskHistory();
		log.setItemId( item.getId() );
		log.setOperateTime( new Date() );
		log.setOperateUserId( operId + "" );
		log.setProcessDetailId( processDetailList.get(currIndex).getId() );//流程第一个步骤
		log.setMark("新建");
		log.setSuccessFlag("Y");
		taskHistoryMapper.insert( log );
		
		//插入创建人提交的操作日志和下步待办
		if( processDetailList.size() > 1 ){
			//生成下一个流程步骤对应的代办记录
			Task nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(currIndex+1).getId() );
			String receiveUserId = processDetailList.get(currIndex+1).getOperateUserId();
			nextTask.setReceiveUserId( receiveUserId );
			nextTask.setItemId( item.getId() );
			nextTask.setDelFlag( Constants.DelFlag.N );
			nextTask.setInsertTime( new Date() );
			nextTask.setInsertUser( operId + "" );
			nextTask.setUpdateTime( new Date() );
			nextTask.setUpdateUser( operId + "" );
			taskMapper.insert( nextTask );
			
			if( Constants.ProcessType.ZSFKSQD.equals( type ) ){//折损反馈，更新状态为：下一步节点的orderNo
				CarDamageFeedback detail = carDamageFeedbackMapper.getById(detailId);
				detail.setStatus( (currIndex+1) + "");
				carDamageFeedbackMapper.update(detail);
			}
			
			//推送消息：
			String statusStr = "";
			if( Constants.ItemStatus.NEW.equals(item.getStatus()) ){
				statusStr = "新建";
			}else if( Constants.ItemStatus.PROCESSING.equals(item.getStatus()) ){
				statusStr = "流转中";
			}else if( Constants.ItemStatus.FINISHED.equals(item.getStatus()) ){
				statusStr = "已完成";
			}
			String content = "新消息：" + item.getItemName() + "[状态："+ statusStr +"]";
			pushMsgToUser( Integer.parseInt(receiveUserId), content );
			
		}
		
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void addToProcessForCostApply(String type, int detailId, int operId, String itemName) throws Exception {
		
		String processId = "";
		try{
			processId = getProcessId(0, type );
		}catch(Exception e){
			throw new RuntimeException("配置文件中的流程id获取失败");
		}
		
		ProcessInfo process = processMapper.getById( Integer.parseInt(processId) );
		if( null == process ||  Constants.DelFlag.Y.equals(process.getDelFlag()) ){
			throw new RuntimeException("流程id对应的数据不存在或已删除");
		}
		
		//生成项目记录
		Item item = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("detailId", detailId);
		params.put("processId", processId);
		List<Item> items = itemMapper.getByConditions(params);
		if( null != items && items.size() > 0 ){
			item = items.get(0);
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.updateBySelective( item );
			
			//删除当前的待办任务
			params = new HashMap<String, Object>();
			params.put("itemId", item.getId());
			params.put("userId", operId);
			params.put("delFlag", Constants.DelFlag.N);
			List<Task> tasks = taskMapper.getByConditions(params);
			if( null != tasks && tasks.size() > 0 ){
				for(int i=0; i<tasks.size(); i++){
					Task task = tasks.get(i);
					task.setDelFlag(Constants.DelFlag.Y);
					task.setUpdateUser(operId+"");
					task.setUpdateTime(new Date());
					taskMapper.updateBySelective(task);
					
				}
			}
			
		}else{
			item = new Item();
			item.setBusinessType( type );
			item.setDetailId( detailId );
			item.setItemName( itemName );
			item.setProcessId( Integer.parseInt(processId) );
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setApplyTime( new Date() );
			item.setApplyUserId( operId );
			item.setDelFlag( Constants.DelFlag.N );
			item.setInsertTime( new Date() );
			item.setInsertUser( operId+"" );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.insert( item );
		}
		
		//检查当前提交人是否是申请部门的负责人，如果不是，则提交给部门负责人（第二个节点），如果是，则提交给财务审核（第三个节点）
		CostApply detail = costApplyMapper.getById(detailId);
		if( null == detail.getDepartmentId() || 0 == detail.getDepartmentId() ){
			throw new RuntimeException("申请部门信息不能为空！");
		}
		Department department = departmentMapper.getById(detail.getDepartmentId());
		if( null == department ){
			throw new RuntimeException("申请部门对应的部门记录不存在！");
		}
		Integer leaderId = department.getLeaderId();
		if( null == leaderId || 0 == leaderId ){
			throw new RuntimeException("申请部门的负责人信息未设置！");
		}
		
		//获取当前流程的所有的流程步骤
		params = new HashMap<String, Object>();
		params.put("processId", processId );
		params.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions( params );
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
				
		String receiveUserId;//下一步接收人
		if( operId != leaderId.intValue() ){
			receiveUserId = leaderId.toString();
			//生成新建的操作日志记录
			TaskHistory log = new TaskHistory();
			log.setItemId( item.getId() );
			log.setOperateTime( new Date() );
			log.setOperateUserId( operId + "" );
			log.setProcessDetailId( processDetailList.get(0).getId() );
			log.setMark(processDetailList.get(0).getName());
			log.setSuccessFlag("Y");
			taskHistoryMapper.insert( log );
			
			//插入创建人提交的操作日志和下步待办
			if( processDetailList.size() > 1 ){
				//生成下一个流程步骤对应的代办记录
				Task nextTask = new Task();
				nextTask.setProcessDetailId( processDetailList.get(1).getId() );
				nextTask.setReceiveUserId( receiveUserId );
				nextTask.setItemId( item.getId() );
				nextTask.setDelFlag( Constants.DelFlag.N );
				nextTask.setInsertTime( new Date() );
				nextTask.setInsertUser( operId + "" );
				nextTask.setUpdateTime( new Date() );
				nextTask.setUpdateUser( operId + "" );
				taskMapper.insert( nextTask );
				
			}
			
		}else{
			receiveUserId =  processDetailList.get(2).getOperateUserId();
			
			//操作日志生成第二个节点的
			TaskHistory log = new TaskHistory();
			log.setItemId( item.getId() );
			log.setOperateTime( new Date() );
			log.setOperateUserId( operId + "" );
			log.setProcessDetailId( processDetailList.get(1).getId() );
			log.setMark( processDetailList.get(1).getName() );
			log.setSuccessFlag("Y");
			taskHistoryMapper.insert( log );
			
			//生成下一个流程步骤对应的代办记录
			Task nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(2).getId() );
			nextTask.setReceiveUserId( receiveUserId );
			nextTask.setItemId( item.getId() );
			nextTask.setDelFlag( Constants.DelFlag.N );
			nextTask.setInsertTime( new Date() );
			nextTask.setInsertUser( operId + "" );
			nextTask.setUpdateTime( new Date() );
			nextTask.setUpdateUser( operId + "" );
			taskMapper.insert( nextTask );
			
			//主表状态更新为第三个节点
			detail.setStatus( (processDetailList.get(2).getOrderNo()) + "");
			costApplyMapper.update(detail);
			
		}
		
		//推送消息：
		String statusStr = "";
		if( Constants.ItemStatus.NEW.equals(item.getStatus()) ){
			statusStr = "新建";
		}else if( Constants.ItemStatus.PROCESSING.equals(item.getStatus()) ){
			statusStr = "流转中";
		}else if( Constants.ItemStatus.FINISHED.equals(item.getStatus()) ){
			statusStr = "已完成";
		}
		String content = "新消息：" + item.getItemName() + "[状态："+ statusStr +"]";
		pushMsgToUser( Integer.parseInt(receiveUserId), content );
		
	}
	
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void addToProcessForCostApplyRetrun(String type, int detailId, int operId, String itemName) throws Exception {
		
		String processId = "";
		try{
			processId = getProcessId(0, type );
		}catch(Exception e){
			throw new RuntimeException("配置文件中的流程id获取失败");
		}
		
		ProcessInfo process = processMapper.getById( Integer.parseInt(processId) );
		if( null == process ||  Constants.DelFlag.Y.equals(process.getDelFlag()) ){
			throw new RuntimeException("流程id对应的数据不存在或已删除");
		}
		
		//生成项目记录
		Item item = null;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("detailId", detailId);
		params.put("processId", processId);
		List<Item> items = itemMapper.getByConditions(params);
		if( null != items && items.size() > 0 ){
			item = items.get(0);
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.updateBySelective( item );
			
			//删除当前的待办任务
			params = new HashMap<String, Object>();
			params.put("itemId", item.getId());
			params.put("userId", operId);
			params.put("delFlag", Constants.DelFlag.N);
			List<Task> tasks = taskMapper.getByConditions(params);
			if( null != tasks && tasks.size() > 0 ){
				for(int i=0; i<tasks.size(); i++){
					Task task = tasks.get(i);
					task.setDelFlag(Constants.DelFlag.Y);
					task.setUpdateUser(operId+"");
					task.setUpdateTime(new Date());
					taskMapper.updateBySelective(task);
					
				}
			}
			
		}else{
			item = new Item();
			item.setBusinessType( type );
			item.setDetailId( detailId );
			item.setItemName( itemName );
			item.setProcessId( Integer.parseInt(processId) );
			item.setStatus( Constants.ItemStatus.PROCESSING );
			item.setApplyTime( new Date() );
			item.setApplyUserId( operId );
			item.setDelFlag( Constants.DelFlag.N );
			item.setInsertTime( new Date() );
			item.setInsertUser( operId+"" );
			item.setUpdateTime( new Date() );
			item.setUpdateUser( operId+"" );
			itemMapper.insert( item );
		}
		
		//检查当前提交人是否是申请部门的负责人，如果不是，则提交给部门负责人（第二个节点），如果是，则提交给财务审核（第三个节点）
		CostApplyReturn detail = costApplyReturnService.getById(detailId);
		if( null == detail.getDepartmentId() || 0 == detail.getDepartmentId() ){
			throw new RuntimeException("申请部门信息不能为空！");
		}
		Department department = departmentMapper.getById(detail.getDepartmentId());
		if( null == department ){
			throw new RuntimeException("申请部门对应的部门记录不存在！");
		}
		Integer leaderId = department.getLeaderId();
		if( null == leaderId || 0 == leaderId ){
			throw new RuntimeException("申请部门的负责人信息未设置！");
		}
		
		//获取当前流程的所有的流程步骤
		params = new HashMap<String, Object>();
		params.put("processId", processId );
		params.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions( params );
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
		
		String receiveUserId;//下一步接收人
		if( operId != leaderId.intValue() ){
			receiveUserId = leaderId.toString();
			//生成新建的操作日志记录
			TaskHistory log = new TaskHistory();
			log.setItemId( item.getId() );
			log.setOperateTime( new Date() );
			log.setOperateUserId( operId + "" );
			log.setProcessDetailId( processDetailList.get(0).getId() );
			log.setMark(processDetailList.get(0).getName());
			log.setSuccessFlag("Y");
			taskHistoryMapper.insert( log );
			
			//插入创建人提交的操作日志和下步待办
			if( processDetailList.size() > 1 ){
				//生成下一个流程步骤对应的代办记录
				Task nextTask = new Task();
				nextTask.setProcessDetailId( processDetailList.get(1).getId() );
				nextTask.setReceiveUserId( receiveUserId );
				nextTask.setItemId( item.getId() );
				nextTask.setDelFlag( Constants.DelFlag.N );
				nextTask.setInsertTime( new Date() );
				nextTask.setInsertUser( operId + "" );
				nextTask.setUpdateTime( new Date() );
				nextTask.setUpdateUser( operId + "" );
				taskMapper.insert( nextTask );
				
			}
			
		}else{
			receiveUserId =  processDetailList.get(2).getOperateUserId();
			
			//操作日志生成第二个节点的
			TaskHistory log = new TaskHistory();
			log.setItemId( item.getId() );
			log.setOperateTime( new Date() );
			log.setOperateUserId( operId + "" );
			log.setProcessDetailId( processDetailList.get(1).getId() );
			log.setMark( processDetailList.get(1).getName() );
			log.setSuccessFlag("Y");
			taskHistoryMapper.insert( log );
			
			//生成下一个流程步骤对应的代办记录
			Task nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(2).getId() );
			nextTask.setReceiveUserId( receiveUserId );
			nextTask.setItemId( item.getId() );
			nextTask.setDelFlag( Constants.DelFlag.N );
			nextTask.setInsertTime( new Date() );
			nextTask.setInsertUser( operId + "" );
			nextTask.setUpdateTime( new Date() );
			nextTask.setUpdateUser( operId + "" );
			taskMapper.insert( nextTask );
			
			//主表状态更新为第三个节点
			detail.setStatus( (processDetailList.get(2).getOrderNo()) + "");
			costApplyReturnMapper.update(detail);
			
		}
		
		//推送消息：
		String statusStr = "";
		if( Constants.ItemStatus.NEW.equals(item.getStatus()) ){
			statusStr = "新建";
		}else if( Constants.ItemStatus.PROCESSING.equals(item.getStatus()) ){
			statusStr = "流转中";
		}else if( Constants.ItemStatus.FINISHED.equals(item.getStatus()) ){
			statusStr = "已完成";
		}
		String content = "新消息：" + item.getItemName() + "[状态："+ statusStr +"]";
		pushMsgToUser( Integer.parseInt(receiveUserId), content );
		
	}

	public void createNextProcess(Integer itemId, int operId
			) throws Exception {
		Item item = itemMapper.getById(itemId);
		int processId = item.getProcessId();
		
		//获取当前流程的所有的流程步骤
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processId", processId );
		params.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions( params );
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
		
		//生成新建的操作日志记录
		TaskHistory log = new TaskHistory();
		log.setItemId( itemId );
		log.setOperateTime( new Date() );
		log.setOperateUserId( operId + "" );
		log.setProcessDetailId( processDetailList.get(0).getId() );//流程第一个步骤
		log.setMark("新建");
		log.setSuccessFlag("Y");
		taskHistoryMapper.insert( log );
		
		if( processDetailList.size() > 1 ){
			//生成下一个流程步骤对应的代办记录
			Task nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(1).getId() );
			String receiveUserId = processDetailList.get(1).getOperateUserId();
			nextTask.setReceiveUserId( receiveUserId );
			nextTask.setItemId( itemId );
			nextTask.setDelFlag( Constants.DelFlag.N );
			nextTask.setInsertTime( new Date() );
			nextTask.setInsertUser( operId + "" );
			nextTask.setUpdateTime( new Date() );
			nextTask.setUpdateUser( operId + "" );
			taskMapper.insert( nextTask );
			
			//推送消息：
			String statusStr = "";
			if( Constants.ItemStatus.NEW.equals(item.getStatus()) ){
				statusStr = "新建";
			}else if( Constants.ItemStatus.PROCESSING.equals(item.getStatus()) ){
				statusStr = "流转中";
			}else if( Constants.ItemStatus.FINISHED.equals(item.getStatus()) ){
				statusStr = "已完成";
			}
			String content = "新消息：" + item.getItemName() + "[状态："+ statusStr +"]";
			pushMsgToUser( Integer.parseInt(receiveUserId), content );
			
		}
		
	}
	
	public void createNextProcessForFastSchedule(Integer itemId, int operId
			) throws Exception {
		Item item = itemMapper.getById(itemId);
		int processId = item.getProcessId();
		
		//获取当前流程的所有的流程步骤
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processId", processId );
		params.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions( params );
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
		
		//生成新建的操作日志记录
		TaskHistory log = new TaskHistory();
		log.setItemId( itemId );
		log.setOperateTime( new Date() );
		log.setOperateUserId( operId + "" );
		log.setProcessDetailId( processDetailList.get(0).getId() );//流程第一个步骤
		log.setMark("新建");
		log.setSuccessFlag("Y");
		taskHistoryMapper.insert( log );
		
		if( processDetailList.size() > 1 ){
			//生成下一个流程步骤对应的代办记录
			Task nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(1).getId() );
			String receiveUserId = processDetailList.get(1).getOperateUserId();
			nextTask.setReceiveUserId( receiveUserId );
			nextTask.setItemId( itemId );
			nextTask.setDelFlag( Constants.DelFlag.Y );
			nextTask.setInsertTime( new Date() );
			nextTask.setInsertUser( operId + "" );
			nextTask.setUpdateTime( new Date() );
			nextTask.setUpdateUser( operId + "" );
			taskMapper.insert( nextTask );
			
			//删除待办
			nextTask.setDelFlag(Constants.DelFlag.Y);
			taskMapper.updateBySelective(nextTask);
			
			//记录历史操作日志
			log = new TaskHistory();
			log.setItemId( itemId );
			log.setOperateTime( new Date() );
			log.setOperateUserId( operId+"" );
			int currProcessDetailId = nextTask.getProcessDetailId();//当前流程步骤主键
			log.setProcessDetailId( currProcessDetailId );
			log.setMark("");
			log.setSuccessFlag("Y");
			taskHistoryMapper.insert(log);
			
			//生成下一个流程步骤对应的代办记录:驾驶员
			nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(2).getId() );
			ScheduleBill sb = scheduleBillMapper.getById(item.getDetailId());
			receiveUserId = sb.getDriverId()+"";
			nextTask.setReceiveUserId( receiveUserId );
			nextTask.setItemId( itemId );
			nextTask.setDelFlag( Constants.DelFlag.N );
			nextTask.setInsertTime( new Date() );
			nextTask.setInsertUser( operId + "" );
			nextTask.setUpdateTime( new Date() );
			nextTask.setUpdateUser( operId + "" );
			taskMapper.insert( nextTask );
			
			//推送消息：
			String statusStr = "";
			if( Constants.ItemStatus.NEW.equals(item.getStatus()) ){
				statusStr = "新建";
			}else if( Constants.ItemStatus.PROCESSING.equals(item.getStatus()) ){
				statusStr = "流转中";
			}else if( Constants.ItemStatus.FINISHED.equals(item.getStatus()) ){
				statusStr = "已完成";
			}
			String content = "新消息：" + item.getItemName() + "[状态："+ statusStr +"]";
			pushMsgToUser( Integer.parseInt(receiveUserId), content );
		}
		
	}
	
	public void createNextProcessForPCZL(Integer itemId, int operId, int receiveUserId
			) throws Exception {
		Item item = itemMapper.getById(itemId);
		int processId = item.getProcessId();
		
		//获取当前流程的所有的流程步骤
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processId", processId );
		params.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions( params );
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
		
		//生成新建的操作日志记录
		TaskHistory log = new TaskHistory();
		log.setItemId( itemId );
		log.setOperateTime( new Date() );
		log.setOperateUserId( operId + "" );
		log.setProcessDetailId( processDetailList.get(0).getId() );//流程第一个步骤
		log.setMark("新建");
		log.setSuccessFlag("Y");
		taskHistoryMapper.insert( log );
		
		if( processDetailList.size() > 1 ){
			//生成下一个流程步骤对应的代办记录
			Task nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(1).getId() );
			nextTask.setReceiveUserId( receiveUserId+"" );
			nextTask.setItemId( itemId );
			nextTask.setDelFlag( Constants.DelFlag.N );
			nextTask.setInsertTime( new Date() );
			nextTask.setInsertUser( operId + "" );
			nextTask.setUpdateTime( new Date() );
			nextTask.setUpdateUser( operId + "" );
			taskMapper.insert( nextTask );
			
			//推送消息：
			String statusStr = "";
			if( Constants.ItemStatus.NEW.equals(item.getStatus()) ){
				statusStr = "新建";
			}else if( Constants.ItemStatus.PROCESSING.equals(item.getStatus()) ){
				statusStr = "流转中";
			}else if( Constants.ItemStatus.FINISHED.equals(item.getStatus()) ){
				statusStr = "已完成";
			}
			String content = "新消息：" + item.getItemName() + "[状态："+ statusStr +"]";
			pushMsgToUser( receiveUserId, content );
			
		}
		
	}

	@Override
	@SystemServiceLog(description="更新业务信息的流程状态")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateProcessStatus(String successFlag, int currProcessDetailId, Integer itemId, int operId, Map<String, Object> params) throws Exception {
		
		Item item = itemMapper.getById(itemId);
		int processId = item.getProcessId();
		Integer detailId = item.getDetailId();
		//仓库id-运单、调度单有用
		int stockId = 0;
		if( null != item.getApplyUserId() ){
			User user = userMapper.getById( item.getApplyUserId() );
			if( null != user ){
				item.setApplyUserName( user.getName() );
				if( StringUtils.isNotEmpty(user.getStockId()) ){
					stockId = Integer.parseInt(user.getStockId());
				}
			}
			
		}
		//所有的流程步骤
		Map<String, Object> paramsP = new HashMap<String, Object>();
		paramsP.put("processId", item.getProcessId() );
		paramsP.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions(paramsP);
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
		
		//获取当前流程的索引，获取上一个或下一个流程步骤
		int currIndex = 0;
		for(int i=0; i<processDetailList.size(); i++){
			ProcessDetail processDetail = processDetailList.get(i);
			Integer id = processDetail.getId();
			if( id == currProcessDetailId ){
				currIndex = i;
				break;
			}
		}
		
		int auditOperStartIndex = 0;
		int auditOperEndIndex = 0;
		for(int i=0; i<processDetailList.size(); i++){
			ProcessDetail processDetail = processDetailList.get(i);
			String type = processDetail.getType();
			if( Constants.ProcessDetailOperateType.AUDIT.equals( type ) ){//审核操作
				auditOperStartIndex = i;
				break;
			}
			
		}
		for(int i=0; i<processDetailList.size(); i++){
			ProcessDetail processDetail = processDetailList.get(i);
			String type = processDetail.getType();
			if( Constants.ProcessDetailOperateType.AUDIT.equals( type ) ){//审核操作
				auditOperEndIndex = i;
			}
			
		}
				
		//下一步操作人id
		String receiveUserId = "";
		//下一步状态
		int status = 0;
		if( getProcessId(stockId, Constants.ProcessType.YD ).equals( processId+"") ){//运单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
//				if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
				if( currIndex == processDetailList.size() - 2 ){//当前节点为倒数第二个节点（已完成节点的前一个节点）做通过操作时执行
					waybillManageService.auditSuccess(detailId, status, operId);
					
				}else{//执行-更新运单状态
					waybillManageService.auditForConfirm(detailId, status, operId);
					
				}
					
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				//执行-更新运单状态
				waybillManageService.auditFail(detailId, status, operId);
				
			}
			
		}else if( getProcessId(stockId,  Constants.ProcessType.DDD ).equals( processId+"" ) ){//调度单
			
			ScheduleBill sb = scheduleBillMapper.getById(detailId);
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
//				if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
//					scheduleMngService.auditSuccess(sb.getScheduleBillNo(), status+"", operId+"");
//					
//				}else{//执行-更新状态
//					scheduleMngService.auditForConfirm(detailId, status, operId);
//					
//					//如果调度单复核通过(第二个步骤)时，需要发起装运预付申请流程，并将任务提交到复核人手上
//					if( currIndex == 1 ){
//						Map<String, Object> prepayApplyParams = new HashMap<String, Object>();
//						prepayApplyParams.put("scheduleBillNo", sb.getScheduleBillNo());
//						prepayApplyParams.put("delFlag", Constants.DelFlag.N);
//						List<TransportPrepayApply> prepayApplyList = transportPrepayApplyMapper.getByConditions(prepayApplyParams);
//						if( null != prepayApplyList && prepayApplyList.size() > 0 ){
//							for(int j=0; j<prepayApplyList.size(); j++){
//								TransportPrepayApply prepayApply = prepayApplyList.get(j);
//								//添加到流程中-装运预付申请
//								this.addToProcessForZyyfsqd( 
//										Constants.ProcessType.ZYYFSQD, 
//										prepayApply.getId(), 
//										operId, 
//										CommonUtil.getProcessName(Constants.ProcessType.ZYYFSQD, CommonUtil.getCustomDateToString(prepayApply.getApplyTime(), Constants.DATE_TIME_FORMAT_SHORT) + "_" + sb.getCarNumber())
//										,sb);
//								
//							}
//							
//							
//						}
//						
//					}
//					
//				}
				//2016-12-06 调度流程：调度员-》仓管员确认-》驾驶员 ，状态：0-新建，1-待仓管员已确认，2-待驾驶员确认，3-在途，4-已完成
				if( currIndex == 1 ){
//					//如果调度单复核通过(第二个步骤)时，需要发起装运预付申请流程，并将任务提交到复核人手上
//					Map<String, Object> prepayApplyParams = new HashMap<String, Object>();
//					prepayApplyParams.put("scheduleBillNo", sb.getScheduleBillNo());
//					prepayApplyParams.put("delFlag", Constants.DelFlag.N);
//					List<TransportPrepayApply> prepayApplyList = transportPrepayApplyMapper.getByConditions(prepayApplyParams);
//					if( null != prepayApplyList && prepayApplyList.size() > 0 ){
//						for(int j=0; j<prepayApplyList.size(); j++){
//							//添加到流程中-装运预付申请
//							TransportPrepayApply prepayApply = prepayApplyList.get(j);
//							this.addToProcessForZyyfsqd( 
//								Constants.ProcessType.ZYYFSQD, 
//								prepayApply.getId(), 
//								operId, 
//								CommonUtil.getProcessName(Constants.ProcessType.ZYYFSQD, CommonUtil.getCustomDateToString(prepayApply.getApplyTime(), Constants.DATE_TIME_FORMAT_SHORT) + "_" + sb.getCarNumber()),
//								sb
//							);
//							
//						}
//						
//					}
				
					scheduleMngService.auditSuccess(sb.getScheduleBillNo(), status+"", operId+"");
					
				}else{
					scheduleMngService.auditForConfirm(detailId, status, operId);
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				scheduleMngService.auditFail(detailId, status, operId);
				
			}
			
			//如果是驾驶员确认步骤，则需要获取驾驶员id
			if( Constants.ScheduleBillStatus.UNSURE_DRIVER.equals( status+"" ) ){
				receiveUserId = sb.getDriverId() + "";
				
			}
			
		}else if( getProcessId( 0,Constants.ProcessType.HCSQD ).equals( processId+"" ) ){//换车申请单
			Map<String, Object> newParams = new HashMap<String, Object>();
			newParams.put("id", detailId);
			if( null != params.get("newCarNumber") && StringUtils.isNotEmpty( params.get("newCarNumber").toString() ) ){
				newParams.put("newCarNumber", params.get("newCarNumber"));
				
			}
			if( null != params.get("newDriverId") && StringUtils.isNotEmpty( params.get("newDriverId").toString() ) ){
				newParams.put("newDriverId", params.get("newDriverId"));
				
			}
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
				newParams.put("status", status);
				if( currIndex == processDetailList.size()-2 ){
					trackChangeMngService.auditSuccess(newParams, operId+"");
					
				}else{//执行-更新状态
					trackChangeMngService.auditForConfirm(newParams, operId+"");
					
				}
					
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				newParams.put("status", status);
				trackChangeMngService.auditFail(newParams, operId+"");
				
			}
			
			
		}else if( getProcessId(0, Constants.ProcessType.ZYYFSQD ).equals( processId+"" ) ){//装运预付申请单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
//				if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
				if( currIndex == processDetailList.size() - 2 ){//当前节点为倒数第二个节点（已完成节点的前一个节点）做通过操作时执行				
					transportPrepayMngService.auditSuccess( detailId, status+"", operId+"");
					
				}else{//执行-更新状态
					transportPrepayMngService.auditForConfirm(detailId, status+"", operId+"");
					
				}
					
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				transportPrepayMngService.auditFail( detailId, status+"", operId+"");
				
			}
			
		}else if( getProcessId(0, Constants.ProcessType.ZYFYHSSQD ).equals( processId+"" ) ){//装运费用核算申请单
			
			Map<String, Object> newParams = new HashMap<String, Object>();
			newParams.put("id", detailId);
			//现金会计：填写实付现金和油费
			if( null != params.get("balanceCash") && StringUtils.isNotEmpty( params.get("balanceCash").toString() ) ){
				newParams.put("balanceCash", params.get("balanceCash"));//如果有结付驾驶员信息,则更新该信息
			}
			if( null != params.get("balanceOil") && StringUtils.isNotEmpty( params.get("balanceOil").toString() ) ){
				newParams.put("balanceOil", params.get("balanceOil"));//如果有结付驾驶员信息,则更新该信息
			}
			if( null != params.get("balanceCashNextMonth") && StringUtils.isNotEmpty( params.get("balanceCashNextMonth").toString() ) ){
				newParams.put("balanceCashNextMonth", params.get("balanceCashNextMonth"));//如果有下月结付驾驶员信息,则更新该信息
			}
			
			if( null != params.get("cashChangeList") ){
				@SuppressWarnings("unchecked")
				List<Map<String, Object>> logListMap = (List<Map<String, Object>>) params.get("cashChangeList");
				if( null != logListMap && logListMap.size() > 0 ){
					List<TransportCostCashDetailLog> logList = new ArrayList<TransportCostCashDetailLog>();
					for(int i=0; i<logListMap.size(); i++){
						Map<String, Object> map = logListMap.get(i);
						TransportCostCashDetailLog log = new TransportCostCashDetailLog();
						if( map.get("newAmount") != null ){
							log.setNewAmount( Double.parseDouble(map.get("newAmount").toString()) );
						}
						log.setMark( ( map.get("mark") != null ) ? map.get("mark").toString() : null );
						if( null != map.get("transportCostCashDetailId") &&  null != map.get("transportCostCashDetailId").toString() ){
							log.setTransportCostCashDetailId( Integer.parseInt(map.get("transportCostCashDetailId").toString()) );
						}
						logList.add(log);
						
					}
					newParams.put("cashChangeList", logList);//费用变更信息
				}
				
			}
			
			//费用审核相关：公里数，油价，罚款
			if( null != params.get("distance") && StringUtils.isNotEmpty( params.get("distance").toString() ) ){
				newParams.put("distance", params.get("distance"));//公里数
			}
			if( null != params.get("oilPrice") && StringUtils.isNotEmpty( params.get("oilPrice").toString() ) ){
				newParams.put("oilPrice", params.get("oilPrice"));//油价
			}
			if( null != params.get("amerce") && StringUtils.isNotEmpty( params.get("amerce").toString() ) ){
				newParams.put("amerce", params.get("amerce"));//罚款
			}
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
//				if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
				if( currIndex == processDetailList.size() - 2 ){//当前节点为倒数第二个节点（已完成节点的前一个节点）做通过操作时执行
					transportCostMngService.auditSuccess( detailId, status+"", operId+"", newParams);
					
				}else{//执行-更新状态
					//待驾驶员确认时，下一步操作人为驾驶员:status-下一步状态
					if( Constants.CostApplyStatus.DIRVERVERIFY.equals(status+"") ){
						TransportCostApply detail = transportCostMngService.getById(detailId);
						receiveUserId = detail.getInsertUser()+"";
					}
					transportCostMngService.auditForConfirm(detailId, status+"", operId+"", newParams);
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				transportCostMngService.auditFail( detailId, status+"", operId+"");
			}
			
		}else if( getProcessId(0, Constants.ProcessType.LTCRKSQD ).equals( processId+"" ) ){//轮胎出入库申请单
			
			TrackTyreInOut ti = trackTyreInOutMngService.getById(detailId);
			if(null == ti)
			{
				throw new RuntimeException("查询实体为空！");
			}
			
			if("0".equals(ti.getType()))//0-入库
			{
				if( "Y".equals( successFlag ) ){//审核通过:
					if( currIndex != processDetailList.size()-1 ){
						status = currIndex + 1;
					}
					
					if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
						trackTyreRuService.auditSuccess( detailId, status+"", operId+"");
						
					}else{//执行-更新状态
						trackTyreRuService.auditForConfirm(detailId, status+"", operId+"");
						
					}
					
				}else{//审核不通过
					if( currIndex != 0 ){
						status = currIndex - 1;
					}
					
					if( auditOperStartIndex == currIndex ){//流程步骤为第一个操作类型为审核操作的流程步骤时，执行数据库变动动作
						trackTyreRuService.auditFail( detailId, status+"", operId+"");
						
					}else{//执行-更新状态
						trackTyreRuService.auditForConfirm(detailId, status+"", operId+"");
						
					}
					
				}
			}
			else  //出库
			{
				if( "Y".equals( successFlag ) ){//审核通过:
					if( currIndex != processDetailList.size()-1 ){
						status = currIndex + 1;
					}
					
					if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
						trackTyreInOutMngService.auditSuccess( detailId, status+"", operId+"");
						
					}else{//执行-更新状态
						trackTyreInOutMngService.auditForConfirm(detailId, status+"", operId+"");
						
					}
					
				}else{//审核不通过
					if( currIndex != 0 ){
						status = currIndex - 1;
					}
					
					if( auditOperStartIndex == currIndex ){//流程步骤为第一个操作类型为审核操作的流程步骤时，执行数据库变动动作
						trackTyreInOutMngService.auditFail( detailId, status+"", operId+"");
						
					}else{//执行-更新状态
						trackTyreInOutMngService.auditForConfirm(detailId, status+"", operId+"");
						
					}
					
				}
			}
			
		}else if( getProcessId(0, Constants.ProcessType.LTCGSQD ).equals( processId+"" ) ){//轮胎采购申请单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
				if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
					trackTyreBuyApplyService.auditSuccess( detailId, status, operId);
					
				}else{//执行-更新状态
					trackTyreBuyApplyService.auditForConfirm(detailId, status, operId);
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				if( auditOperStartIndex == currIndex ){//流程步骤为第一个操作类型为审核操作的流程步骤时，执行数据库变动动作
					trackTyreBuyApplyService.auditFail( detailId, status, operId);
					
				}else{//执行-更新状态
					trackTyreBuyApplyService.auditForConfirm(detailId, status, operId);
					
				}
				
			}
			
		}else if( getProcessId(0, Constants.ProcessType.WXBYSQD ).equals( processId+"" ) ){//维修保养申请单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
				if( currIndex == processDetailList.size() - 2 ){//当前节点为倒数第二个节点（已完成节点的前一个节点）做通过操作时执行
					trackMaintMngService.auditSuccess( detailId, status+"", operId+"");
					
				}else{//执行-更新状态
					trackMaintMngService.auditForConfirm(detailId, status+"", operId+"");
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				trackMaintMngService.auditFail( detailId, status+"", operId+"");
				
			}
			
		}else if( getProcessId(0, Constants.ProcessType.LTGHSQD ).equals( processId+"" ) ){//轮胎更换申请单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
				if( currIndex == processDetailList.size() - 2 ){//当前节点为倒数第二个节点（已完成节点的前一个节点）做通过操作时执行
					trackTyreChangeMngService.auditSuccess( detailId, status+"", operId+"");
					
				}else{//执行-更新状态
					trackTyreChangeMngService.auditForConfirm(detailId, status+"", operId+"");
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				trackTyreChangeMngService.auditFail( detailId, status+"", operId+"");
				
			}
			
		}else if( getProcessId(0, Constants.ProcessType.ZSFKSQD ).equals( processId+"" ) ){//折损反馈申请单
			if( currIndex != processDetailList.size()-1 ){
				status = currIndex + 1;
			}
			
			carDamageFeedbackMngService.auditForConfirm(detailId, status, operId);
				
		}else if( getProcessId(0, Constants.ProcessType.ZSFYSQD ).equals( processId+"" ) ){//折损费用申请单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
//				if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
				if( currIndex == processDetailList.size() -2 ){
					carDamageCostMngService.auditSuccess( detailId, status+"", operId+"");
					
				}else{//执行-更新状态
					carDamageCostMngService.auditForConfirm(detailId, status+"", operId+"");
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				carDamageCostMngService.auditFail( detailId, status+"", operId+"");
				
			}
			
		}else if( getProcessId(0, Constants.ProcessType.ZSCRKSQD ).equals( processId+"" ) ){//折损出入库申请单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
//				if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
				if( currIndex == processDetailList.size() -2 ){
					carDamageStockInOutService.auditSuccess( detailId, status, operId);
					
				}else{//执行-更新状态
					carDamageStockInOutService.auditForConfirm(detailId, status, operId);
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				carDamageStockInOutService.auditFail( detailId, status, operId);
				
			}
			
		}else if( getProcessId(0, Constants.ProcessType.PCZLSQD ).equals( processId+"" ) ){//派车指令申请单
			
			if( currIndex != processDetailList.size()-1 ){
				status = currIndex + 1;
			}
			
			sendCarCommandService.auditForConfirm(detailId, status, operId);
					
			//如果是驾驶员确认第一次确认时，则需要: status-为下一个状态
			if( Constants.SendCarCommandStatus.VERIFY.equals( status+"" ) ){
				receiveUserId = operId + "";
			}
			
		}else if( getProcessId(0, Constants.ProcessType.FYSQD ).equals( processId+"" ) ){//预付费用申请单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
				if( currIndex == processDetailList.size()-2 ){//当是已完成的前一个步骤时，进行审核通过
					costApplyService.auditSuccess( detailId, status, operId);
					
				}else{//执行-更新状态
					costApplyService.auditForConfirm(detailId, status, operId);
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				costApplyService.auditFail( detailId, status, operId);
				
			}
			
		}else if( getProcessId(0, Constants.ProcessType.HXFYSQD ).equals( processId+"" ) ){//核销费用申请单
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
				if( currIndex == processDetailList.size()-2 ){//当是已完成的前一个步骤时，进行审核通过
					costApplyReturnService.auditSuccess( detailId, status, operId);
					
				}else{//执行-更新状态
					costApplyReturnService.auditForConfirm(detailId, status, operId);
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				costApplyReturnService.auditFail( detailId, status, operId);
				
			}
			
		}else {//办公费用申请单
			//如果有结付信息,则更新该信息
			Map<String, Object> newParams = new HashMap<String, Object>();
			newParams.put("id", detailId);
			if( null != params.get("prepareMoney") && StringUtils.isNotEmpty( params.get("prepareMoney").toString() ) ){
				newParams.put("prepareMoney", params.get("prepareMoney"));
			}
			
			if( "Y".equals( successFlag ) ){//审核通过:
				if( currIndex != processDetailList.size()-1 ){
					status = currIndex + 1;
				}
				
				if( auditOperEndIndex == currIndex ){//流程步骤为最后一个操作类型为审核操作的流程步骤时，执行数据库变动动作
					taskService.auditSuccess( itemId, status+"", operId+"", newParams);
					
					//如果是预付现金，则收支管理生成1条记录
					if( null != params.get("prepareMoney") && StringUtils.isNotEmpty( params.get("prepareMoney").toString() ) && Double.parseDouble(params.get("prepareMoney").toString()) > 0 ){
						String prepareMoneyStr = params.get("prepareMoney").toString();
						CashInOut cash = new CashInOut();
						User user = userMapper.getById(operId);
						int departmentId = 0;
						if( null != user && null != user.getDepartmentId() ){
							departmentId = user.getDepartmentId();
						}
						cash.setDepartmentId(departmentId);
						cash.setBusinessType(Constants.CashInOutBusinessType.CostApply);
						cash.setType(Constants.CashInOutType.OUT);
						cash.setDetailId(itemId);
						cash.setMark("费用申请");
						cash.setMoney( Double.parseDouble(prepareMoneyStr) );
						cash.setDelFlag(Constants.DelFlag.N);
						cash.setInsertTime(new Date());
						cash.setInsertUser(operId+"");
						cash.setUpdateTime(new Date());
						cash.setUpdateUser(operId+"");
						cash.setStatus(Constants.CashInOutStatus.SUBMIT);
						cash.setSystemFlag(Constants.SystemFlag.Y);
						cashInOutMapper.insert(cash);
						
					}
					
				}else{//执行-更新状态
					taskService.auditForConfirm( itemId, status+"", operId+"", newParams);
					
				}
				
			}else{//审核不通过
				if( currIndex != 0 ){
					status = currIndex - 1;
				}
				
				if( auditOperStartIndex == currIndex ){//流程步骤为第一个操作类型为审核操作的流程步骤时，执行数据库变动动作
					taskService.auditFail( itemId, status+"", operId+"");
					
				}else{//执行-更新状态
					taskService.auditForConfirm( itemId, status+"", operId+"", newParams);
					
				}
				
			}
			
		}
		
		if( "Y".equals(successFlag) ){//审核通过
			if( currIndex == processDetailList.size() - 2 ){//流程可以结束: 如果当前审核步骤为已完成的前一步
				//如果是装运预付申请、装运费用核算申请，则推送给驾驶员
				if( getProcessId(0, Constants.ProcessType.ZYYFSQD ).equals( processId+"" ) ){//装运预付申请单
					TransportPrepayApply tp = transportPrepayApplyMapper.getById(detailId);
					receiveUserId = tp.getDriverId() + "";
					
				}else if( getProcessId(0, Constants.ProcessType.ZYFYHSSQD ).equals( processId+"" ) ){//装运费用核算申请
					TransportCostApply tc = transportCostMngService.getById(detailId);
					receiveUserId = tc.getInsertUser() + "";
					
				}else{
					receiveUserId = item.getApplyUserId().toString();//推送给申请人
					
				}
				
				//更新项目状态为：已完成
				item.setStatus( Constants.ItemStatus.FINISHED );
				item.setUpdateTime( new Date() );
				item.setUpdateUser( operId+"" );
				itemMapper.updateBySelective( item );
				
			}else{
				//插入下一个流程步骤对应的待办
				Task nextTask = new Task();
				nextTask.setProcessDetailId( processDetailList.get(currIndex+1).getId() );
				if( StringUtils.isEmpty( receiveUserId ) ){
					receiveUserId = processDetailList.get(currIndex+1).getOperateUserId();
				}
				nextTask.setReceiveUserId( receiveUserId );
				nextTask.setItemId( itemId );
				nextTask.setDelFlag( Constants.DelFlag.N );
				nextTask.setInsertTime( new Date() );
				nextTask.setInsertUser(  operId + "" );
				nextTask.setUpdateTime( new Date() );
				nextTask.setUpdateUser(  operId + "" );
				taskMapper.insert( nextTask );
				
			}
			
		}else{//审核不通过
			if( StringUtils.isEmpty( receiveUserId ) ){
				receiveUserId = processDetailList.get(currIndex-1).getOperateUserId();
				if( StringUtils.isEmpty(receiveUserId) ){
					receiveUserId = item.getApplyUserId().toString();
				}
				
			}
			
			//插入上一个流程步骤对应的待办：退回
			Task nextTask = new Task();
			nextTask.setProcessDetailId( processDetailList.get(currIndex-1).getId() );
			nextTask.setReceiveUserId( receiveUserId );//原提交人
			nextTask.setItemId(itemId);
			nextTask.setDelFlag(Constants.DelFlag.N);
			nextTask.setInsertTime(new Date());
			nextTask.setInsertUser( operId + "" );
			nextTask.setUpdateTime(new Date());
			nextTask.setUpdateUser( operId + "" );
			taskMapper.insert(nextTask);
			
		}
		
		//推送消息：
		String statusStr = "";
		if( Constants.ItemStatus.NEW.equals( status+"" ) ){
			statusStr = "新建";
		}else if( Constants.ItemStatus.PROCESSING.equals( item.getStatus() ) ){
			statusStr = "流转中";
		}else if( Constants.ItemStatus.FINISHED.equals( item.getStatus() ) ){
			statusStr = "已完成";
		}
		String content = "新消息：" + item.getItemName()+"[审核状态："+ statusStr +"]";
		pushMsgToUser( Integer.parseInt(receiveUserId), content );
		
	}

	@Override
	@SystemServiceLog(description="获取业务的提交操作对应的流程状态")
	public String getProcessStatusForSubmit(int processId) throws Exception {
		//所有的流程步骤
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processId", processId );
		params.put("orderBy", "order_no ASC" );//序号正序排序
		List<ProcessDetail> processDetailList = processDetailMapper.getByConditions(params);
		if( null == processDetailList || processDetailList.size() == 0 ){
			throw new RuntimeException("流程步骤信息不存在");
		}
		
		if( processDetailList.size() > 1 ){
			return processDetailList.get(1).getOperateUserId();
		}
		
		return null;
	}

	@Override
	@SystemServiceLog(description="将临时文件存储到正式目录")
	public String reStoreFile(String uploadType, String attachFilePath, HttpServletRequest req)
			throws Exception {
		//父路径
		String newFilePath = CommonUtil.getStorePathForNormal(uploadType);
		//获取文件名
		String fileName = attachFilePath.substring( attachFilePath.lastIndexOf("/") + 1 );
		String destPath = newFilePath + "/" + UUID.randomUUID().toString()+"_" + fileName;
		
		File srcFile = new File( req.getServletContext().getRealPath(attachFilePath) );
		File destFile = new File( req.getServletContext().getRealPath(destPath) );
		FileUtils.copyFile(srcFile, destFile);
		
		return destPath;
	}
	
	@Override
	@SystemServiceLog(description="将临时文件存储到正式目录-批量")
	public String reStoreFileForBatch(String uploadType, String attachFilePath, HttpServletRequest req)
			throws Exception {
		String destPath = "";
		
		String[] arr = attachFilePath.split(Constants.SplitStr.UploadFileName);
		if( null != arr && arr.length > 0 ){
			for(int i=0; i<arr.length; i++){
				String subAttachFilePath = arr[i];
				if( StringUtils.isEmpty(subAttachFilePath) ){
					continue;
				}
				String reStoreFile = this.reStoreFile(uploadType, subAttachFilePath, req);
				if( null != reStoreFile ){
					destPath += reStoreFile;
				}
				destPath += Constants.SplitStr.UploadFileName;
			}
		}
		
		if( destPath.endsWith(Constants.SplitStr.UploadFileName) ){
			destPath = destPath.substring(0, destPath.length()-1);
		}
		return destPath;
	}
	
	@SystemServiceLog(description="根据业务类型及业务id,获取对应的任务id")
	public String getTaskIdByBusinessType(String type, String detailId) throws Exception {
		String taskId = "";
		if( Constants.ProcessType.YD.equals(type) ){
			//TODO
			
		}else if( Constants.ProcessType.DDD.equals(type) ){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("detailId", detailId );
			params.put("orderBy", "id DESC" );
			List<Task> list = taskMapper.getByConditions(params);
			if( null != list && list.size() > 0 ){
				taskId = list.get(0).getId().toString();
			}
			
		}
		return taskId;
	}

	@Override
	@SystemServiceLog(description="推送消息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void pushMessage(String msgContent, int receiveUserId, String detailId)
			throws Exception {
		Message bean = new Message();
		bean.setMark(msgContent);
		bean.setReceiveUserId(receiveUserId);
		bean.setDetailId(detailId);
		bean.setStatus(Constants.ReadFlag.N);
		bean.setDelFlag(Constants.DelFlag.N);
		bean.setInsertTime(new Date());
		messageMapper.insert(bean);
		
		//推送app
		JPushUtils.push(msgContent, receiveUserId+"");
		
	}

	@Override
	public Map<String, String> getAllConfigValues() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public String getConfigValue(int stockId, String configName) throws Exception {
		if( 0 != stockId){
			configName += "-" + stockId;
		}
		BasicConfig config = basicConfigMapper.getByConfigName(configName);
		if( null != config ){
			return config.getConfigValue();
		}
		return null;
	}
	
	@Override
	public void setConfigValue(String configName, String configValue, int oper)
			throws Exception {
		
		BasicConfig old = basicConfigMapper.getByConfigName(configName);
		if( null == old ){
			BasicConfig bean = new BasicConfig();
			bean.setConfigName(configName);
			bean.setConfigValue(configValue);
			bean.setInsertTime(new Date());
			bean.setInsertUser(oper+"");
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper+"");
			bean.setDelFlag(Constants.DelFlag.N);
			basicConfigMapper.insert(bean);
			
		}else{
			old.setConfigName(configName);
			old.setConfigValue(configValue);
			old.setUpdateTime(new Date());
			old.setUpdateUser(oper+"");
			basicConfigMapper.update(old);
			
		}
		
	}

	/**
	 * @Description: 从数据中获取，系统使用的业务流程id
	 * @author army.liu 
	 * @param @param type
	 * @param @return    设定文件
	 * @return String    返回类型
	 * @throws
	 * @see
	 */
	public String getProcessId(int stockId, String type) throws Exception {
		String processConfigName = "";
		if( Constants.ProcessType.YD.equals(type) ){//运单
			processConfigName = Constants.BasicConfigName.YD_PROCESS_ID;
			
		}else if( Constants.ProcessType.DDD.equals(type) ){//调度单
			processConfigName = Constants.BasicConfigName.DDD_PROCESS_ID;
			
		}else if( Constants.ProcessType.HCSQD.equals(type) ){//换车申请单
			processConfigName = Constants.BasicConfigName.HCSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.ZYYFSQD.equals(type) ){//装运预付申请单
			processConfigName = Constants.BasicConfigName.ZYYFSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.ZYFYHSSQD.equals(type) ){//装运费用核算申请单
			processConfigName = Constants.BasicConfigName.ZYFYHSSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.LTCRKSQD.equals(type) ){//轮胎出入库申请单
			processConfigName = Constants.BasicConfigName.LTCRKSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.WXBYSQD.equals(type) ){//维修保养申请单
			processConfigName = Constants.BasicConfigName.WXBYSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.LTGHSQD.equals(type) ){//轮胎更换申请单
			processConfigName = Constants.BasicConfigName.LTGHSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.ZSFKSQD.equals(type) ){//折损反馈申请单
			processConfigName = Constants.BasicConfigName.ZSFKSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.ZSFYSQD.equals(type) ){//折损费用申请单
			processConfigName = Constants.BasicConfigName.ZSFYSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.ZSCRKSQD.equals(type) ){//折损出入库申请单
			processConfigName = Constants.BasicConfigName.ZSCRKSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.PCZLSQD.equals(type) ){//派车指令申请单
			processConfigName = Constants.BasicConfigName.PCZLSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.FYSQD.equals(type) ){//费用申请单
			processConfigName = Constants.BasicConfigName.FYSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.HXFYSQD.equals(type) ){//核销费用申请单
			processConfigName = Constants.BasicConfigName.HXFYSQD_PROCESS_ID;
			stockId = 0;
		}else if( Constants.ProcessType.LTCGSQD.equals(type) ){//轮胎采购申请单
			processConfigName = Constants.BasicConfigName.LTCGSQD_PROCESS_ID;
			stockId = 0;
		}	
		
		return getConfigValue(stockId, processConfigName );
	}

	@Override
	public void pushLatestMsgCount(int receiveUserId) throws Exception {
		 //查询未读消息
        int count = messageService.getUnReadMsgCount( receiveUserId );
        systemWebSocketHandler.sendMessageToUser( receiveUserId+"", new TextMessage( count + "" ) );
		
	}

	@Override
	public void pushMsgToUser(int receiveUserId, String content)
			throws Exception {
		Message bean = new Message();
		bean.setDelFlag( Constants.DelFlag.N );
		bean.setInsertTime( new Date() );
		bean.setUpdateTime( new Date() );
		bean.setMark(content);
		bean.setReceiveUserId( receiveUserId );
		bean.setStatus( Constants.ReadFlag.N );
		messageMapper.insert(bean);
		
		//web端推送消息：
		systemWebSocketHandler.sendMessageToUser( receiveUserId+"", new TextMessage( content ) );
		
		//app端推送消息：
		try{
			JPushUtils.push(content, receiveUserId+"");
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	@Override
	public String createBusinessBillNo(String businessType, int operId)
			throws Exception {
		//调度单生成规则：BJZSS201610230001 
		//			地名的2位首字母大写：如北京 + 用户名称的首字母大写，如：张珊珊 + yyyyMMdd + 4位流水号
		if( Constants.BusinessType.DDD.equals(businessType) ){
			User user = userMapper.getById(operId);
			if( null == user ){
				throw new RuntimeException("用户信息异常，请重新登录！");
			}
			String stockId = user.getStockId();
			Stock stock = stockMapper.getById( Integer.parseInt(stockId) );
			if( null == stock ){
				throw new RuntimeException("当前用户的仓库信息未设置，请联系管理员！");
			}
			String stockName = stock.getName().substring(0, 2);//仓库名称的前两位
			//生成地区的首字母大写
			String areaStr = this.getPyCode(stockName).toUpperCase();
			
			String userName = user.getName();
			if( StringUtils.isEmpty(userName) ){
				throw new RuntimeException("当前用户的名称未设置，请联系管理员！");
			}
			//生成用户名的首字母大写
			String nameStr = this.getPyCode(userName).toUpperCase();
			
			//生成当前时间的yyyyMMdd
			String dateStr = CommonUtil.getCurrYearMonthDay();
			
			//生成4位流水号
			String billNoPrefix = areaStr + nameStr + dateStr;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("currYearMonthDay", billNoPrefix);
			params.put("orderBybillNo", "Y");
			params.put("insertUser", operId);
			List<ScheduleBill> list = scheduleBillMapper.getByConditions(params);
			int billNoSuffixLength = 4;
			String billNoSuffix = "0001";
			if( null != list && list.size() > 0 ){
				String latestBillNo = list.get(0).getScheduleBillNo();
				String latestBillNoSuffix = latestBillNo.substring(latestBillNo.length()-billNoSuffixLength);
				billNoSuffix = String.format("%0" + billNoSuffixLength + "d", Integer.parseInt(latestBillNoSuffix) + 1);
				
			}
			
			return billNoPrefix + billNoSuffix;
			
		}else if( Constants.BusinessType.YD.equals(businessType) ){
			User user = userMapper.getById(operId);
			if( null == user ){
				throw new RuntimeException("用户信息异常，请重新登录！");
			}
			String stockId = user.getStockId();
			Stock stock = stockMapper.getById( Integer.parseInt(stockId) );
			if( null == stock ){
				throw new RuntimeException("当前用户的仓库信息未设置，请联系管理员！");
			}
			String stockName = stock.getName().substring(0, 2);//仓库名称的前两位
			//生成地区的首字母大写
			String areaStr = this.getPyCode(stockName).toUpperCase();
			
			String userName = user.getName();
			if( StringUtils.isEmpty(userName) ){
				throw new RuntimeException("当前用户的名称未设置，请联系管理员！");
			}
			//生成用户名的首字母大写
			String nameStr = this.getPyCode(userName).toUpperCase();
			
			//生成当前时间的yyyyMMdd
			String dateStr = CommonUtil.getCurrYearMonthDay();
			
			//生成4位流水号
			String billNoPrefix = areaStr + nameStr + dateStr;
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("currYearMonthDay", billNoPrefix);
			params.put("orderBybillNo", "Y");
			params.put("insertUser", operId);
			List<Waybill> list = waybillMapper.getByConditions(params);
			int billNoSuffixLength = 4;
			String billNoSuffix = "0001";
			if( null != list && list.size() > 0 ){
				String latestBillNo = list.get(0).getScheduleBillNo();
				String latestBillNoSuffix = latestBillNo.substring(latestBillNo.length()-billNoSuffixLength);
				billNoSuffix = String.format("%0" + billNoSuffixLength + "d", Integer.parseInt(latestBillNoSuffix) + 1);
				
			}
			
			return billNoPrefix + billNoSuffix;
			
		}
		
		return null;
	}

	@Override
	public String getPyCode(String name) throws Exception {
		String result = "";
		for(int i=0; i<name.length();i++){
			String c = name.substring(i,i+1);
			DicPy py = dicPyMapper.getByChn(c);
			if( null != py ){
				result += py.getPy().trim();
			}
		}
		return result;
	}

	@Override
	public String getWbCode(String name) throws Exception {
		String result = "";
		for(int i=0; i<name.length();i++){
			String c = name.substring(i,i+1);
			DicWb bean = dicWbMapper.getByChn(c);
			if( null != bean ){
				result += bean.getWb().trim();
			}
			
		}
		return result;
	}

	@Override
	public Pager<ReportForWaybill> getReportForWaybillPageData(
			Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		List<ReportForWaybill> list = commonMapper.getReportForWaybillPageList(params);
		int totalCount = commonMapper.getReportForWaybillPageCount(params);
		
		Pager<ReportForWaybill> pager = new Pager<ReportForWaybill>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	public List<ReportForWaybill> getReportForWaybill(Map<String, Object> params)
			throws Exception {
		return commonMapper.getReportForWaybill(params);
	}

	@Override
	public Map<String, Object> getReportForWaybillExportData( Map<String, Object> params) throws Exception {
		Map<String, Object> formatData = new HashMap<String, Object>();
		
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet1");
		formatData.put("sheetList", sheetList);
		
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "4S店驳运明细");
		sheetData.put("titleMergeSize", 8);
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("4S店");
		tableHeadList.add("运单号");
		tableHeadList.add("下单时间");
		tableHeadList.add("品牌");
		tableHeadList.add("车型");
		tableHeadList.add("车架号");
		tableHeadList.add("状态");
		sheetData.put("tableHeader", tableHeadList);
		
		List<List<String>> tableData = new ArrayList<List<String>>();
		List<ReportForWaybill> list = this.getReportForWaybill(params);
		if(null != list && list.size() > 0){
			int unFinishedCount = 0;
			int hasFinishedCount = 0;
			for(int i = 0; i < list.size(); i++){
				List<String> rowData = new ArrayList<String>();
				rowData.add(String.valueOf(i+1));
				rowData.add(list.get(i).getCarShopName());
				rowData.add(list.get(i).getWaybillNo());
				Date waybillSendTime = list.get(i).getWaybillSendTime();
				if( null == waybillSendTime ){
					rowData.add(CommonUtil.format(waybillSendTime, Constants.DATE_TIME_FORMAT_SHORT));
				}else{
					rowData.add("");
				}
				rowData.add(list.get(i).getBrand());
				rowData.add(list.get(i).getModel());
				rowData.add(list.get(i).getVin());
				String status = list.get(i).getCarStatus();
				if( Constants.CarStatus.HASIN.equals(status) ){
					rowData.add("待运");
					unFinishedCount++;
				}else{
					rowData.add("已运");
					hasFinishedCount++;
				}
				tableData.add(rowData);
			}
			//合计
			List<String> rowData = new ArrayList<String>();
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("合计");
			rowData.add("待运-"+unFinishedCount);
			rowData.add("已运-"+hasFinishedCount);
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		return formatData;
	}
	
	@Override
	public Pager<ReportForSchedulebill> getReportForSchedulebillPageData(
			Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		List<ReportForSchedulebill> list = commonMapper.getReportForSchedulebillPageList(params);
		int totalCount = commonMapper.getReportForSchedulebillPageCount(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				
				//获取商品的驳运运费：不包含其他费用
				double transportCost = this.calculateTransportCost(list.get(i));
				list.get(i).setTransportCost( transportCost );
				
			}
		}
		
		Pager<ReportForSchedulebill> pager = new Pager<ReportForSchedulebill>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	public double calculateTransportCost(ReportForSchedulebill bean) {
		BalanceCar bakabceCar = new BalanceCar();
		bakabceCar.setSupplierId(bean.getSupplierId());
		bakabceCar.setStartAddress(bean.getStartAddress());
		bakabceCar.setTargetProvince(bean.getTargetProvince());
		bakabceCar.setTargetCity(bean.getTargetCity());
		bakabceCar.setModel(bean.getModel());
		bakabceCar.setBrand(bean.getBrand());
		bakabceCar.setTransportPrice(bean.getTransportCost());
		bakabceCar.setId(bean.getCarStockId());
		try {
			BalanceCar balanceCar = incomeMngService.getBalanceCar(bakabceCar);
			return balanceCar.getBalancePrice();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<ReportForSchedulebill> getReportForSchedulebill(
			Map<String, Object> params) throws Exception {
		List<ReportForSchedulebill> list = commonMapper.getReportForSchedulebill(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				
				//获取商品的驳运运费：不包含其他费用
				double transportCost = this.calculateTransportCost(list.get(i));
				list.get(i).setTransportCost( transportCost );
				
			}
		}
		return list;
	}

	@Override
	public Map<String, Object> getReportForSchedulebillExportData(
			Map<String, Object> params) throws Exception {
		Map<String, Object> formatData = new HashMap<String, Object>();
		
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet1");
		formatData.put("sheetList", sheetList);
		
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "承运商运费");
		sheetData.put("titleMergeSize", 13);
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("承运商");
		tableHeadList.add("装运时间");
		tableHeadList.add("装运车号");
		tableHeadList.add("调度单号");
		tableHeadList.add("品牌");
		tableHeadList.add("车型");
		tableHeadList.add("车架号");
		tableHeadList.add("始发地");
		tableHeadList.add("目的省");
		tableHeadList.add("目的地");
		tableHeadList.add("4S店");
		tableHeadList.add("运费");
		sheetData.put("tableHeader", tableHeadList);
		
		List<List<String>> tableData = new ArrayList<List<String>>();
		List<ReportForSchedulebill> list = this.getReportForSchedulebill(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				
				//获取商品的驳运运费：不包含其他费用
				double transportCost = this.calculateTransportCost(list.get(i));
				list.get(i).setTransportCost( transportCost );
				
			}
		}
		if(null != list && list.size() > 0){
			double amount = 0;
			for(int i = 0; i < list.size(); i++){
				List<String> rowData = new ArrayList<String>();
				rowData.add(String.valueOf(i+1));
				rowData.add(list.get(i).getOutSourcingName());
				Date scheduleSendTime = list.get(i).getScheduleSendTime();
				if( null != scheduleSendTime ){
					rowData.add(CommonUtil.format(scheduleSendTime, Constants.DATE_TIME_FORMAT_SHORT));
				}else{
					rowData.add("");
				}
				rowData.add(list.get(i).getCarNumber());
				rowData.add(list.get(i).getScheduleBillNo());
				rowData.add(list.get(i).getBrand());
				rowData.add(list.get(i).getModel());
				rowData.add(list.get(i).getVin());
				rowData.add(list.get(i).getStartAddress());
				rowData.add(list.get(i).getTargetProvince());
				rowData.add(list.get(i).getTargetCity());
				rowData.add(list.get(i).getCarShopName());
				rowData.add(list.get(i).getTransportCost()+"");
				amount += list.get(i).getTransportCost();
				tableData.add(rowData);
			}
			//合计
			List<String> rowData = new ArrayList<String>();
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("合计");
			rowData.add(""+list.size());
			rowData.add(""+CommonUtil.formatDouble(amount));
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		return formatData;
	}

	@Override
	public int getOutSourcingIdForOwnCompany() throws Exception {
		BasicConfig basicConfig = basicConfigMapper.getByConfigName(Constants.BasicConfigName.OUT_SOURCE_ID_FOR_OWN_COMPANY);
		if( null == basicConfig ){
			return 0;
		}
		String configValue = basicConfig.getConfigValue();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("nameEqual", configValue);
		List<OutSourcing> outSourcingList = outSourcingMapper.getByConditions(params);
		if( null == outSourcingList || outSourcingList.size() == 0 ){
			return 0;
		}
		
		return outSourcingList.get(0).getId();
	}

	@Override
	public double getDriverSalaryDistanceAllowance(Integer userId, String salaryTime)
			throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("delFlag", Constants.DelFlag.N);
		params.put("statusLess", Constants.CostApplyStatus.DIRVERVERIFY);//通过费用审核
		params.put("updateTimeYearMonth", salaryTime);
		Integer totalDistance = transportCostApplyMapper.getTotalDistanceForDriver(params);
		if( null == totalDistance ){
			return 0;
		}
		//获取配置信息：里程下限和单价
		String distance = commonService.getConfigValue(0, Constants.BasicConfigName.DRIVER_SALARY_DISTANCE_LIMIT);
		String price = commonService.getConfigValue(0, Constants.BasicConfigName.DRIVER_SALARY_DISTANCE_PRICE);
		if(StringUtils.isEmpty(distance)){
			throw new RuntimeException("里程下限未设置，请联系管理员进行设置！");
		}
		if(StringUtils.isEmpty(price)){
			throw new RuntimeException("里程单价未设置，请联系管理员进行设置！");
		}
		int limitDistance = Integer.parseInt(distance);
		if( limitDistance > totalDistance ){
			return 0;
		}
		
		return CommonUtil.formatDouble((totalDistance-limitDistance)*Double.parseDouble(price));
	}

	@Override
	public List<Supplier> getComSuppliersList() throws Exception {
		
		return commonMapper.getComSuppliersList();
	}

}
