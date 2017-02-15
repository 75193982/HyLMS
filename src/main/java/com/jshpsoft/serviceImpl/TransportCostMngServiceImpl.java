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
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.CashWaitingPayLogMapper;
import com.jshpsoft.dao.OilCardOperateLogMapper;
import com.jshpsoft.dao.TaskHistoryMapper;
import com.jshpsoft.dao.TrackMapper;
import com.jshpsoft.dao.TransportCostApplyDetailMapper;
import com.jshpsoft.dao.TransportCostApplyMapper;
import com.jshpsoft.dao.TransportCostCashDetailLogMapper;
import com.jshpsoft.dao.TransportCostCashDetailMapper;
import com.jshpsoft.dao.TransportPrepayApplyMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.CashWaitingPayLog;
import com.jshpsoft.domain.OilCardOperateLog;
import com.jshpsoft.domain.TaskHistory;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TransportCostApply;
import com.jshpsoft.domain.TransportCostApplyDetail;
import com.jshpsoft.domain.TransportCostCashDetail;
import com.jshpsoft.domain.TransportCostCashDetailLog;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.FineMngService;
import com.jshpsoft.service.TransportCostMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("transportCostMngService")
public class TransportCostMngServiceImpl implements TransportCostMngService {
	
	@Autowired
	private TransportCostApplyMapper transportCostApplyMapper;
	
	@Autowired
	private TransportCostApplyDetailMapper transportCostApplyDetailMapper;
	
	@Autowired
	private TransportCostCashDetailMapper transportCostCashDetailMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private TransportPrepayApplyMapper transportPrepayApplyMapper;
	
	@Autowired
	private TaskHistoryMapper taskHistoryMapper;
	
	@Autowired
	private TransportCostCashDetailLogMapper transportCostCashDetailLogMapper;
	
	@Autowired
	private TrackMapper trackMapper;
	
	@Autowired
	private FineMngService fineMngService;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private CashInOutMapper cashInOutMapper;
	
	@Autowired
	private CashWaitingPayLogMapper cashWaitingPayLogMapper;
	
	@Autowired
	private OilCardOperateLogMapper oilCardOperateLogMapper;
	

	@Override
	@SystemServiceLog(description="获取装运费用核算申请信息")
	public Pager<TransportCostApply> getPageData(Map<String, Object> params)
			throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		params.put("delFlag", Constants.DelFlag.N);
		List<TransportCostApply> list = transportCostApplyMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				User driver = userMapper.getById(list.get(i).getDriverId()) ;
				if( null != driver ){
					list.get(i).setDriverName( driver.getName() );
				}
				list.get(i).setOilAndAmountSum((new BigDecimal(list.get(i).getOilAmount()+"").add(new BigDecimal(list.get(i).getAmount()+""))).doubleValue());
			}
		}

		int totalCount = transportCostApplyMapper.getPageTotalCount(params);
		
		Pager<TransportCostApply> pager = new Pager<TransportCostApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增装运费用核算申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TransportCostApply bean, String oper,HttpServletRequest request) throws Exception {
		if( null == bean ){
			throw new RuntimeException("装运费用核算申请信息为空");
		}
		
		//插入装运费用核算主表
		bean.setStatus(Constants.CostApplyStatus.NEW);//新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		transportCostApplyMapper.insert(bean);
		
		//插入核算申请明细表及现金明细
		insertCostApplyDetailInfo(bean, oper, request);	
	}

	private void insertCostApplyDetailInfo(TransportCostApply bean, String oper, HttpServletRequest request) throws Exception {
		
		double amount = 0;
		List<TransportCostApplyDetail> applyDetailList = bean.getCostList();
		if( null == applyDetailList){
			throw new RuntimeException("装运费用核算申请明细信息为空");
		}
		
		//插入核算申请明细表
		if(null != applyDetailList && applyDetailList.size()>0 ){
			for(int i=0;i<applyDetailList.size();i++){
				TransportCostApplyDetail applyDetail = applyDetailList.get(i);
				applyDetail.setParentId(bean.getId());
				applyDetail.setInsertTime(new Date());
				applyDetail.setInsertUser(oper);
				applyDetail.setUpdateTime(new Date());
				applyDetail.setUpdateUser(oper);
				applyDetail.setDelFlag(Constants.DelFlag.N);
				transportCostApplyDetailMapper.insert(applyDetail);
				
				//插入核算现金明细表
				List<TransportCostCashDetail> cashList = applyDetail.getCashList();
				if(null != cashList && cashList.size()>0 ){
					for(int j=0;j<cashList.size();j++){
						TransportCostCashDetail cash = cashList.get(j);
						if( null != cash ){
							
							//附件是否需要更新标记
							boolean attachFileNeedFlag = true;
							Integer cashId = cash.getId();
							TransportCostCashDetail oldCash = transportCostCashDetailMapper.getById(cashId);
							if( null != oldCash ){//如果更新时，需要特殊处理原来已上传的附件
								if( StringUtils.isNotEmpty( oldCash.getFilePath() ) && oldCash.getFilePath().equals(cash.getFilePath() ) ){
									attachFileNeedFlag = false;
								}
							}
							if( attachFileNeedFlag && StringUtils.isNotEmpty(cash.getFilePath()) ){
								String path = cash.getFilePath();
								String newFilePath = commonService.reStoreFileForBatch( Constants.UploadType.TRANSPORTCOST, path , request);
								cash.setFilePath(newFilePath);
							}
							cash.setTransportCostApplyDetailId(applyDetail.getId());
							cash.setInsertTime(new Date());
							cash.setInsertUser(oper);
							cash.setUpdateTime(new Date());
							cash.setUpdateUser(oper);
							cash.setDelFlag(Constants.DelFlag.N);
							transportCostCashDetailMapper.insert(cash);
							
							//报账现金计算
							amount += cash.getAmount();
							
						}
					}
				}
			}
		}
		
		//更新报账现金
		bean.setAmount(  CommonUtil.formatDouble(amount) );
		transportCostApplyMapper.update(bean);
		
	}

	@Override
	@SystemServiceLog(description="更新装运费用核算申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TransportCostApply bean, String oper,HttpServletRequest request) throws Exception {
		if( null == bean ){
			throw new RuntimeException("装运费用核算申请信息为空");
		}
		
		List<TransportCostApplyDetail> applyDetailList = bean.getCostList();
		if( null == applyDetailList){
			throw new RuntimeException("装运费用核算申请明细为空");
		}
		
		//更新申请主表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		transportCostApplyMapper.update(bean);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentId", bean.getId());
		params.put("delFlag", Constants.DelFlag.N);
		List<TransportCostApplyDetail> list = transportCostApplyDetailMapper.getByConditions(params);
		if(null != list && list.size()>0 ){
			for(int k=0;k<list.size();k++){
				//根据detailId删除原先的现金明细
				Map<String, Object> newParams = new HashMap<String, Object>();
				newParams.put("detailId", list.get(k).getId());
				newParams.put("updateTime", new Date());
				newParams.put("updateUser", oper);
				newParams.put("delFlag", Constants.DelFlag.Y);
				transportCostCashDetailMapper.updateByDetailId(newParams);
			}
		}
		
		//根据parentId删除原先的申请明细
		transportCostApplyDetailMapper.deleteByParentId(bean.getId());
		
		//插入核算申请明细表及现金明细
		insertCostApplyDetailInfo(bean, oper, request);	
		
	}
	
	@Override
	@SystemServiceLog(description="根据id获取装运费用核算申请信息")
	public TransportCostApply getById(Integer id) throws Exception {
		TransportCostApply bean = transportCostApplyMapper.getById(id);
		User driver = userMapper.getById(bean.getDriverId()) ;
		if( null != driver ){
			bean.setDriverName( driver.getName() );
		}
		//获取此次可折现现金
		String discountFlag = bean.getDiscountFlag();
		if( "Y".equals(discountFlag) ){
			double amount = bean.getAmount();
			double oilAmount = bean.getOilAmount();
			double oilDiscountLimit = bean.getOilDiscountLimit();
			double oilDiscountPoint = bean.getOilDiscountPoint();
			
			//预付的现金和油费
			Map<String, Object> paramsPrepay = new HashMap<String, Object>();
			paramsPrepay.put("scheduleBillNo", bean.getScheduleBillNo());
			paramsPrepay.put("delFlag", Constants.DelFlag.N);
			paramsPrepay.put("orderAsc", "Y");
			List<TransportPrepayApply> prepayList = transportPrepayApplyMapper.getByConditions(paramsPrepay);
			if(null != prepayList && prepayList.size()>0 ){
				for(int i=0; i<prepayList.size(); i++){
					TransportPrepayApply prepay = prepayList.get(i);
					BigDecimal prepayOilAmount = prepay.getOilAmount();
					BigDecimal prepayCash = prepay.getPrepayCash();
					if( null != prepayOilAmount ){
						oilAmount -= prepayOilAmount.doubleValue();
					}
					if( null != prepayCash ){
						amount -= prepayCash.doubleValue();
					}
					
				}
			}
			
			//可折现的油费数目
			double canDiscountOilAmount = (oilAmount > oilDiscountLimit) ? oilDiscountLimit : oilAmount;
			//折现油费对应的现金
			double discountAmount = canDiscountOilAmount * ( 100 - oilDiscountPoint ) / 100;
			//折现后总现金
			double discountTotalAmount = discountAmount + amount;
			//折现后总油费
			double discountTotalOilAmount = oilAmount - canDiscountOilAmount;
			bean.setDiscountAmount( CommonUtil.formatDouble(discountAmount) );
			bean.setDiscountTotalAmount(  CommonUtil.formatDouble(discountTotalAmount) );
			bean.setDiscountTotalOilAmount(  CommonUtil.formatDouble(discountTotalOilAmount) );
			
		}
		//获取预付信息
		/*if(null != bean.getPrepayApplyIds() && !bean.getPrepayApplyIds().equals("")){
			String ids = bean.getPrepayApplyIds();
			Map<String, Object> paramsPrepay = new HashMap<String, Object>();
			paramsPrepay.put("prepayIds", ids);
			paramsPrepay.put("delFlag", Constants.DelFlag.N);
			List<TransportPrepayApply> prepayList = transportPrepayApplyMapper.getByConditions(paramsPrepay);
			if(null != prepayList && prepayList.size()>0 ){
				bean.setPrepayList(prepayList);
			}
		}*/
		if(null != bean.getScheduleBillNo() && !"".equals(bean.getScheduleBillNo()))
		{
			String scheduleBillNo = bean.getScheduleBillNo();
			Map<String, Object> paramsPrepay = new HashMap<String, Object>();
			paramsPrepay.put("scheduleBillNo", scheduleBillNo);
			paramsPrepay.put("delFlag", Constants.DelFlag.N);
			paramsPrepay.put("orderAsc", "Y");
			List<TransportPrepayApply> prepayList = transportPrepayApplyMapper.getByConditions(paramsPrepay);
			if(null != prepayList && prepayList.size()>0 ){
				bean.setPrepayList(prepayList);
			}
		}
		
		//获取费用核算明细
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentId", bean.getId());
		params.put("delFlag", Constants.DelFlag.N);
		params.put("orderAsc", "Y");
		List<TransportCostApplyDetail> costList = transportCostApplyDetailMapper.getByConditions(params);
		if(null != costList && costList.size()>0 ){
			bean.setCostList(costList);
			
			List<TransportCostCashDetailLog> cashChangeLogList = new ArrayList<TransportCostCashDetailLog>();
			for(int i=0;i<costList.size();i++){
				//获取费用现金明细
				Map<String, Object> paramsCash = new HashMap<String, Object>();
				paramsCash.put("detailId", costList.get(i).getId());
				paramsCash.put("delFlag", Constants.DelFlag.N);
				params.put("orderAsc", "Y");
				List<TransportCostCashDetail> cashList = transportCostCashDetailMapper.getByConditions(paramsCash);
				costList.get(i).setCashList(cashList);
				//获取费用明细变更记录
				List<TransportCostCashDetailLog> cashChangeLog = transportCostCashDetailLogMapper.getByTransportCostCashDetailId(costList.get(i).getId());
				if( null != cashChangeLog && cashChangeLog.size() > 0 ){
					cashChangeLogList.add(cashChangeLog.get(0));
				}
				
				
			}
			bean.setCashChangeLogList(cashChangeLogList);
			
		}
		
		
		//获取任务确认信息
		String processId = commonService.getProcessId(0, Constants.ProcessType.ZYFYHSSQD );////05装运费用核算申请单
		Map<String, Object> paramsTask = new HashMap<String, Object>();
		paramsTask.put("processId", processId);
		paramsTask.put("detailId", id);
		paramsTask.put("delFlag", Constants.DelFlag.N);
		paramsTask.put("successFlag", Constants.SuccessFlag.Y);
		List<TaskHistory> taskList = taskHistoryMapper.getTaskList(paramsTask);
		if(null != taskList && taskList.size()>0 ){
			if( null != driver ){
				taskList.get(0).setOperateUserName(driver.getName() );
			}
			bean.setTaskList(taskList);
		}
		
		return bean;
	}

	@Override
	@SystemServiceLog(description="删除装运费用核算申请信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		//更新申请主表
		transportCostApplyMapper.updateById(params);
	
		Map<String, Object> paramsForDetail = new HashMap<String, Object>();
		paramsForDetail.put("parentId", id);
		paramsForDetail.put("delFlag", Constants.DelFlag.N);
		List<TransportCostApplyDetail> list = transportCostApplyDetailMapper.getByConditions(paramsForDetail);
		if(null != list && list.size()>0 ){
			for(int k=0;k<list.size();k++){
				//删除明细对应的现金表
				Map<String, Object> paramsForDetailCash = new HashMap<String, Object>();
				paramsForDetailCash.put("detailId", list.get(k).getId());
				paramsForDetailCash.put("updateTime", new Date());
				paramsForDetailCash.put("updateUser", oper);
				paramsForDetailCash.put("delFlag", Constants.DelFlag.Y);
				transportCostCashDetailMapper.updateByDetailId(paramsForDetailCash);
			}
		}
		
		//更新明细表
		paramsForDetail = new HashMap<String, Object>();
		paramsForDetail.put("parentId", id);
		paramsForDetail.put("updateTime", new Date());
		paramsForDetail.put("updateUser", oper);
		paramsForDetail.put("delFlag", Constants.DelFlag.Y);
		transportCostApplyDetailMapper.updateByParentId(paramsForDetail);
		
	}

	@Override
	@SystemServiceLog(description="提交装运费用核算申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", Constants.CostApplyStatus.COSTAUDIT);//待费用审核
		//更新申请主表
		transportCostApplyMapper.updateById(params);		
		
		TransportCostApply bean = transportCostApplyMapper.getById(id);
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.ZYFYHSSQD, 
				id, 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName(Constants.ProcessType.ZYFYHSSQD, CommonUtil.getCustomDateToString(bean.getApplyTime(), Constants.DATE_TIME_FORMAT_SHORT) + "_" + bean.getCarNumber())
				);
	}


	@Override
	public List<TransportCostApply> getFinancePrint(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return transportCostApplyMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="导出装运费用核算申请信息")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到装运费用核算申请数据
		params.put("delFlag", Constants.DelFlag.N);
		List<TransportCostApply> detailList = transportCostApplyMapper.getByConditions(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "已提交的装运费用核算申请");//
		sheetData.put("titleMergeSize", 11);//导出数据的列数
	 
		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("报账日期");
		tableHeadList.add("调度单号");
		tableHeadList.add("装运车号");
		tableHeadList.add("主驾驶员");
		tableHeadList.add("副驾驶员");
		tableHeadList.add("公里数");
		tableHeadList.add("运费总成");
		tableHeadList.add("状态");
		tableHeadList.add("创建时间");
		tableHeadList.add("更新时间");
		sheetData.put("tableHeader", tableHeadList);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<detailList.size();i++){
			//获取每一行数据
			TransportCostApply costApply = detailList.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			
			if(costApply.getApplyTime() != null){
				rowData.add( sdf.format(costApply.getApplyTime()) );
			}else{
				rowData.add("");
			}
			
			rowData.add(costApply.getScheduleBillNo());
			rowData.add(costApply.getCarNumber());	
			String driverName = "";
			User driver = userMapper.getById(costApply.getDriverId()) ;
			if( null != driver ){
				driverName = driver.getName();
			}
			rowData.add(driverName);
			rowData.add(costApply.getCodriverName());
			
			rowData.add(String.valueOf(costApply.getDistance()));
			rowData.add((new BigDecimal(costApply.getOilAmount()+"").add(new BigDecimal(costApply.getAmount()+""))).doubleValue()+"");
			
			if(costApply.getStatus().equals(Constants.CostApplyStatus.DIRVERVERIFY)){
				rowData.add("待驾驶员确认");
			}else if(costApply.getStatus().equals(Constants.CostApplyStatus.COSTAUDIT)){
				rowData.add("待费用审核");
			}else if(costApply.getStatus().equals(Constants.CostApplyStatus.OPERVERIFY)){
				rowData.add("待运营部负责人");
			}else if(costApply.getStatus().equals(Constants.CostApplyStatus.CASHAUDIT)){
				rowData.add("待现金会计");
			}else if(costApply.getStatus().equals(Constants.CostApplyStatus.CASHLEADERAUDIT)){
				rowData.add("待财务复核");
			}else if(costApply.getStatus().equals(Constants.CostApplyStatus.PAYVEFIRY)){
				rowData.add("待确认付款");
			}else if(costApply.getStatus().equals(Constants.CostApplyStatus.FINISH)){
				rowData.add("已完成");
			}
			
			if(costApply.getInsertTime() != null){
				rowData.add( sdf.format(costApply.getInsertTime()) );
			}else{
				rowData.add("");
			}
			
			if(costApply.getUpdateTime() !=null){
				rowData.add( sdf.format(costApply.getUpdateTime()) );
			}else{
				rowData.add("");
			}
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}
	
	@Override
	@SystemServiceLog(description="装运费用核算申请审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Integer id, String status, String oper, Map<String, Object> params) throws Exception {
		
		Map<String, Object> newParams = new HashMap<String, Object>();
		newParams.put("id", id);
		newParams.put("updateTime", new Date());
		newParams.put("updateUser", oper);
		newParams.put("status", status);
		transportCostApplyMapper.updateById(newParams);
		
		//更新装运预付申请的状态：4已结算
		TransportCostApply bean = transportCostApplyMapper.getById(id);
		if(null != bean.getPrepayApplyIds() && !bean.getPrepayApplyIds().equals("")){
			Map<String, Object> paramsPrepay = new HashMap<String, Object>();
			paramsPrepay.put("id", bean.getPrepayApplyIds());
			paramsPrepay.put("status", Constants.PrepayApplyStatus.BALANCE);//已结算
			transportPrepayApplyMapper.updateById(paramsPrepay);
		}
		
		//将运输车辆的 距上次保养公里数  加上公里数
		Map<String, Object> paramsUp = new HashMap<String, Object>();
		Map<String, Object> paramsSel = new HashMap<String, Object>();
		paramsSel.put("parentId", id);
		List<TransportCostApplyDetail> list = transportCostApplyDetailMapper.getByConditions(paramsSel);
		if(null != list){
			paramsUp.put("lastDistance", bean.getDistance());
		}
		String carNumber = transportCostApplyMapper.getById(id).getCarNumber();
		paramsUp.put("no", carNumber);
		paramsUp.put("addFlag", "Y");
		trackMapper.updateByNo(paramsUp);
		
		int driverId = bean.getDriverId();
		User user = userMapper.getById(driverId);
		
		//生成油费的油卡支出记录
		double balanceOil = bean.getBalanceOil();
		if( balanceOil > 0 ){
			OilCardOperateLog oilCardOperateLog = new OilCardOperateLog();
			oilCardOperateLog.setMark("驾驶员报销的油费支付【调度单号-"+bean.getScheduleBillNo()+"】");
			oilCardOperateLog.setApplyMoney( balanceOil );
			oilCardOperateLog.setDelFlag(Constants.DelFlag.N);
			oilCardOperateLog.setInsertTime(new Date());
			oilCardOperateLog.setInsertUser(oper);
			oilCardOperateLog.setUpdateTime(new Date());
			oilCardOperateLog.setUpdateUser(oper);
			oilCardOperateLog.setReceiveUserId(driverId+"");
			oilCardOperateLog.setType(Constants.CashInOutType.OUT);
			oilCardOperateLog.setStatus(Constants.OilCardOperateStatus.UNSURE);//待确认
			oilCardOperateLogMapper.insert(oilCardOperateLog);
			
		}
		
		//生成现金的支出记录
		double balanceCash = bean.getBalanceCash();//总结算现金
		double balanceCashNextMonth = bean.getBalanceCashNextMonth();//下月支付现金
//		//折现计算
//		String discountFlag = bean.getDiscountFlag();
//		if( "Y".equals(discountFlag) ){
//			double amount = bean.getAmount();
//			double oilAmount = bean.getOilAmount();
//			double oilDiscountLimit = bean.getOilDiscountLimit();
//			double oilDiscountPoint = bean.getOilDiscountPoint();
//			//可折现的油费数目
//			double canDiscountAmount = (oilAmount > oilDiscountLimit) ? oilDiscountLimit : oilAmount;
//			//折现现金数目
//			double realDiscountAmount = canDiscountAmount * ( 100 - oilDiscountPoint ) / 100;
//			//折现后的油费和现金
////			double realOilAmount = oilAmount - canDiscountAmount;
//			double money = amount + realDiscountAmount;
//			
//		}
		//现金部分
		double cashAmount = CommonUtil.formatDouble(balanceCash-balanceCashNextMonth);
		if( cashAmount > 0 ){
			CashInOut cash = new CashInOut();
			cash.setDepartmentId(user.getDepartmentId());
			cash.setBusinessType(Constants.CashInOutBusinessType.TransportCostDiscount);
			cash.setType(Constants.CashInOutType.OUT);
			cash.setDetailId(bean.getId());
			cash.setMark("驾驶员报销的现金支付【调度单号-"+bean.getScheduleBillNo()+"】");
			cash.setMoney( cashAmount );
			cash.setDelFlag(Constants.DelFlag.N);
			cash.setInsertTime(new Date());
			cash.setInsertUser(oper);
			cash.setUpdateTime(new Date());
			cash.setUpdateUser(oper);
			cash.setStatus(Constants.CashInOutStatus.SUBMIT);
			cash.setSystemFlag(Constants.SystemFlag.Y);
			cashInOutMapper.insert(cash);
			
		}
		//生成待付现金记录
		if( balanceCashNextMonth > 0 ){
			CashWaitingPayLog cashWaitingPay = new CashWaitingPayLog();
			cashWaitingPay.setDepartmentId(user.getDepartmentId());
			cashWaitingPay.setBusinessType(Constants.CashInOutBusinessType.TransportCostDiscount);
			cashWaitingPay.setDetailId(bean.getId());
			cashWaitingPay.setMark("驾驶员报销的折现现金支付【调度单号-"+bean.getScheduleBillNo()+"】");
			cashWaitingPay.setMoney( balanceCashNextMonth );
			cashWaitingPay.setDelFlag(Constants.DelFlag.N);
			cashWaitingPay.setInsertTime(new Date());
			cashWaitingPay.setInsertUser(oper);
			cashWaitingPay.setUpdateTime(new Date());
			cashWaitingPay.setUpdateUser(oper);
			cashWaitingPay.setStatus(Constants.CashInOutStatus.NEW);
			cashWaitingPay.setSystemFlag(Constants.SystemFlag.Y);
			cashWaitingPay.setReceiveUser(driverId);
			cashWaitingPay.setPayTime( CommonUtil.getNextYearMonthTime(new Date()) );
			cashWaitingPayLogMapper.insert(cashWaitingPay);
		}
		
	}

	@Override
	@SystemServiceLog(description="装运费用核算申请审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Integer id, String status, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", status);
		transportCostApplyMapper.updateById(params);
	}
	
	@Override
	@SystemServiceLog(description="装运费用核算申请审核更新")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditForConfirm(Integer id, String status, String oper, Map<String, Object> params) throws Exception {
//		Map<String, Object> newParams = new HashMap<String, Object>();
//		newParams.put("id", id);
//		newParams.put("updateTime", new Date());
//		newParams.put("updateUser", oper);
//		newParams.put("status", status);
		if( null != params ){
			TransportCostApply tca = transportCostApplyMapper.getById(id);
			if( Constants.CostApplyStatus.CASHLEADERAUDIT.equals(status) ){//实际此步骤的操作人为现金会计：实付现金和油费（status为下一个状态）
				if( null == params.get("balanceCash") || StringUtils.isEmpty( params.get("balanceCash").toString() ) ){
					throw new RuntimeException("结算现金不能为空！");
				}
				if( null == params.get("balanceCashNextMonth") || StringUtils.isEmpty( params.get("balanceCashNextMonth").toString() ) ){
					throw new RuntimeException("下月结算现金不能为空！");
				}
				if( null == params.get("balanceOil") || StringUtils.isEmpty( params.get("balanceOil").toString() ) ){
					throw new RuntimeException("结算油费不能为空！");
				}
				double balanceCash = Double.parseDouble( params.get("balanceCash").toString() );
				double balanceCashNextMonth = Double.parseDouble( params.get("balanceCashNextMonth").toString() );
				double balanceOil = Double.parseDouble( params.get("balanceOil").toString() );
				tca.setBalanceCash(balanceCash);
				tca.setBalanceOil(balanceOil);
				tca.setBalanceCashNextMonth(balanceCashNextMonth);
				
			}else if( Constants.CostApplyStatus.DIRVERVERIFY.equals(status) ){//费用审核时，填写公里数、油价、罚款-status为下一个状态
				if( null == params.get("distance") || StringUtils.isEmpty( params.get("distance").toString() ) ){
					throw new RuntimeException("公里数不能为空！");
				}
				if( null == params.get("oilPrice") || StringUtils.isEmpty( params.get("oilPrice").toString() ) ){
					throw new RuntimeException("油价不能为空！");
				}
				if( null == params.get("amerce") || StringUtils.isEmpty( params.get("amerce").toString() ) ){
					throw new RuntimeException("罚款不能为空！");
				}
				
				Map<String, Object> listParams = new HashMap<String, Object>();
				listParams.put("parentId", id );
				listParams.put("delFlag", Constants.DelFlag.N );
				List<TransportCostApplyDetail> costList = transportCostApplyDetailMapper.getByConditions(listParams);
				int detailId = costList.get(0).getId();
				//罚款：公里数*罚款比例(前台)
				double amerce = Double.parseDouble( params.get("amerce").toString() );
				TransportCostCashDetail cash = new TransportCostCashDetail();
				cash.setTransportCostApplyDetailId(detailId);
				cash.setInsertTime(new Date());
				cash.setInsertUser(oper);
				cash.setUpdateTime(new Date());
				cash.setUpdateUser(oper);
				cash.setDelFlag(Constants.DelFlag.N);
				cash.setAmount( amerce );
				cash.setType(Constants.TransportCostApplyDetailType.FINE);
				cash.setName("罚款");
				transportCostCashDetailMapper.insert(cash);
				
				//从运输车辆基本信息表中获取油耗
				Track track = trackMapper.getByCarNumber(tca.getCarNumber());
				if( null == track || null == track.getStandardOilWear() || track.getStandardOilWear().doubleValue() == 0 ){
					throw new RuntimeException("运输车辆的核定油耗数据未设置！");
				}
				
				double standardOilWear = track.getStandardOilWear().doubleValue();
				double distance = Double.parseDouble( params.get("distance").toString() );
				double oilPrice = Double.parseDouble( params.get("oilPrice").toString() );
				//计算油费
				double oilAmount =  distance*standardOilWear*oilPrice;
				
				tca.setStandardOilWear( CommonUtil.formatDouble(standardOilWear) );
				tca.setDistance( CommonUtil.formatDouble(distance)  );
				tca.setOilPrice( CommonUtil.formatDouble(oilPrice) );
				tca.setOilAmount( CommonUtil.formatDouble(oilAmount) );
				
				//计算现金
				double amount = 0;
				Map<String, Object> cashParams = new HashMap<String, Object>();
				cashParams.put("detailId", detailId);
				cashParams.put("delFlag", Constants.DelFlag.N );
				List<TransportCostCashDetail> cashDetailList = transportCostCashDetailMapper.getByConditions(cashParams);
				for(int i=0; i<cashDetailList.size(); i++){
					double cashAmount = cashDetailList.get(i).getAmount();
					amount += cashAmount;
				}
				tca.setAmount( CommonUtil.formatDouble(amount) );
				
				String discountFlag = tca.getDiscountFlag();
				if( "Y".equals(discountFlag) ){//折现
					if( null == track.getOilDiscountLimit() || track.getOilDiscountLimit().doubleValue() == 0 ){
						throw new RuntimeException("运输车辆的折现上限数据未设置！");
					}
					if( null == track.getOilDiscountPoint() || track.getOilDiscountPoint().doubleValue() == 0 ){
						throw new RuntimeException("运输车辆的折现扣点数据未设置！");
					}
					double oilDiscountLimit = track.getOilDiscountLimit().doubleValue();
					double oilDiscountPoint = track.getOilDiscountPoint().doubleValue();
					tca.setOilDiscountLimit( CommonUtil.formatDouble(oilDiscountLimit) );
					tca.setOilDiscountPoint( CommonUtil.formatDouble(oilDiscountPoint) );
					
				}
				
			}
			
			tca.setStatus(status);
			tca.setUpdateTime(new Date());
			tca.setUpdateUser(oper);
			transportCostApplyMapper.update(tca);
//			//费用更改
//			if( null != params.get("cashChangeList") ){
//				@SuppressWarnings("unchecked")
//				List<TransportCostCashDetailLog> logList = (List<TransportCostCashDetailLog>) params.get("cashChangeList");
//				if( null != logList && logList.size() > 0 ){
//					for(int i=0; i<logList.size(); i++){
//						TransportCostCashDetailLog log = logList.get(i);
//						TransportCostCashDetail detail = transportCostCashDetailMapper.getById(log.getTransportCostCashDetailId());
//						if( null != detail ){
//							log.setOldAmount(detail.getAmount());
//						}
//						log.setInsertTime(new Date());
//						log.setInsertUser(oper);
//						log.setUpdateTime(new Date());
//						log.setUpdateUser(oper);
//						log.setDelFlag(Constants.DelFlag.N);
//						transportCostCashDetailLogMapper.insert(log);
//						
//					}
//				}
//			}
			
		}
	}

}
