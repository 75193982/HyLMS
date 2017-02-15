package com.jshpsoft.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.TransportPrepayApplyDetailMapper;
import com.jshpsoft.dao.TransportPrepayApplyMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.TransportPrepayApply;
import com.jshpsoft.domain.TransportPrepayApplyDetail;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.TransportPrepayMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("transportPrepayMngService")
public class TransportPrepayMngServiceImpl implements TransportPrepayMngService {
	
	@Autowired
	private TransportPrepayApplyMapper transportPrepayApplyMapper;
	
	@Autowired
	private TransportPrepayApplyDetailMapper transportPrepayApplyDetailMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private CashInOutMapper cashInOutMapper;

	@Override
	@SystemServiceLog(description="获取装运预付申请信息")
	public Pager<TransportPrepayApply> getPageData(Map<String, Object> params)
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
		List<TransportPrepayApply> list = transportPrepayApplyMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				User driver = userMapper.getById(list.get(i).getDriverId()) ;
				if( null != driver ){
					list.get(i).setDriverName( driver.getName() );
				}
			}
		}

		int totalCount = transportPrepayApplyMapper.getPageTotalCount(params);
		
		Pager<TransportPrepayApply> pager = new Pager<TransportPrepayApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增装运预付申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TransportPrepayApply bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("装运预付申请信息为空");
		}
		
		List<TransportPrepayApplyDetail> detailList = bean.getDetailList();
		if( null == detailList){
			throw new RuntimeException("装运预付申请明细为空");
		}
		
		//插入装运预付申请主表
		bean.setStatus(Constants.PrepayApplyStatus.NEW);//新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		transportPrepayApplyMapper.insert(bean);
		
		//插入明细表
		if(null != detailList && detailList.size()>0 ){
			for(int i=0;i<detailList.size();i++){
				TransportPrepayApplyDetail detail = detailList.get(i);
				detail.setParentId(bean.getId());
				detail.setInsertTime(new Date());
				detail.setInsertUser(oper);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				transportPrepayApplyDetailMapper.insert(detail);
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="根据id获取装运预付申请信息")
	public TransportPrepayApply getById(Integer id) throws Exception {
		TransportPrepayApply bean = transportPrepayApplyMapper.getById(id);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentId", bean.getId());
		params.put("delFlag", Constants.DelFlag.N);
		List<TransportPrepayApplyDetail> detailList = transportPrepayApplyDetailMapper.getByConditions(params);
		bean.setDetailList(detailList);

		return bean;
	}

	
	@Override
	@SystemServiceLog(description="更新装运预付申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TransportPrepayApply bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("装运预付申请信息为空");
		}
		
		List<TransportPrepayApplyDetail> detailList = bean.getDetailList();
		if( null == detailList){
			throw new RuntimeException("装运预付申请明细为空");
		}
		
		//更新申请主表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		transportPrepayApplyMapper.update(bean);
		
		//根据parentId删除原先的明细
		transportPrepayApplyDetailMapper.deleteByParentId(bean.getId());
		
		//插入明细表
		if(null != detailList && detailList.size()>0 ){
			for(int i=0;i<detailList.size();i++){
				TransportPrepayApplyDetail detail = detailList.get(i);
				detail.setParentId(bean.getId());
				detail.setInsertTime(new Date());
				detail.setInsertUser(oper);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				transportPrepayApplyDetailMapper.insert(detail);
			}
		}
	}

	@Override
	@SystemServiceLog(description="删除装运预付申请信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		//更新申请主表
		transportPrepayApplyMapper.updateById(params);
		
		//更新明细表
		params.put("parentId", id);
		transportPrepayApplyDetailMapper.updateByParentId(params);
	}

	@Override
	@SystemServiceLog(description="提交装运预付申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", Constants.PrepayApplyStatus.LEADERAUDIT);//待审核
		//更新申请主表
		transportPrepayApplyMapper.updateById(params);		
		
		TransportPrepayApply bean = transportPrepayApplyMapper.getById(id);
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.ZYYFSQD, 
				id, 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName(Constants.ProcessType.ZYYFSQD, CommonUtil.getCustomDateToString(bean.getApplyTime(), Constants.DATE_TIME_FORMAT_SHORT) + "_" + bean.getCarNumber())
				);
	}


	@Override
	public List<TransportPrepayApply> getFinancePrint(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return transportPrepayApplyMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="导出装运预付申请信息")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到装运预付申请数据
		params.put("delFlag", Constants.DelFlag.N);
		List<TransportPrepayApply> detailList = transportPrepayApplyMapper.getByConditions(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "已提交的装运预付申请");//
		sheetData.put("titleMergeSize", 17);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("调度单号");
		tableHeadList.add("车牌号");
		tableHeadList.add("驾驶员");
		tableHeadList.add("手机号码");
		tableHeadList.add("申请时间");
		tableHeadList.add("预付现金");
		tableHeadList.add("开户行名称");
		tableHeadList.add("账号");
		tableHeadList.add("油卡卡号");
		tableHeadList.add("预付油费");
		tableHeadList.add("状态");
		tableHeadList.add("备注");
		tableHeadList.add("插入人");
		tableHeadList.add("插入时间");
		tableHeadList.add("更新人");
		tableHeadList.add("更新时间");
		sheetData.put("tableHeader", tableHeadList);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<detailList.size();i++){
			//获取每一行数据
			TransportPrepayApply preApply = detailList.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(preApply.getScheduleBillNo());
			rowData.add(preApply.getCarNumber());
			String driverName = "";
			User driver = userMapper.getById(preApply.getDriverId()) ;
			if( null != driver ){
				driverName = driver.getName();
			}
			rowData.add(driverName);
			rowData.add(preApply.getMobile());
			
			if(preApply.getApplyTime() != null){
				rowData.add( sdf.format(preApply.getApplyTime()) );
			}else{
				rowData.add("");
			}
			
			if(preApply.getPrepayCash() != null){
				rowData.add(String.valueOf(preApply.getPrepayCash()));
			}else{
				rowData.add("");
			}
			rowData.add(preApply.getBankName());
			rowData.add(preApply.getBankAccount());
			rowData.add(preApply.getOilCardNo());
			if(preApply.getOilAmount() != null){
				rowData.add(String.valueOf(preApply.getOilAmount()));
			}else{
				rowData.add("");
			}
			
			if(preApply.getStatus().equals(Constants.PrepayApplyStatus.LEADERAUDIT)){
				rowData.add("待负责人审核");
			}else if(preApply.getStatus().equals(Constants.PrepayApplyStatus.CASHAUDIT)){
				rowData.add("待现金预核");
			}else if(preApply.getStatus().equals(Constants.PrepayApplyStatus.CASHLEADERAUDIT)){
				rowData.add("待财务复核");
			}else if(preApply.getStatus().equals(Constants.PrepayApplyStatus.CASHPAY)){
				rowData.add("待现金付款");
			}else if(preApply.getStatus().equals(Constants.PrepayApplyStatus.FINISH)){
				rowData.add("已完成");
			}else if(preApply.getStatus().equals(Constants.PrepayApplyStatus.BALANCE)){
				rowData.add("已结算");
			}
			
			rowData.add(preApply.getMark());
			
			rowData.add(preApply.getInsertUser());
			if(preApply.getInsertTime() != null){
				rowData.add( sdf.format(preApply.getInsertTime()) );
			}else{
				rowData.add("");
			}
			
			rowData.add(preApply.getUpdateUser());
			if(preApply.getUpdateTime() !=null){
				rowData.add( sdf.format(preApply.getUpdateTime()) );
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
	@SystemServiceLog(description="装运预付申请审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Integer detailId, String status, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", detailId);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", status);
		transportPrepayApplyMapper.updateById(params);
		
		//如果是预付现金，则收支管理生成1条支出记录
		TransportPrepayApply tp = transportPrepayApplyMapper.getById(detailId);
		
		if(null != tp.getPrepayCash() ){
			CashInOut cash = new CashInOut();
			User user = userMapper.getById( Integer.parseInt(tp.getInsertUser()) );
			int departmentId = 0;
			if( null != user && null != user.getDepartmentId() ){
				departmentId = user.getDepartmentId();
			}
			cash.setDepartmentId(departmentId);
			cash.setBusinessType(Constants.CashInOutBusinessType.TransportPrepayApply);
			cash.setType(Constants.CashInOutType.OUT);
			cash.setDetailId(detailId);
			cash.setMark("装运预付【调度单号-"+tp.getScheduleBillNo()+"】");
			cash.setMoney( tp.getPrepayCash().doubleValue() );
			cash.setDelFlag(Constants.DelFlag.N);
			cash.setInsertTime(new Date());
			cash.setInsertUser(oper);
			cash.setUpdateTime(new Date());
			cash.setUpdateUser(oper);
			cash.setStatus(Constants.CashInOutStatus.SUBMIT);
			cash.setSystemFlag(Constants.SystemFlag.Y);
			cashInOutMapper.insert(cash);
		}
		
		
		
			
	}

	@Override
	@SystemServiceLog(description="装运预付申请审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Integer id, String status, String oper) throws Exception {
		
		auditForConfirm( id, status, oper);
	}

	@Override
	@SystemServiceLog(description="装运预付申请状态更新")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditForConfirm(Integer id, String status, String oper)
			throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", status);
		transportPrepayApplyMapper.updateById(params);
		
	}

	@Override
	@SystemServiceLog(description="获取装运预付申请信息")
	public List<TransportPrepayApply> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return transportPrepayApplyMapper.getByConditions(params);
	}
	
}
