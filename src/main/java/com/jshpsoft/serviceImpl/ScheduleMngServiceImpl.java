package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarAttachmentStockInOutDetailMapper;
import com.jshpsoft.dao.CarAttachmentStockInOutMapper;
import com.jshpsoft.dao.CarAttachmentStockMapper;
import com.jshpsoft.dao.CarOutStockBillMapper;
import com.jshpsoft.dao.CarShopMapper;
import com.jshpsoft.dao.CarStockInOutDetailMapper;
import com.jshpsoft.dao.CarStockInOutMapper;
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.ItemMapper;
import com.jshpsoft.dao.ScheduleBillChangeApplyMapper;
import com.jshpsoft.dao.ScheduleBillDetailMapper;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.ScheduleTrackChangeApplyMapper;
import com.jshpsoft.dao.TaskHistoryMapper;
import com.jshpsoft.dao.TaskMapper;
import com.jshpsoft.dao.TrackMapper;
import com.jshpsoft.dao.TransportPrepayApplyMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarAttachmentStockInOut;
import com.jshpsoft.domain.CarAttachmentStockInOutDetail;
import com.jshpsoft.domain.CarOutStockBill;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.CarStockInOut;
import com.jshpsoft.domain.CarStockInOutDetail;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleBillChangeApply;
import com.jshpsoft.domain.ScheduleBillDetail;
import com.jshpsoft.domain.ScheduleTrackChangeApply;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarAttachmentStockService;
import com.jshpsoft.service.CarStockMangeService;
import com.jshpsoft.service.ScheduleMngService;
import com.jshpsoft.service.TrackService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("scheduleMngService")
public class ScheduleMngServiceImpl implements ScheduleMngService {
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private ScheduleBillDetailMapper scheduleBillDetailMapper;
	
	@Autowired
	private CarAttachmentStockMapper carAttachmentMngMapper;
	
	@Autowired
	private CarStockMapper carStockMapper;
	
	@Autowired
	private ScheduleTrackChangeApplyMapper scheduleTrackChangeApplyMapper;
	
	@Autowired
	private CarStockMangeService carStockMangeService;
	
	@Autowired
	private CarAttachmentStockService carAttachmentStockService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CarOutStockBillMapper carOutStockBillMapper;
	
	@Autowired
	private TransportPrepayApplyMapper transportPrepayApplyMapper;
	
	@Autowired
	private CarShopMapper carShopMapper;
	
	@Autowired
	private TrackService trackService;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private CarStockInOutMapper carStockInOutMapper;
	
	@Autowired
	private CarStockInOutDetailMapper carStockInOutDetailMapper;
	
	@Autowired
	private CarAttachmentStockInOutMapper carAttachmentStockInOutMapper;
	
	@Autowired
	private CarAttachmentStockMapper carAttachmentStockMapper;
	
	@Autowired
	private CarAttachmentStockInOutDetailMapper carAttachmentStockInOutDetailMapper;
	
	@Autowired
	private ScheduleBillChangeApplyMapper scheduleBillChangeApplyMapper;
	
	@Autowired
	private ItemMapper itemMapper;
	
	@Autowired
	private TaskMapper taskMapper;
	
	@Autowired
	private TaskHistoryMapper taskHistoryMapper;
	
	@Autowired
	private TrackMapper trackMapper;

	@Override
	@SystemServiceLog(description="查询调度单列表信息")
	public Pager<ScheduleBill> getPageData(Map<String, Object> params) throws Exception {
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
		List<ScheduleBill> list = scheduleBillMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				User driver = userMapper.getById(list.get(i).getDriverId()) ;
				if( null != driver ){
					list.get(i).setDriverName( driver.getName() );
				}
			}
		}
		int totalCount = scheduleBillMapper.getPageTotalCount(params);
		
		Pager<ScheduleBill> pager = new Pager<ScheduleBill>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="查询配件列表信息")
	public Pager<CarAttachmentStock> getPageCarAttachmentData(Map<String, Object> params) throws Exception {
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
		List<CarAttachmentStock> list = carAttachmentMngMapper.getPageList(params);
		int totalCount = carAttachmentMngMapper.getPageTotalCount(params);
		
		Pager<CarAttachmentStock> pager = new Pager<CarAttachmentStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增/更新调度单信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(ScheduleBill bean, String oper) throws Exception {
		
		if(null == bean){
			throw new RuntimeException("调度单信息为空");
		}
		
		List<ScheduleBillDetail> detailList = bean.getDetailList();
		if(null == detailList){
			throw new RuntimeException("调度单明细为空");
		}
		
		//保存承运商id
		Track track = trackMapper.getByCarNumber(bean.getCarNumber());
		bean.setOutSourcingId(track.getOutSourcingId());
		
		String scheduleBillNo = bean.getScheduleBillNo();
		if(null== scheduleBillNo || scheduleBillNo.equals("")){//新增
			scheduleBillNo = this.createScheduleBillNo(Integer.parseInt(oper));
			//查询副驾驶员
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			params.put("no", bean.getCarNumber());
			List<Track> list = trackService.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				bean.setCodriverId(list.get(0).getCodriverId());
			}
			//插入表scheduleBill
			bean.setType( Constants.ScheduleBillType.NORMAL);
			bean.setScheduleBillNo(scheduleBillNo);
			bean.setStatus(Constants.ScheduleBillStatus.NEW);//新建
			bean.setInsertTime(new Date());
			bean.setInsertUser(oper);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			bean.setDelFlag(Constants.DelFlag.N);
			scheduleBillMapper.insert(bean);
			
			//插入装运预付申请主表
			TransportPrepayApply prepay = new TransportPrepayApply();
			prepay.setScheduleBillNo(scheduleBillNo);
			prepay.setCarNumber(bean.getCarNumber());
			prepay.setDriverId(bean.getDriverId());
			prepay.setMobile(bean.getMobile());
			prepay.setApplyTime(new Date());
			prepay.setPrepayCash(bean.getPrepayCash());
			prepay.setBankName(bean.getBankName());
			prepay.setBankAccount(bean.getBankAccount());
			prepay.setOilCardNo(bean.getOilCardNo());
			prepay.setOilAmount(bean.getOilAmount());
			prepay.setStatus(Constants.PrepayApplyStatus.NEW);//新建
			prepay.setMark(bean.getMark());
			prepay.setInsertTime(new Date());
			prepay.setInsertUser(oper);
			prepay.setUpdateTime(new Date());
			prepay.setUpdateUser(oper);
			prepay.setDelFlag(Constants.DelFlag.N);
			transportPrepayApplyMapper.insert(prepay);
			
			//插入表scheduleBillDetail
			for(int i=0;i<detailList.size();i++){
				ScheduleBillDetail detail = detailList.get(i);
				if( null != detail.getStartAddress() && !"".equals(detail.getStartAddress())){
					detail.setStartAddress(detail.getStartAddress().trim());
					/*if(!"市".equals(detail.getStartAddress().substring(detail.getStartAddress().length()-1, detail.getStartAddress().length())))
					{
						detail.setStartAddress(detail.getStartAddress()+"市");
					}*/
				}
				if( null != detail.getTargetProvince() ){
					detail.setTargetProvince(detail.getTargetProvince().trim());
				}
				if( null != detail.getTargetCity() ){
					detail.setTargetCity(detail.getTargetCity().trim());
				}
				
				detail.setScheduleBillNo(scheduleBillNo);
				detail.setStatus(Constants.ScheduleDetailStatus.UNFINISH);//未完成
				detail.setInsertTime(new Date());
				detail.setInsertUser(oper);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				scheduleBillDetailMapper.insert(detail);
			}
			
		}else{//编辑更新
			
			//更新表scheduleBill
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			bean.setDelFlag(Constants.DelFlag.N);
			//查询副驾驶员
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			params.put("no", bean.getCarNumber());
			List<Track> list = trackService.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				bean.setCodriverId(list.get(0).getCodriverId());
			}
			scheduleBillMapper.update(bean);
			
			//更新装运预付申请主表
			List<TransportPrepayApply> prepayList = transportPrepayApplyMapper.getByBillNo(scheduleBillNo);
			if(null != prepayList ){
				TransportPrepayApply prepay = prepayList.get(0);
				
				prepay.setCarNumber(bean.getCarNumber());
				prepay.setDriverId(bean.getDriverId());
				prepay.setMobile(bean.getMobile());
				prepay.setPrepayCash(bean.getPrepayCash());
				prepay.setBankName(bean.getBankName());
				prepay.setBankAccount(bean.getBankAccount());
				prepay.setOilCardNo(bean.getOilCardNo());
				prepay.setOilAmount(bean.getOilAmount());
				prepay.setMark(bean.getMark());
				prepay.setUpdateTime(new Date());
				prepay.setUpdateUser(oper);
				transportPrepayApplyMapper.update(prepay);
			}
			
			//删除scheduleBillDetail中的数据
			scheduleBillDetailMapper.delete(scheduleBillNo);
			
			//插入表scheduleBillDetail
			for(int i=0;i<detailList.size();i++){
				ScheduleBillDetail detail = detailList.get(i);
				if( null != detail.getStartAddress() && !"".equals(detail.getStartAddress())){
					detail.setStartAddress(detail.getStartAddress().trim());
					/*if(!"市".equals(detail.getStartAddress().substring(detail.getStartAddress().length()-1, detail.getStartAddress().length())))
					{
						detail.setStartAddress(detail.getStartAddress()+"市");
					}*/
				}
				if( null != detail.getTargetProvince() ){
					detail.setTargetProvince(detail.getTargetProvince().trim());
				}
				if( null != detail.getTargetCity() ){
					detail.setTargetCity(detail.getTargetCity().trim());
				}
				detail.setScheduleBillNo(scheduleBillNo);
				detail.setStatus(Constants.ScheduleDetailStatus.UNFINISH);//未完成
				detail.setInsertTime(new Date());
				detail.setInsertUser(oper);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				scheduleBillDetailMapper.insert(detail);
			}
		}
	}

	@Override
	@SystemServiceLog(description="追加预付信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void addPrepay(TransportPrepayApply bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("追加的装运预付信息为空");
		}
		
		//根据调度单号查询信息
		ScheduleBill sche = scheduleBillMapper.getByBillNo(bean.getScheduleBillNo());
		
		//插入装运预付申请主表
		bean.setCarNumber(sche.getCarNumber());
		bean.setDriverId(sche.getDriverId());
		bean.setMobile(sche.getMobile());
		bean.setApplyTime(new Date());
		bean.setStatus(Constants.PrepayApplyStatus.LEADERAUDIT);//待审核
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		transportPrepayApplyMapper.insert(bean);
		
		TransportPrepayApply preBean = transportPrepayApplyMapper.getById(bean.getId());
		//添加到流程中addToProcessForZyyfsqd    addToProcess
		commonService.addToProcessForZyyfsqd( 
				Constants.ProcessType.ZYYFSQD, 
				bean.getId(), 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName(Constants.ProcessType.ZYYFSQD, CommonUtil.getCustomDateToString(preBean.getApplyTime(), Constants.DATE_TIME_FORMAT_SHORT) + "_" + preBean.getCarNumber())
				,sche
				);
	
	}

	@Override
	@SystemServiceLog(description="删除调度单信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateByBillNo(String scheduleBillNo, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("scheduleBillNo", scheduleBillNo);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		
		scheduleBillMapper.updateByBillNo(params);
		scheduleBillDetailMapper.updateByBillNo(params);
		
		//删除装运预付主表信息
		transportPrepayApplyMapper.updateByBillNo(params);
	}
	
	@Override
	@SystemServiceLog(description="根据调度单号获取调度单详细信息")
	public ScheduleBill getDetailData(String scheduleBillNo) throws Exception {
		
		ScheduleBill bean = scheduleBillMapper.getByBillNo(scheduleBillNo);
		User driver = userMapper.getById(bean.getDriverId()) ;
		if( null != driver ){
			bean.setDriverName( driver.getName() );
		}
		//获取装运信息
		Map<String, Object> params1 = new HashMap<String, Object>();
		params1.put("scheduleBillNo", scheduleBillNo);
		params1.put("delFlag", Constants.DelFlag.N);
		params1.put("orderAsc", "Y");
		List<TransportPrepayApply> preList = transportPrepayApplyMapper.getByConditions(params1);
		if(null != preList && preList.size()>0 ){
			bean.setMobile(preList.get(0).getMobile());
			bean.setPreList(preList);
		}
			
		List<ScheduleBillDetail> detailList = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
		
		if(null != detailList && detailList.size()>0){
			bean.setDetailList(detailList);
			
			for(int i=0; i<detailList.size(); i++){
				ScheduleBillDetail detail = detailList.get(i);
				
				Map<String, Object> params = new HashMap<String, Object>();
				
				//根据carStockIds查询商品车信息
				String carStockIds = detail.getCarStockIds();
				if(null !=carStockIds && !carStockIds.equals("")){
					params.put("carStockIds", carStockIds);
					//params.put("delFlag", Constants.DelFlag.N);
					List<CarStock> carList = carStockMapper.getByConditions(params);
					detail.setCarList(carList);
				}
				
				//根据attachmentIds查询配件信息
				String attachmentIds = detail.getAttachmentIds();
				if(null !=attachmentIds && !attachmentIds.equals("")){
					params.put("attachmentIds", attachmentIds);
					List<CarAttachmentStock> carAttachmentList = carAttachmentMngMapper.getByIds(params);
					
					if(null != carAttachmentList && carAttachmentList.size()>0 ){
						
						String attachmentCounts = detail.getAttachmentCounts();
						if( null != attachmentCounts){
							String[] countArr = attachmentCounts.split(",");
							
							for(int j=0;j<carAttachmentList.size();j++){
								carAttachmentList.get(j).setOutCount(Integer.parseInt(countArr[j]));
							}
							
							detail.setCarAttachmentList(carAttachmentList);
						}
						
					}
				}
				
			}
		}
		
		return bean;
	}

	@SystemServiceLog(description="创建调度单号")
	public String createScheduleBillNo(int userId) throws Exception {
		return commonService.createBusinessBillNo(Constants.BusinessType.DDD, userId);
	}
	
	public String getNextNo(String no){
		
		String result = String.format("%0" + no.length() + "d", Integer.parseInt(no) + 1);
        return result;
	}
	
	@Override
	@SystemServiceLog(description="到达每个4S店确认完成")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void finish(Map<String, Object> params, String oper) throws Exception {
		
		//更新表scheduleBillDetail
		params.put("status", Constants.ScheduleDetailStatus.FINISH);//已完成
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		scheduleBillDetailMapper.updateById(params);
		
		//查询表scheduleBillDetail的状态
		List<ScheduleBillDetail> statusList = scheduleBillDetailMapper.getStatusByBillNo(String.valueOf(params.get("scheduleBillNo")));
		if(null != statusList && statusList.size()==1){
			//更新表scheduleBill
			params.put("status", Constants.ScheduleBillStatus.FINISH);//已完成
			scheduleBillMapper.updateByBillNo(params);
		}
		
	}

	@Override
	@SystemServiceLog(description="调度单确认完成")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void finishAll(Map<String, Object> params, String oper) throws Exception {
		
		//更新表scheduleBill
		params.put("status", Constants.ScheduleBillStatus.FINISH);//已完成
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		scheduleBillMapper.updateByBillNo(params);
		
		//更新表scheduleBillDetail
		params.put("status", Constants.ScheduleDetailStatus.FINISH);//已完成
		scheduleBillDetailMapper.updateByBillNo(params);
	}
	
	@Override
	@SystemServiceLog(description="新增换车申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void trackChangeApply(ScheduleTrackChangeApply bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("换车申请信息为空");
		}
		
		//验证该换车申请是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("scheduleBillNo", bean.getScheduleBillNo());
		params.put("oldCarNumber", bean.getOldCarNumber());
		params.put("delFlag", Constants.DelFlag.N);
		List<ScheduleTrackChangeApply> list = scheduleTrackChangeApplyMapper.getByConditions(params);
		if(null !=list && list.size()>0){
			throw new RuntimeException("该换车申请已存在，请检查");
		}
		
		bean.setStatus(Constants.TrackChangeStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		scheduleTrackChangeApplyMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="提交调度单")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(String scheduleBillNo, String oper) throws Exception {
			
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("scheduleBillNo", scheduleBillNo);
		params.put("status", Constants.ScheduleBillStatus.UNSURE);//1待复核
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		//更新表scheduleBill
		scheduleBillMapper.updateByBillNo(params);
		
		ScheduleBill scheduleBill = scheduleBillMapper.getByBillNo(scheduleBillNo);
		
		//更新装运预付申请主表
		List<TransportPrepayApply> prepay = transportPrepayApplyMapper.getByBillNo(scheduleBillNo);
		if(null != prepay ){
			for(int i=0;i<prepay.size();i++){
				Map<String, Object> paramsPre = new HashMap<String, Object>();
				paramsPre.put("id", prepay.get(i).getId());
				paramsPre.put("updateTime", new Date());
				paramsPre.put("updateUser", oper);
				paramsPre.put("status", Constants.PrepayApplyStatus.LEADERAUDIT);//待审核

				transportPrepayApplyMapper.updateById(paramsPre);
				
				//添加到流程中-装运预付申请
				TransportPrepayApply prepayApply = prepay.get(i);
				commonService.addToProcessForZyyfsqd( 
					Constants.ProcessType.ZYYFSQD, 
					prepayApply.getId(), 
					Integer.parseInt(oper), 
					CommonUtil.getProcessName(Constants.ProcessType.ZYYFSQD, CommonUtil.getCustomDateToString(prepayApply.getApplyTime(), Constants.DATE_TIME_FORMAT_SHORT) + "_" + scheduleBill.getCarNumber()),
					scheduleBill
				);
			}
		}
		
//		//商品车出库提交
//		carStockMangeService.carOutSubmit(scheduleBillNo, oper);
//		
//		//配件出库提交
//		Map<String, Object> attParams = new HashMap<String, Object>();
//		attParams.put("scheduleBillNo", scheduleBillNo);
//		attParams.put("userId", oper);
//		carAttachmentStockService.submitSchedule(attParams);
		
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.DDD, 
				scheduleBill.getId(), 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName(Constants.ProcessType.DDD, scheduleBillNo)
				);
		
		//发送消息给驾驶员
		//根据车号，获取下一步接收人为：驾驶员
		Track t = trackService.getByCarNumber(scheduleBill.getCarNumber());
		if( null == t ){
			throw new RuntimeException("装运车辆信息不存在！");
		}

		int nextUserId = t.getDriverId();

		String content = "新消息：您有一条新调度任务！[调度单号-"+ scheduleBillNo + ",装运车号-" + scheduleBill.getCarNumber()+"]";
		commonService.pushMsgToUser( nextUserId, content );
		
	}
	
	@Override
	@SystemServiceLog(description="调度单审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(String scheduleBillNo, String status, String oper)
			throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("scheduleBillNo", scheduleBillNo);
		params.put("status", status);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		//更新表scheduleBill的状态
		scheduleBillMapper.updateByBillNo(params);
		
		ScheduleBill sb = scheduleBillMapper.getByBillNo(scheduleBillNo);
		if( Constants.ScheduleBillType.NORMAL.equals(sb.getType()) ){//正常调度处理
			//商品车出库审核通过
			carStockMangeService.carOutVerifySuccess(scheduleBillNo, oper);
			
			//配件出库审核通过
			Map<String, Object> attParams = new HashMap<String, Object>();
			attParams.put("scheduleBillNo", scheduleBillNo);
			attParams.put("userId", oper);
			carAttachmentStockService.checkedSchedule(attParams);
			
		}else{//快速调度处理
			//将商品车或二手车、配件出库
			this.outStockForFastSchedule(scheduleBillNo, oper);
			
		}
		
	}

	@Override
	@SystemServiceLog(description="根据快速调度单详细进行出库动作")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void outStockForFastSchedule(String scheduleBillNo, String oper)throws Exception  {
		ScheduleBill sb = scheduleBillMapper.getByBillNo(scheduleBillNo);
		//调度明细表
		List<ScheduleBillDetail> sbDetailList = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
		if( null != sbDetailList && sbDetailList.size() > 0 ){
			
			int carAmount =0;
			int carAttachAmount = 0;
			for(int i=0; i<sbDetailList.size(); i++){
				ScheduleBillDetail sbDetail = sbDetailList.get(i);
				if( Constants.ScheduleBillDetailType.SPC == sbDetail.getType() || Constants.ScheduleBillDetailType.ESC == sbDetail.getType() ){//商品车或二手车
					carAmount += sbDetail.getAmount();
				}else{//配件
					carAttachAmount += sbDetail.getAmount();
				}
				
			}
			
			CarStockInOut carStockOut = new CarStockInOut();
			if( carAmount > 0 ){
				//插入商品车出库主表
				carStockOut.setType(Constants.CarType.OUT);//出库
				carStockOut.setBusinessId( sb.getId() );//调度id
				carStockOut.setStockId( sb.getStockId() );
				carStockOut.setCount( carAmount );
				carStockOut.setStatus(Constants.CarInOutStatus.FINISH);//已完成
				carStockOut.setInsertTime( new Date() );
				carStockOut.setInsertUser( oper ) ;
				carStockOut.setUpdateTime( new Date() );
				carStockOut.setUpdateUser( oper );
				carStockOut.setDelFlag(Constants.DelFlag.N);
				carStockInOutMapper.insert(carStockOut);
				
			}
			CarAttachmentStockInOut carAttachmentStockOut = new CarAttachmentStockInOut();
			if( carAttachAmount > 0 ){
				//插入配件出库主表
				carAttachmentStockOut.setType(Constants.CarAttchmentType.CHU);
				carAttachmentStockOut.setStockId(sb.getStockId());
				carAttachmentStockOut.setBusinessId(sb.getId());//调度id
				carAttachmentStockOut.setCount( carAttachAmount );
				carAttachmentStockOut.setStatus(String.valueOf(Constants.CarAttchmentStockInOutStatus.FINISH));
				carAttachmentStockOut.setInsertTime(new Date());
				carAttachmentStockOut.setInsertUser(oper);
				carAttachmentStockOut.setUpdateTime(new Date());
				carAttachmentStockOut.setUpdateUser(oper);
				carAttachmentStockOut.setDelFlag(Constants.DelFlag.N);
				carAttachmentStockInOutMapper.save(carAttachmentStockOut);
			}
			for(int i=0; i<sbDetailList.size(); i++){
				ScheduleBillDetail sbDetail = sbDetailList.get(i);
				if( Constants.ScheduleBillDetailType.SPC == sbDetail.getType() || Constants.ScheduleBillDetailType.ESC == sbDetail.getType() ){//商品车或二手车
					String carStockIds = sbDetailList.get(i).getCarStockIds();
					if( StringUtils.isNotEmpty(carStockIds) ){
						String[] carStockIdArr = carStockIds.split(",");
						for(int m=0; m<carStockIdArr.length;m++ ){
							String carStockId = carStockIdArr[m];
							CarStock carStock = carStockMapper.getById(Integer.parseInt(carStockId));
							if( null != carStock ){
								//插入商品车出库明细
								CarStockInOutDetail carStockOutDetail = new CarStockInOutDetail();
								carStockOutDetail.setParentId(carStockOut.getId());//carStockOut的id
								carStockOutDetail.setBusinessId( sb.getId() );//调度id
								carStockOutDetail.setStockId(carStock.getStockId());
								if( Constants.ScheduleBillDetailType.SPC == sbDetail.getType() ){
									carStockOutDetail.setType(Constants.CarStockType.SPC);
								}else{
									carStockOutDetail.setType(Constants.CarStockType.ESC);
								}
								carStockOutDetail.setBrand(carStock.getBrand());
								carStockOutDetail.setVin(carStock.getVin());
								carStockOutDetail.setMark(carStock.getMark());
								carStockOutDetail.setInsertTime(new Date());
								carStockOutDetail.setInsertUser(oper);
								carStockOutDetail.setUpdateTime(new Date());
								carStockOutDetail.setUpdateUser(oper);
								carStockOutDetail.setDelFlag(Constants.DelFlag.N);
								carStockInOutDetailMapper.insert(carStockOutDetail);
								
								//出库
								carStock.setStatus(Constants.CarStatus.HASOUT);
								carStock.setUpdateTime(new Date());
								carStock.setUpdateUser(oper);
								carStockMapper.update(carStock);
							}
							
						}
						
					}
					
				}else{//配件
					//插入配件出库明细
					CarAttachmentStockInOutDetail carAttachmentStockOutDetail = new CarAttachmentStockInOutDetail();
					carAttachmentStockOutDetail.setParentId(carAttachmentStockOut.getId());
					carAttachmentStockOutDetail.setBusinessId(  sb.getId() );//调度id
					carAttachmentStockOutDetail.setStockId( sb.getStockId() );
					carAttachmentStockOutDetail.setType(Constants.CarAttchmentType.CHU );//出库
					CarAttachmentStock carAttachmentStock = carAttachmentStockMapper.getById( Integer.parseInt(sbDetail.getAttachmentIds()) );
					carAttachmentStockOutDetail.setAttachmentName( carAttachmentStock.getAttachmentName() );
					carAttachmentStockOutDetail.setCount(sbDetail.getCount());
					carAttachmentStockOutDetail.setInsertTime( new Date() );
					carAttachmentStockOutDetail.setUpdateTime( new Date() );
					carAttachmentStockOutDetail.setInsertUser( oper );
					carAttachmentStockOutDetail.setUpdateUser( oper );
					carAttachmentStockOutDetail.setDelFlag(Constants.DelFlag.N);//
					carAttachmentStockInOutDetailMapper.save(carAttachmentStockOutDetail);
					
					//出库
					carAttachmentStock.setStatus(Constants.CarStatus.HASOUT);
					carAttachmentStock.setUpdateTime(new Date());
					carAttachmentStock.setUpdateUser(oper);
					carAttachmentStockMapper.update(carAttachmentStock);
				}
				
			}
		}
			

		
		
		
		
		
	}

	@Override
	@SystemServiceLog(description="调度单审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(int detailId, int status, int operId)
			throws Exception {
		
		auditForConfirm(detailId, status, operId);
		
	}

	@Override
	public void auditForConfirm(int detailId, int status, int operId) throws Exception {
		ScheduleBill sb = scheduleBillMapper.getById( detailId );
		if( Constants.ScheduleBillType.FAST.equals( sb.getType() ) ){//快速调度，审核不通过时，需要打开，然后可直接修改
			sb.setModifyEnabledFlag("Y");
		}
		sb.setStatus( status+"" );
		sb.setUpdateTime(new Date());
		sb.setUpdateUser(operId+"");
		scheduleBillMapper.update( sb );
		
	}

	@Override
	@SystemServiceLog(description="获取调度单信息")
	public List<ScheduleBill> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		List<ScheduleBill> list = scheduleBillMapper.getByConditions(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				User driver = userMapper.getById(list.get(i).getDriverId()) ;
				if( null != driver ){
					list.get(i).setDriverName( driver.getName() );
				}
			}
		}

		return list;
	}

	@Override
	@SystemServiceLog(description="获取商品车出库单数据")
	public List<CarOutStockBill> getCarOutStockBillData(String scheduleBillNo)
			throws Exception {
		return carOutStockBillMapper.getOutBillPrintData(scheduleBillNo);
	}

	@Override
	@SystemServiceLog(description="查询仓管员、驾驶员调度单列表信息")
	public Pager<ScheduleBill> getOwnPageData(Map<String, Object> params) throws Exception {
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
		List<ScheduleBill> list = scheduleBillMapper.getOwnPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				User driver = userMapper.getById(list.get(i).getDriverId()) ;
				if( null != driver ){
					list.get(i).setDriverName( driver.getName() );
				}
			}
		}
		int totalCount = scheduleBillMapper.getOwnPageTotalCount(params);
		
		Pager<ScheduleBill> pager = new Pager<ScheduleBill>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="获取调度单信息")
	public ScheduleBill getEnabledScheduleBillInfo(Map<String, Object> params)
			throws Exception {
		ScheduleBill bean = null;
		
		List<ScheduleBill> list = scheduleBillMapper.getEnabledScheduleBillInfo(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				ScheduleBill sb = list.get(i);
				
				String status = sb.getTransportCostApplyStatus();
				if(Constants.CostApplyStatus.FINISH.equals(status) ){
					continue;
				}else if(StringUtils.isEmpty(status)){//没有审核中的驾驶员报销时(不包含新建状态，不然可以重复保存)
					bean = sb;
					break;
				}else{//有审核中的驾驶员报销时，则返回null
					break;
				}
			}
		}
		//bean = scheduleBillMapper.getByBillNo("YCLL201701130002");
		//获取调度单中4s店的品牌、省份、城市
		if( null != bean ){
			List<ScheduleBillDetail> detailList = scheduleBillDetailMapper.getByBillNo(bean.getScheduleBillNo());
			if( null != detailList && detailList.size() > 0 ){
				Integer carShopId = detailList.get(0).getCarShopId();
				CarShop carShop = carShopMapper.getById(carShopId);
				if( null != carShop ){
					bean.setStartAddress(carShop.getProvince());
					bean.setEndAddress(carShop.getCity());
					
				}
				//品牌
				String carStockIds = detailList.get(0).getCarStockIds();
				if( StringUtils.isNotEmpty(carStockIds) ){
					String carStockId = carStockIds.split(",")[0];
					CarStock carStock = carStockMapper.getById(Integer.parseInt(carStockId));
					if( null != carStock ){
						bean.setBrand(carStock.getBrand());
					}
					
				}
				
			}
			
			//获取预付信息
			Map<String, Object> params1 = new HashMap<String, Object>();
			params1.put("scheduleBillNo", bean.getScheduleBillNo());
			params1.put("delFlag", Constants.DelFlag.N);
			params1.put("orderAsc", "Y");
			List<TransportPrepayApply> preList = transportPrepayApplyMapper.getByConditions(params1);
			if(null != preList && preList.size()>0 ){
				bean.setPreList(preList);
			}
		}
		
					
		return bean;
	}

	@Override
	@SystemServiceLog(description="新增/修改快速调度单信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void saveForFast(ScheduleBill bean, int operId) throws Exception {
		if(null == bean){
			throw new RuntimeException("调度单信息不能为空！");
		}
		
		List<ScheduleBillDetail> detailList = bean.getDetailList();
		if(null == detailList){
			throw new RuntimeException("调度单明细不能为空");
		}
		
		String scheduleBillNo = bean.getScheduleBillNo();
		if(StringUtils.isEmpty( scheduleBillNo )){
			throw new RuntimeException("调度单号不能为空");
		}
		
		if(StringUtils.isEmpty( bean.getCarNumber() )){
			throw new RuntimeException("装运车号不能为空");
		}
		
		if( 0 == bean.getDriverId() ){
			throw new RuntimeException("驾驶员信息不能为空");
		}
		
		//根据配置确定是否走流程
		String needProcessFlag = commonService.getConfigValue(0, Constants.BasicConfigName.FAST_SCHEDULE_USE_PROCESS);
		
		//保存承运商id
		Track track = trackMapper.getByCarNumber(bean.getCarNumber());
		bean.setOutSourcingId(track.getOutSourcingId());
		
		int amount = 0;
		if( null == bean.getId() || 0 == bean.getId() ){//新增
			bean.setType( Constants.ScheduleBillType.FAST);//快速调度
			bean.setStatus(Constants.ScheduleBillStatus.UNSURE);//仓管员确认
			bean.setInsertTime(new Date());
			bean.setInsertUser( operId+"" );
			bean.setUpdateTime(new Date());
			bean.setUpdateUser( operId+"" );
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setModifyEnabledFlag("N");
			//查询副驾驶员
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			params.put("no", bean.getCarNumber());
			List<Track> list = trackService.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				bean.setCodriverId(list.get(0).getCodriverId());
			}
			scheduleBillMapper.insert(bean);
			
			ScheduleBill scheduleBill = scheduleBillMapper.getByBillNo(scheduleBillNo);
			
			//插入调度明细数据
			amount = addScheduleDataForFast(bean, operId);
			scheduleBill.setAmount(amount);
			scheduleBillMapper.update(scheduleBill);
			
			if( "Y".equals(needProcessFlag) ){
				//发起调度流程
				commonService.addToProcess( 
						Constants.ProcessType.DDD, 
						scheduleBill.getId(), 
						operId, 
						CommonUtil.getProcessName(Constants.ProcessType.DDD, scheduleBillNo)
						);
				
				//发送消息给驾驶员
				//根据车号，获取下一步接收人为：驾驶员
				Track t = trackService.getByCarNumber(scheduleBill.getCarNumber());
				if( null == t ){
					throw new RuntimeException("装运车辆信息不存在！");
				}
				int nextUserId = t.getDriverId();
				String content = "新消息：您有一条新调度任务！[调度单号-"+ scheduleBillNo + ",装运车号-" + scheduleBill.getCarNumber()+"]";
				commonService.pushMsgToUser( nextUserId, content );
				
			}else{
				//不走流程，自动做出库动作
				outStockForFastSchedule(scheduleBillNo, operId+"");
				
				//发起调度流程
				commonService.addToProcessForFastSchedule( 
						Constants.ProcessType.DDD, 
						scheduleBill.getId(), 
						operId, 
						CommonUtil.getProcessName(Constants.ProcessType.DDD, scheduleBillNo)
						);
				
				//发送消息给驾驶员
				//根据车号，获取下一步接收人为：驾驶员
				Track t = trackService.getByCarNumber(scheduleBill.getCarNumber());
				if( null == t ){
					throw new RuntimeException("装运车辆信息不存在！");
				}
				int nextUserId = t.getDriverId();
				String content = "新消息：您有一条新调度任务！[调度单号-"+ scheduleBillNo + ",装运车号-" + scheduleBill.getCarNumber()+"]";
				commonService.pushMsgToUser( nextUserId, content );
				
				scheduleBill.setStatus(Constants.ScheduleBillStatus.UNSURE_DRIVER);//驾驶员确认
				scheduleBillMapper.update(scheduleBill);
				
			}
			
			//插入装运预付申请主表
			if( null != bean.getPrepayCash() ||  null != bean.getOilAmount() ){
				TransportPrepayApply prepay = new TransportPrepayApply();
				prepay.setScheduleBillNo(scheduleBillNo);
				prepay.setCarNumber(bean.getCarNumber());
				prepay.setDriverId(bean.getDriverId());
				prepay.setMobile(bean.getMobile());
				if( null != bean.getPrepayTime() ){
					prepay.setApplyTime( bean.getPrepayTime() );
				}else{
					prepay.setApplyTime(new Date());
				}
				prepay.setPrepayCash(bean.getPrepayCash());
				prepay.setBankName(bean.getBankName());
				prepay.setBankAccount(bean.getBankAccount());
				prepay.setOilCardNo(bean.getOilCardNo());
				prepay.setOilAmount(bean.getOilAmount());
				prepay.setStatus(Constants.PrepayApplyStatus.CASHAUDIT);//现金预核
				prepay.setMark(bean.getMark());
				prepay.setInsertTime(new Date());
				prepay.setInsertUser( operId+"" );
				prepay.setUpdateTime(new Date());
				prepay.setUpdateUser( operId+"" );
				prepay.setDelFlag(Constants.DelFlag.N);
				transportPrepayApplyMapper.insert(prepay);
				
				//发起预付流程
				commonService.addToProcessForZyyfsqd( 
						Constants.ProcessType.ZYYFSQD, 
						prepay.getId(), 
						operId, 
						CommonUtil.getProcessName(Constants.ProcessType.ZYYFSQD, CommonUtil.getCustomDateToString(prepay.getApplyTime(), Constants.DATE_TIME_FORMAT_SHORT) + "_" + scheduleBill.getCarNumber()),
						scheduleBill
						);
				
			}
			
		}else{//编辑
			
			ScheduleBill scheduleBill = scheduleBillMapper.getById( bean.getId() );
			//是否可以修改标记
			String modifyEnabledFlag = scheduleBill.getModifyEnabledFlag();
			//判断是否可以修改：如果insertUser=当前用户 & modifyEnabledFlag = Y
			if( operId != Integer.parseInt(scheduleBill.getInsertUser()) || !"Y".equals(modifyEnabledFlag) ){
				throw new RuntimeException("没有修改权限，请先申请修改！");
			}
			
			//更新调度表
			scheduleBill.setSendTime(bean.getSendTime());
			scheduleBill.setCarNumber(bean.getCarNumber());
			scheduleBill.setDriverId(bean.getDriverId());
			scheduleBill.setAmount(bean.getAmount());
			scheduleBill.setUpdateTime(new Date());
		  	scheduleBill.setUpdateUser( operId+"" );
		    //查询副驾驶员
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			params.put("no", bean.getCarNumber());
			List<Track> list = trackService.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				bean.setCodriverId(list.get(0).getCodriverId());
			}
			scheduleBillMapper.update(scheduleBill);
			
			//删除调度明细表
			List<ScheduleBillDetail> sbDetailList = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
			if( null != sbDetailList && sbDetailList.size() > 0 ){
				for(int m=0; m<sbDetailList.size(); m++){
					ScheduleBillDetail sbDetail = sbDetailList.get(m);
					sbDetail.setUpdateTime( new Date() );
					sbDetail.setUpdateUser(operId+"");
					sbDetail.setDelFlag(Constants.DelFlag.Y);
					scheduleBillDetailMapper.update(sbDetail);
				}
			}
			
			//删除明细信息
			Map<String, Object> waybillParams = new HashMap<String, Object>();
			waybillParams.put("scheduleBillNo", scheduleBillNo);
			waybillParams.put("delFlag", Constants.DelFlag.N);
			List<Waybill> oldWaybillList = waybillMapper.getByConditions(waybillParams);
			if( null != oldWaybillList && oldWaybillList.size() > 0 ){
				for(int m=0; m<oldWaybillList.size(); m++){
					//删除运单表
					Waybill waybill = oldWaybillList.get(m);
					waybill.setUpdateTime(CommonUtil.format(new Date(), Constants.DATE_TIME_FORMAT));
					waybill.setUpdateUser(operId+"");
					waybill.setDelFlag(Constants.DelFlag.Y);
					waybillMapper.updateWaybill(waybill);
					
					//删除运单涉及的：商品车和二手车的库存表，入库表
					Map<String, Object> carStockParams = new HashMap<String, Object>();
					carStockParams.put("waybillId", waybill.getId());
					carStockParams.put("delFlag", Constants.DelFlag.N);
					List<CarStock> carStockList = carStockMapper.getByConditions(carStockParams);
					if( null != carStockList && carStockList.size() > 0 ){
						for(int n=0; n<carStockList.size(); n++){
							CarStock carStock = carStockList.get(n);
							carStock.setUpdateTime( new Date() );
							carStock.setUpdateUser(operId+"");
							carStock.setDelFlag(Constants.DelFlag.Y);
							carStockMapper.update(carStock);
							
						}
					}
					//删除商品车和二手车的入库表
					Map<String, Object> carStockInParams = new HashMap<String, Object>();
					carStockInParams.put("businessId", waybill.getId());
					carStockInParams.put("delFlag", Constants.DelFlag.N);
					carStockInParams.put("type", Constants.CarType.IN);
					List<CarStockInOut> carStockInList = carStockInOutMapper.getByConditions(carStockInParams);
					if( null != carStockInList && carStockInList.size() > 0 ){
						CarStockInOut carStockIn = carStockInList.get(0);
						carStockIn.setUpdateTime( new Date() );
						carStockIn.setUpdateUser(operId+"");
						carStockIn.setDelFlag(Constants.DelFlag.Y);
						carStockInOutMapper.update(carStockIn);
						
						Map<String, Object> carStockInDetailParams = new HashMap<String, Object>();
						carStockInDetailParams.put("businessId", waybill.getId());
						carStockInDetailParams.put("updateTime", new Date());
						carStockInDetailParams.put("udpateUser", operId+"");
						carStockInDetailParams.put("delFlag", Constants.DelFlag.Y);
						carStockInOutDetailMapper.updateByBusinessId(carStockInDetailParams);
					}
					
					//删除商品车和二手车的出库表
					Map<String, Object> carStockOutParams = new HashMap<String, Object>();
					carStockOutParams.put("businessId", scheduleBill.getId());
					carStockOutParams.put("delFlag", Constants.DelFlag.N);
					carStockOutParams.put("type", Constants.CarType.OUT);
					List<CarStockInOut> carStockOutList = carStockInOutMapper.getByConditions(carStockOutParams);
					if( null != carStockOutList && carStockOutList.size() > 0 ){
						CarStockInOut carStockOut = carStockOutList.get(0);
						carStockOut.setUpdateTime( new Date() );
						carStockOut.setUpdateUser(operId+"");
						carStockOut.setDelFlag(Constants.DelFlag.Y);
						carStockInOutMapper.update(carStockOut);
						
						Map<String, Object> carStockOutDetailParams = new HashMap<String, Object>();
						carStockOutDetailParams.put("businessId", scheduleBill.getId());
						carStockOutDetailParams.put("updateTime", new Date());
						carStockOutDetailParams.put("udpateUser", operId+"");
						carStockOutDetailParams.put("delFlag", Constants.DelFlag.Y);
						carStockInOutDetailMapper.updateByBusinessId(carStockOutDetailParams);
					}
					
					//删除配件库存表
					Map<String, Object> carAttachmentParams = new HashMap<String, Object>();
					carAttachmentParams.put("waybillId", waybill.getId());
					carAttachmentParams.put("delFlag", Constants.DelFlag.N);
					List<CarAttachmentStock> carAttachmentStockList = carAttachmentStockMapper.getByConditions(carAttachmentParams);
					if( null != carAttachmentStockList && carAttachmentStockList.size() > 0 ){
						for(int n=0; n<carAttachmentStockList.size(); n++){
							CarAttachmentStock carAttahcmentStock = carAttachmentStockList.get(n);
							carAttahcmentStock.setUpdateTime( new Date() );
							carAttahcmentStock.setUpdateUser(operId+"");
							carAttahcmentStock.setDelFlag(Constants.DelFlag.Y);
							carAttachmentStockMapper.update(carAttahcmentStock);
							
						}
					}
					
					//删除配件入库表
					Map<String, Object> carAttachmentStockInParams = new HashMap<String, Object>();
					carAttachmentStockInParams.put("businessId", waybill.getId());
					carAttachmentStockInParams.put("type", Constants.CarType.IN);
					carAttachmentStockInParams.put("updateTime", new Date());
					carAttachmentStockInParams.put("udpateUser", operId+"");
					carAttachmentStockInParams.put("delFlag", Constants.DelFlag.Y);
					carAttachmentStockInOutMapper.deleteByBusinessId(carAttachmentStockInParams);
					carAttachmentStockInOutDetailMapper.deleteByBusinessId(carAttachmentStockInParams);
					
					//删除配件出库表
					Map<String, Object> carAttachmentStockOutParams = new HashMap<String, Object>();
					carAttachmentStockOutParams.put("businessId", scheduleBill.getId());
					carAttachmentStockOutParams.put("type", Constants.CarType.OUT);
					carAttachmentStockOutParams.put("updateTime", new Date());
					carAttachmentStockOutParams.put("udpateUser", operId+"");
					carAttachmentStockOutParams.put("delFlag", Constants.DelFlag.Y);
					carAttachmentStockInOutMapper.deleteByBusinessId(carAttachmentStockOutParams);
					carAttachmentStockInOutDetailMapper.deleteByBusinessId(carAttachmentStockOutParams);
					
				}
			}
			
			//插入调度明细数据
			amount = this.addScheduleDataForFast(bean, operId);
			
			//如果调度单的状态不为仓管员确认，则需要插入出库表
			String status = scheduleBill.getStatus();
			if( !Constants.ScheduleBillStatus.UNSURE.equals(status) ){
				this.outStockForFastSchedule(scheduleBillNo, operId+"");
			}

			//更新修改标记
			scheduleBill.setModifyEnabledFlag("N");
			scheduleBill.setAmount(amount);
			scheduleBillMapper.update(scheduleBill);
			
			//更新申请修改状态为已修改
			Map<String, Object> changeApplyParams = new HashMap<String, Object>();
			changeApplyParams.put("scheduleBillNo", scheduleBillNo);
			changeApplyParams.put("delFlag", Constants.DelFlag.N);
			changeApplyParams.put("status", Constants.ScheduleBillChangeApplyStatus.PASS);
			List<ScheduleBillChangeApply> changeApplyList = scheduleBillChangeApplyMapper.getByConditions(changeApplyParams);
			if( null != changeApplyList && changeApplyList.size() > 0 ){
				ScheduleBillChangeApply changeApply = changeApplyList.get(0);
				changeApply.setUpdateTime(new Date());
				changeApply.setUpdateUser(operId+"");
				changeApply.setStatus(Constants.ScheduleBillChangeApplyStatus.FINISH);
				scheduleBillChangeApplyMapper.update(changeApply);
				
			}
			
			if( "Y".equals(needProcessFlag) && Constants.ScheduleBillStatus.NEW.equals(scheduleBill.getStatus()) ){//如果当前走流程，并且被仓管员审核不通过时再次保存，需要继续流程
				//发起调度流程
				commonService.addToProcessForFastSchedule( 
						Constants.ProcessType.DDD, 
						scheduleBill.getId(), 
						operId, 
						CommonUtil.getProcessName(Constants.ProcessType.DDD, scheduleBillNo)
						);
				
			}
			
		}
		
	}

	private int addScheduleDataForFast(ScheduleBill bean, int operId) throws Exception {
		String scheduleBillNo = bean.getScheduleBillNo();
		List<ScheduleBillDetail> detailList = bean.getDetailList();
		int amount = 0;
		
		for(int i=0;i<detailList.size();i++){
			ScheduleBillDetail detail = detailList.get(i);
			if( null != detail.getStartAddress() && !"".equals(detail.getStartAddress())){
				detail.setStartAddress(detail.getStartAddress().trim());
				/*if(!"市".equals(detail.getStartAddress().substring(detail.getStartAddress().length()-1, detail.getStartAddress().length())))
				{
					detail.setStartAddress(detail.getStartAddress()+"市");
				}*/
			}
			
			int type = detail.getType();
			if( Constants.ScheduleBillDetailType.SPC == type || Constants.ScheduleBillDetailType.ESC == type ){//商品车或二手车
				amount += detail.getCount();
				//4S店信息是否需要新增
				Integer carShopId = detail.getCarShopId();
				String carShopName = detail.getCarShopName();
				if( (null == carShopId || 0 == carShopId) && StringUtils.isNotEmpty(carShopName) ){//4S店需新增
					CarShop carShop = new CarShop();
					carShop.setName(carShopName);
					carShop.setPy( commonService.getPyCode(carShopName) );
					carShop.setWb( commonService.getWbCode(carShopName) );
					carShop.setInsertTime(new Date());
					carShop.setInsertUser(operId+"");
					carShop.setUpdateTime(new Date());
					carShop.setUpdateUser(operId+"");
					carShop.setDelFlag(Constants.DelFlag.N);
					carShopMapper.insert(carShop);
					carShopId = carShop.getId();
					
				}
				
				//插入运单表
				Waybill wayBill = new Waybill();
				
				//没有运单号时，重新生成运单号
				if( StringUtils.isEmpty( detail.getWaybillNo() ) ){
					String waybillNo = commonService.createBusinessBillNo(Constants.BusinessType.YD, operId);
					wayBill.setWaybillNo( waybillNo );
				}else{
					wayBill.setWaybillNo( detail.getWaybillNo() );
				}
				detail.setWaybillNo(wayBill.getWaybillNo());
				
				if( 0 == type ){
					wayBill.setType(Constants.WaybillType.SPC);
				}else{
					wayBill.setType(Constants.WaybillType.ESC);
					wayBill.setMark(detail.getMark());
				}
				wayBill.setStockId( bean.getStockId() );
				wayBill.setBrand(detail.getBrandName());
				wayBill.setCarShopId(carShopId);
				wayBill.setSendTime( CommonUtil.format(detail.getSendTime(), Constants.DATE_TIME_FORMAT));
				wayBill.setArrivalTime( CommonUtil.format(detail.getArrivalTime(), Constants.DATE_TIME_FORMAT));
				wayBill.setStatus(Constants.WaibillStatus.UNRECEIPT.getValue());//待回执
				wayBill.setInsertTime( CommonUtil.format(new Date(), Constants.DATE_TIME_FORMAT) );
				wayBill.setInsertUser(operId+"");
				wayBill.setUpdateTime( CommonUtil.format(new Date(), Constants.DATE_TIME_FORMAT) );
				wayBill.setUpdateUser(operId+"");
				wayBill.setDelFlag(Constants.DelFlag.N);
				wayBill.setScheduleBillNo(scheduleBillNo);
				if( null != detail.getStartAddress() ){
					wayBill.setStartAddress(detail.getStartAddress());
					
				}
				if( null != carShopId && 0 != carShopId ){
					CarShop carShop = carShopMapper.getById(carShopId);
					wayBill.setTargetProvince(carShop.getProvince());
					wayBill.setTargetCity(carShop.getCity());
				}
				if(null != detail.getSupplierId())
				{
					wayBill.setSupplierId(detail.getSupplierId());
				}
				waybillMapper.insertWaybill(wayBill);
				
				List<String> vinList = detail.getVinList();
				if( null == vinList ){
					vinList = new ArrayList<String>();
					for(int m=0; m<detail.getCount(); m++){
						vinList.add("");
					}
				}
				
				//插入商品车入库主表
				CarStockInOut carStockIn = new CarStockInOut();
				carStockIn.setType(Constants.CarType.IN);//入库
				carStockIn.setBusinessId( wayBill.getId() );//运单id
				carStockIn.setStockId( bean.getStockId() );
				carStockIn.setCount( detail.getCount() );
				carStockIn.setStatus(Constants.CarInOutStatus.FINISH);//已完成
				carStockIn.setInsertTime( new Date() );
				carStockIn.setInsertUser( operId+"" ) ;
				carStockIn.setUpdateTime( new Date() );
				carStockIn.setUpdateUser( operId+"" );
				carStockIn.setDelFlag(Constants.DelFlag.N);
				carStockInOutMapper.insert(carStockIn);
				
//				//插入商品车出库主表
//				CarStockInOut carStockOut = new CarStockInOut();
//				carStockOut.setType(Constants.CarType.OUT);//出库
//				carStockOut.setBusinessId( bean.getId() );//调度id
//				carStockOut.setStockId( bean.getStockId() );
//				carStockOut.setCount( detail.getCount() );
//				carStockOut.setStatus(Constants.CarInOutStatus.FINISH);//已完成
//				carStockOut.setInsertTime( new Date() );
//				carStockOut.setInsertUser( operId+"" ) ;
//				carStockOut.setUpdateTime( new Date() );
//				carStockOut.setUpdateUser( operId+"" );
//				carStockOut.setDelFlag(Constants.DelFlag.N);
//				carStockInOutMapper.insert(carStockOut);
				
				String carStockIds = "";//商品车库存id
				for(int m=0; m<detail.getCount(); m++){
					
					//插入商品车库存
					CarStock carStock = new CarStock();
					String vin = "";
					if( m < vinList.size() ){
						vin = vinList.get(m);
					}
					if( StringUtils.isNotEmpty(vin) ){
						String brandShort = CommonUtil.getPYIndexStr(detail.getBrandName(), true);
						if( !vin.startsWith(brandShort) ){
							vin = brandShort + "-" + vin;
						}
					}
					
					if( 0 == type ){
						carStock.setType(Constants.CarStockType.SPC);
					}else{
						carStock.setType(Constants.CarStockType.ESC);
						carStock.setMark(detail.getMark());//二手车需要看备注
						BigDecimal b= new BigDecimal(detail.getMoney()).divide(new BigDecimal(detail.getCount()),2, BigDecimal.ROUND_HALF_EVEN) ;
						carStock.setTransportPrice(b);//二手车 运输价格
					}
					carStock.setWaybillId(wayBill.getId());
					carStock.setBrand(detail.getBrandName());
					carStock.setModel(detail.getCarStyle());
					carStock.setVin(vin);
					carStock.setStockId( bean.getStockId() );
					carStock.setStatus(Constants.CarStatus.HASIN);//已入库
					carStock.setStorageTime(bean.getSendTime());//装运时间即入库时间
					carStock.setInsertTime(new Date());
					carStock.setInsertUser(operId+"");
					carStock.setUpdateTime(new Date());
					carStock.setUpdateUser(operId+"");
					carStock.setDelFlag(Constants.DelFlag.N);
					if( 1 == CommonUtil.compareTime(new Date(), bean.getSendTime()) ){
						carStock.setAfterFlag("Y");//补入库
					}else{
						carStock.setAfterFlag("N");
					}
					carStockMapper.insert(carStock);
					carStockIds += carStock.getId() + Constants.SplitStr.ScheduleBillDetailCarStockIds;
					
					//插入商品车入库明细
					CarStockInOutDetail carStockInDetail = new CarStockInOutDetail();
					carStockInDetail.setParentId(carStockIn.getId());//carStockIn的id
					carStockInDetail.setBusinessId( wayBill.getId() );//运单id
					carStockInDetail.setStockId(bean.getStockId());
					if( Constants.ScheduleBillDetailType.SPC == type ){
						carStockInDetail.setType(Constants.CarStockType.SPC);
					}else{
						carStockInDetail.setType(Constants.CarStockType.ESC);
					}
					carStockInDetail.setWaybillId(wayBill.getId());
					carStockInDetail.setBrand(bean.getBrand());
					carStockInDetail.setVin(vin);
					carStockInDetail.setMark(bean.getMark());
					carStockInDetail.setInsertTime(new Date());
					carStockInDetail.setInsertUser(operId+"");
					carStockInDetail.setUpdateTime(new Date());
					carStockInDetail.setUpdateUser(operId+"");
					carStockInDetail.setDelFlag(Constants.DelFlag.N);
					carStockInOutDetailMapper.insert(carStockInDetail);
					
//					//插入商品车出库明细
//					CarStockInOutDetail carStockOutDetail = new CarStockInOutDetail();
//					carStockOutDetail.setParentId(carStockOut.getId());//carStockOut的id
//					carStockOutDetail.setBusinessId( bean.getId() );//调度id
//					carStockOutDetail.setStockId(bean.getStockId());
//					if( 0 == type ){
//						carStockOutDetail.setType(Constants.CarStockType.SPC);
//					}else{
//						carStockOutDetail.setType(Constants.CarStockType.ESC);
//					}
//					carStockOutDetail.setBrand(bean.getBrand());
//					carStockOutDetail.setVin(vin);
//					carStockOutDetail.setMark(bean.getMark());
//					carStockOutDetail.setInsertTime(new Date());
//					carStockOutDetail.setInsertUser(operId+"");
//					carStockOutDetail.setUpdateTime(new Date());
//					carStockOutDetail.setUpdateUser(operId+"");
//					carStockOutDetail.setDelFlag(Constants.DelFlag.N);
//					carStockInOutDetailMapper.insert(carStockOutDetail);
					
				}
				
				//插入调度明细表
				detail.setScheduleBillNo(scheduleBillNo);
				detail.setAmount(detail.getCount());
				detail.setType(type);
				if( carStockIds.endsWith(Constants.SplitStr.ScheduleBillDetailCarStockIds) ){
					carStockIds = carStockIds.substring(0, carStockIds.length()-1);
				}
				detail.setCarStockIds(carStockIds);
				/*if( null != detail.getStartAddress() && !"".equals(detail.getStartAddress())){
					detail.setStartAddress(detail.getStartAddress().trim());
					if(!"市".equals(detail.getStartAddress().substring(detail.getStartAddress().length()-1, detail.getStartAddress().length())))
					{
						detail.setStartAddress(detail.getStartAddress()+"市");
					}
				}*/
				if( null != carShopId && 0 != carShopId ){
					CarShop carShop = carShopMapper.getById(carShopId);
					detail.setTargetProvince(carShop.getProvince());
					detail.setTargetCity(carShop.getCity());
				}
				detail.setStatus(Constants.ScheduleDetailStatus.UNFINISH);//未完成
				detail.setInsertTime(new Date());
				detail.setInsertUser(operId+"");
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(operId+"");
				detail.setDelFlag(Constants.DelFlag.N);
				scheduleBillDetailMapper.insert(detail);
				
			}else{//配件
				//插入运单表
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("scheduleBillNo", scheduleBillNo);
				params.put("waybillNo", detail.getWaybillNo());
				List<Waybill> waybills = waybillMapper.getByConditions(params);
				if( null ==  waybills || waybills.size() == 0  ){
					throw new RuntimeException("该配件【"+detail.getBrandName()+"】的运单号信息输入异常!");
				}
				Waybill wayBill = waybills.get(0);
				
				String attachmentName = detail.getBrandName();
				//插入配件入库主表
				CarAttachmentStockInOut carAttachmentStockIn = new CarAttachmentStockInOut();
				carAttachmentStockIn.setType(Constants.CarAttchmentType.RU);
				carAttachmentStockIn.setStockId(wayBill.getStockId());
				carAttachmentStockIn.setBusinessId(wayBill.getId());//运单id
				carAttachmentStockIn.setCount(detail.getCount());
				carAttachmentStockIn.setMark( attachmentName );
				carAttachmentStockIn.setStatus(String.valueOf(Constants.CarAttchmentStockInOutStatus.FINISH));
				carAttachmentStockIn.setInsertTime(new Date());
				carAttachmentStockIn.setInsertUser(operId+"");
				carAttachmentStockIn.setUpdateTime(new Date());
				carAttachmentStockIn.setUpdateUser(operId+"");
				carAttachmentStockIn.setDelFlag(Constants.DelFlag.N);
				carAttachmentStockInOutMapper.save(carAttachmentStockIn);
				
//				//插入配件出库主表
//				CarAttachmentStockInOut carAttachmentStockOut = new CarAttachmentStockInOut();
//				carAttachmentStockOut.setType(Constants.CarAttchmentType.CHU);
//				carAttachmentStockOut.setStockId(wayBill.getStockId());
//				carAttachmentStockOut.setBusinessId(bean.getId());//调度id
//				carAttachmentStockOut.setCount(detail.getCount());
//				carAttachmentStockOut.setMark( attachmentName );
//				carAttachmentStockOut.setStatus(String.valueOf(Constants.CarAttchmentStockInOutStatus.FINISH));
//				carAttachmentStockOut.setInsertTime(new Date());
//				carAttachmentStockOut.setInsertUser(operId+"");
//				carAttachmentStockOut.setUpdateTime(new Date());
//				carAttachmentStockOut.setUpdateUser(operId+"");
//				carAttachmentStockOut.setDelFlag(Constants.DelFlag.N);
//				carAttachmentStockInOutMapper.save(carAttachmentStockOut);
				
				//插入配件库存
				CarAttachmentStock carAttachmentStock = new CarAttachmentStock();
				carAttachmentStock.setType(wayBill.getType());
				carAttachmentStock.setWaybillId(wayBill.getId());
				carAttachmentStock.setCount(detail.getCount());
				carAttachmentStock.setAttachmentName( attachmentName );
				carAttachmentStock.setStockId( bean.getStockId() );
				carAttachmentStock.setStatus(Constants.CarStatus.HASIN);//已入库
				carAttachmentStock.setInsertTime(new Date());
				carAttachmentStock.setInsertUser(operId+"");
				carAttachmentStock.setUpdateTime(new Date());
				carAttachmentStock.setUpdateUser(operId+"");
				carAttachmentStock.setDelFlag(Constants.DelFlag.N);
				carAttachmentStockMapper.save(carAttachmentStock);
				
				//插入配件入库明细
				CarAttachmentStockInOutDetail carAttachmentStockInDetail = new CarAttachmentStockInOutDetail();
				carAttachmentStockInDetail.setParentId(carAttachmentStockIn.getId());
				carAttachmentStockInDetail.setBusinessId( wayBill.getId() );//运单id
				carAttachmentStockInDetail.setStockId( wayBill.getStockId() );
				carAttachmentStockInDetail.setType( Constants.CarAttchmentType.RU );//入库
				carAttachmentStockInDetail.setWaybillId( wayBill.getId() );
				carAttachmentStockInDetail.setAttachmentName( attachmentName );
				carAttachmentStockInDetail.setCount(detail.getCount());
				carAttachmentStockInDetail.setInsertTime( new Date() );
				carAttachmentStockInDetail.setUpdateTime( new Date() );
				carAttachmentStockInDetail.setInsertUser( operId+ "");
				carAttachmentStockInDetail.setUpdateUser( operId+ "");
				carAttachmentStockInDetail.setDelFlag(Constants.DelFlag.N);//
				carAttachmentStockInOutDetailMapper.save(carAttachmentStockInDetail);
				
//				//插入配件出库明细
//				CarAttachmentStockInOutDetail carAttachmentStockOutDetail = new CarAttachmentStockInOutDetail();
//				carAttachmentStockOutDetail.setParentId(carAttachmentStockOut.getId());
//				carAttachmentStockOutDetail.setBusinessId(  bean.getId() );//调度id
//				carAttachmentStockOutDetail.setStockId( wayBill.getStockId() );
//				carAttachmentStockOutDetail.setType(Constants.CarAttchmentType.CHU );//出库
//				carAttachmentStockOutDetail.setAttachmentName( attachmentName );
//				carAttachmentStockOutDetail.setCount(detail.getCount());
//				carAttachmentStockOutDetail.setInsertTime( new Date() );
//				carAttachmentStockOutDetail.setUpdateTime( new Date() );
//				carAttachmentStockOutDetail.setInsertUser( operId+ "");
//				carAttachmentStockOutDetail.setUpdateUser( operId+ "");
//				carAttachmentStockOutDetail.setDelFlag(Constants.DelFlag.N);//
//				carAttachmentStockInOutDetailMapper.save(carAttachmentStockOutDetail);
				
				//插入调度明细表
				detail.setScheduleBillNo(scheduleBillNo);
				detail.setAmount(detail.getCount());
				detail.setType(type);
				detail.setAttachmentIds(carAttachmentStock.getId()+"");
				detail.setStatus(Constants.ScheduleDetailStatus.UNFINISH);//未完成
				detail.setInsertTime(new Date());
				detail.setInsertUser(operId+"");
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(operId+"");
				detail.setDelFlag(Constants.DelFlag.N);
				scheduleBillDetailMapper.insert(detail);
				
			}
			
		}
		return amount;
	}

	@Override
	public ScheduleBill getScheduleDetailForFast(String scheduleBillNo)
			throws Exception {
		ScheduleBill bean = scheduleBillMapper.getByBillNo(scheduleBillNo);
		if( null == bean ){
			throw new RuntimeException("该调度号的信息不存在，请确认输入是否正确！");
		}
		User driver = userMapper.getById(bean.getDriverId()) ;
		if( null != driver ){
			bean.setDriverName( driver.getName() );
			bean.setMobile( driver.getMobile() );
		}
		User insertUser = userMapper.getById( Integer.parseInt(bean.getInsertUser()) ) ;
		if( null != insertUser ){
			bean.setInsertUserName( insertUser.getName() );
		}
		
		//获取装运预付信息：只取一条
		Map<String, Object> params1 = new HashMap<String, Object>();
		params1.put("scheduleBillNo", scheduleBillNo);
		params1.put("delFlag", Constants.DelFlag.N);
		params1.put("orderAsc", "Y");
		List<TransportPrepayApply> preList = transportPrepayApplyMapper.getByConditions(params1);
		if(null != preList && preList.size()>0 ){
			TransportPrepayApply prepay = preList.get(0);
			bean.setTransportCostApplyId(prepay.getId());
			bean.setPrepayCash(prepay.getPrepayCash());
			bean.setOilAmount(prepay.getOilAmount());
			bean.setOilCardNo(prepay.getOilCardNo());
			bean.setBankAccount(prepay.getBankAccount());
			bean.setBankName(prepay.getBankName());
			bean.setPrepayTime(prepay.getApplyTime());
			
		}
			
		List<ScheduleBillDetail> detailList = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
		if(null != detailList && detailList.size()>0){
			for(int i=0; i<detailList.size(); i++){
				ScheduleBillDetail detail = detailList.get(i);
				if( 0 == detail.getType() || 2 == detail.getType() ){//商品车或二手车
					if(0 == detail.getType())
					{
						String waybillNo = detail.getWaybillNo();
						Map<String,Object> params = new HashMap<String, Object>();
						params.put("delFlag", Constants.DelFlag.N);
						params.put("waybillNo", waybillNo);
						List<Waybill> waybillList = waybillMapper.getByConditions(params);
						if(null != waybillList && waybillList.size() > 0)
						{
							detail.setSupplierName(waybillList.get(0).getSupplierName()); 
							detail.setSupplierId(waybillList.get(0).getSupplierId()); 
						}
					}
					int ers = 0;
					if(2 == detail.getType())
					{
						String sIds = detail.getCarStockIds();
						if(null != sIds && "" != sIds)
						{
							String[] s = sIds.split(",");
							ers = s.length;
						}
					}
					//根据carStockIds查询商品车信息
					List<String> vinList = new ArrayList<String>();
					String carStockIds = detail.getCarStockIds();
					if(null !=carStockIds && !carStockIds.equals("")){
						Map<String, Object> params = new HashMap<String, Object>();
						params.put("carStockIds", carStockIds);
						params.put("descFlag", "N");
						//params.put("delFlag", Constants.DelFlag.N);
						List<CarStock> carList = carStockMapper.getByConditions(params);
						if( null != carList && carList.size() > 0 ){
							for(int m=0; m<carList.size(); m++){
								vinList.add(carList.get(m).getVin());
								String brand = carList.get(m).getBrand() != null ? carList.get(m).getBrand() : "";
								String carStyle = carList.get(m).getModel() != null ? carList.get(m).getModel() : "";
								detailList.get(i).setBrandName( brand );
								detailList.get(i).setCarStyle( carStyle );
								if(carList.get(m).getTransportPrice() != null)
								{
									BigDecimal b = carList.get(m).getTransportPrice().multiply(new BigDecimal(ers));
									detailList.get(i).setMoney(b.doubleValue());
								}
							}
						}
					}
					
					detailList.get(i).setVinList(vinList);
					
				}else if( 1 == detail.getType() ){//配件
					//根据carStockIds查询商品车信息
					String attachmentIds = detail.getAttachmentIds();
					if(null !=attachmentIds && !attachmentIds.equals("")){
						Map<String, Object> params = new HashMap<String, Object>();
						params.put("attachmentIds", attachmentIds);
						//params.put("delFlag", Constants.DelFlag.N);
						List<CarAttachmentStock> carAttachmentList = carAttachmentStockMapper.getByConditions(params);
						if( null != carAttachmentList && carAttachmentList.size() > 0 ){
							for(int m=0; m<carAttachmentList.size(); m++){
								detailList.get(i).setBrandName( carAttachmentList.get(m).getAttachmentName() );
							}
						}
					}
					
				}
				
				detailList.get(i).setCount(detailList.get(i).getAmount());
				CarShop carShop = carShopMapper.getById(detailList.get(i).getCarShopId());
				if( null != carShop ){
					detailList.get(i).setCarShopName(carShop.getName());
				}
				
			}
			bean.setDetailList(detailList);
		}
		
		return bean;
	}

	@Override
	@SystemServiceLog(description="发起调度修改申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void applyModifyScheduleForFast(String scheduleBillNo,
			int userId, String reason) throws Exception {
		
		//检查是否创建人申请
		ScheduleBill sb = scheduleBillMapper.getByBillNo(scheduleBillNo);
		if( null == sb ){
			throw new RuntimeException("该调度单号的数据不存在！");
		}
		if( userId != Integer.parseInt(sb.getInsertUser()) ){
			throw new RuntimeException("您没有申请权限！");
		}
		
		//检查是否已申请
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("scheduleBillNo", scheduleBillNo);
		params.put("applyUserId", userId);
		params.put("status", Constants.ScheduleBillChangeApplyStatus.WAITING);//审核通过
		List<ScheduleBillChangeApply> sbcaList = scheduleBillChangeApplyMapper.getByConditions(params);
		if( null != sbcaList && sbcaList.size() > 0 ){
			ScheduleBillChangeApply sbca = sbcaList.get(0);
			if( Constants.ScheduleBillChangeApplyStatus.WAITING.equals( sbca.getStatus() ) ){
				throw new RuntimeException("申请修改正在审核，请耐心等待！");
			}else if( Constants.ScheduleBillChangeApplyStatus.PASS.equals( sbca.getStatus() ) ){
				throw new RuntimeException("申请修改已审核通过，现可修改！");
			}
		}
		
		User user = userMapper.getById( userId );
		User pu = userMapper.getById( user.getParentId());
		if( null == pu){
			throw new RuntimeException("当前用户的上级人员信息未设置，请联系管理员！");
		}
		int receiveUserId = user.getParentId();
		
		//插入申请表
		ScheduleBillChangeApply sbca = new ScheduleBillChangeApply();
		sbca.setApplyUserId(userId);
		sbca.setDelFlag(Constants.DelFlag.N);
		sbca.setInsertTime(new Date());
		sbca.setUpdateTime(new Date());
		sbca.setInsertUser(userId+"");
		sbca.setUpdateUser(userId+"");
		sbca.setScheduleBillNo(scheduleBillNo);
		sbca.setStatus(Constants.ScheduleBillChangeApplyStatus.WAITING);
		sbca.setReason(reason);
		sbca.setAuditUserId(receiveUserId);
		scheduleBillChangeApplyMapper.insert(sbca);
		
		//插入待办表，推送消息
//		//添加到流程中
//		Item item = new Item();
//		item.setBusinessType(Constants.ProcessType.DDXGSQD);
//		item.setDetailId( sbca.getId() );
//		item.setItemName( CommonUtil.getProcessName(Constants.ProcessType.DDXGSQD, scheduleBillNo) );
//		item.setProcessId( null );
//		item.setStatus( Constants.ItemStatus.PROCESSING );
//		item.setApplyTime( new Date() );
//		item.setApplyUserId( userId );
//		item.setDelFlag( Constants.DelFlag.N );
//		item.setInsertTime( new Date() );
//		item.setInsertUser( userId+"" );
//		item.setUpdateTime( new Date() );
//		item.setUpdateUser( userId+"" );
//		itemMapper.insert( item );
//		
//		//生成新建的操作日志记录
//		TaskHistory log = new TaskHistory();
//		log.setItemId( item.getId() );
//		log.setOperateTime( new Date() );
//		log.setOperateUserId( userId + "" );
//		log.setProcessDetailId( null );
//		log.setMark("待审核");
//		log.setSuccessFlag("Y");
//		taskHistoryMapper.insert( log );
//		
//		//生成下一个流程步骤对应的代办记录
//		Task nextTask = new Task();
//		nextTask.setProcessDetailId( null );
//		nextTask.setReceiveUserId( receiveUserId+"" );
//		nextTask.setItemId( item.getId() );
//		nextTask.setDelFlag( Constants.DelFlag.N );
//		nextTask.setInsertTime( new Date() );
//		nextTask.setInsertUser( userId + "" );
//		nextTask.setUpdateTime( new Date() );
//		nextTask.setUpdateUser( userId + "" );
//		taskMapper.insert( nextTask );
		
		//推送消息：
//		String statusStr = "";
//		if( Constants.ItemStatus.NEW.equals(item.getStatus()) ){
//			statusStr = "新建";
//		}else if( Constants.ItemStatus.PROCESSING.equals(item.getStatus()) ){
//			statusStr = "流转中";
//		}else if( Constants.ItemStatus.FINISHED.equals(item.getStatus()) ){
//			statusStr = "已完成";
//		}
//		String content = "新消息：" + item.getItemName() + "[状态："+ statusStr +"]";
		String content = "新消息：您有1条调度修改申请需审核[调度单号-"+scheduleBillNo+"]！";
		commonService.pushMsgToUser( receiveUserId, content );
		
	}

	@Override
	public Pager<ScheduleBillChangeApply> getScheduleBillChangeApplyPageData(
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
		params.put("delFlag", Constants.DelFlag.N);
		List<ScheduleBillChangeApply> list = scheduleBillChangeApplyMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				User applyUser = userMapper.getById(list.get(i).getApplyUserId()) ;
				if( null != applyUser ){
					list.get(i).setApplyUserName( applyUser.getName() );
				}
				User auditUser = userMapper.getById(list.get(i).getAuditUserId()) ;
				if( null != auditUser ){
					list.get(i).setAuditUserName( auditUser.getName() );
				}
			}
		}
		int totalCount = scheduleBillChangeApplyMapper.getPageTotalCount(params);
		
		Pager<ScheduleBillChangeApply> pager = new Pager<ScheduleBillChangeApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="审核调度修改申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditScheduleBillChangeApply(String scheduleBillApplyIds,
			String auditResult, String auditSuggest, int userId)
			throws Exception {

		String[] ids = scheduleBillApplyIds.split(";");
		for(int i=0; i<ids.length; i++){
			String scheduleBillApplyId = ids[i];
			ScheduleBillChangeApply apply = scheduleBillChangeApplyMapper.getById( Integer.parseInt(scheduleBillApplyId) );
			if( null == apply ){
				throw new RuntimeException("第"+(i+1)+"条申请修改信息不存在！");
			}
			
			if( !Constants.ScheduleBillChangeApplyStatus.WAITING.equals(apply.getStatus()) ){
				throw new RuntimeException("第"+(i+1)+"条申请修改信息不可审核！");
			}
			apply.setUpdateUser(userId+"");
			apply.setUpdateTime(new Date());
			apply.setAuditTime(new Date());
			if( "Y".equals(auditResult) ){
				apply.setStatus(Constants.ScheduleBillChangeApplyStatus.PASS);
			}else{
				apply.setStatus(Constants.ScheduleBillChangeApplyStatus.UNPASS);
			}
			apply.setAuditSuggest(auditSuggest);
			scheduleBillChangeApplyMapper.update(apply);
			
			ScheduleBill sb = scheduleBillMapper.getByBillNo(apply.getScheduleBillNo());
			if( "Y".equals(auditResult) ){
				//修改调度单中的可修改标记字段
				sb.setModifyEnabledFlag("Y");
				scheduleBillMapper.update(sb);
			}
		}
		
//		//更新项目状态为：已完成
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("detailId", apply.getId());
//		params.put("businessType", Constants.ProcessType.DDXGSQD);
//		List<Item> itemList = itemMapper.getByConditions(params);
//		if( null != itemList && itemList.size() > 0 ){
//			Item item = itemList.get(0);
//			item.setStatus( Constants.ItemStatus.FINISHED );
//			item.setUpdateTime( new Date() );
//			item.setUpdateUser( userId+"" );
//			itemMapper.updateBySelective( item );
//		}
		
	}

	@Override
	public Pager<ScheduleBill> getGroupByUserPageData(Map<String, Object> params)
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
		
		List<ScheduleBill> list = scheduleBillMapper.getGroupByUser(params);
		int totalCount = scheduleBillMapper.getGroupByUserCount(params);
		
		Pager<ScheduleBill> pager = new Pager<ScheduleBill>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
		
	}

	
}
