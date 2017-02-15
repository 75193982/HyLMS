package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.TrackInsuranceDetailMapper;
import com.jshpsoft.dao.TrackInsuranceMapper;
import com.jshpsoft.dao.TrackInsurancePayLogMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.domain.TrackInsuranceDetail;
import com.jshpsoft.domain.TrackInsurancePayLog;
import com.jshpsoft.service.TrackInsuranceMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("trackInsuranceMngService")
public class TrackInsuranceMngServiceImpl implements TrackInsuranceMngService {
	
	@Autowired
	private TrackInsuranceMapper trackInsuranceMapper;
	
	@Autowired
	private TrackInsuranceDetailMapper trackInsuranceDetailMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private TrackInsurancePayLogMapper trackInsurancePayLogMapper;
	
	@Resource
	private CashInOutMapper cashInOutMapper;
	
	@Resource
	private UserMapper userMapper;

	@Override
	@SystemServiceLog(description="获取保费信息")
	public Pager<TrackInsurance> getPageData(Map<String, Object> params)
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
		List<TrackInsurance> list = trackInsuranceMapper.getPageList(params);
		int totalCount = trackInsuranceMapper.getPageTotalCount(params);
		
		Pager<TrackInsurance> pager = new Pager<TrackInsurance>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="获取保费信息")
	public TrackInsurance getInsuranceBean(Map<String, Object> params)
			throws Exception {
		
		params.put("orderFlag", "Y");
		params.put("delFlag", Constants.DelFlag.N);
		List<TrackInsurance> list =trackInsuranceMapper.getByConditions(params);
		if(null != list && list.size()>0){
			return list.get(0);
		}else{
			return null;
		}
	}
	
	@Override
	@SystemServiceLog(description="新增保费信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TrackInsurance bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("保费信息为空");
		}
		
		//参加保险需要有明细
		List<TrackInsuranceDetail> detailList = bean.getDetailList();
		if(bean.getType().equals(Constants.InsuranceType.JOIN) && null == detailList){
			throw new RuntimeException("参加保险的险种明细为空");
		}
		
		//验证参加保险的保单号是否已经存在
		if(bean.getType().equals(Constants.InsuranceType.JOIN)){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("type", Constants.InsuranceType.JOIN);
			params.put("insuranceBillNo", bean.getInsuranceBillNo());
			params.put("delFlag", Constants.DelFlag.N);
			List<TrackInsurance> trackInsurance =trackInsuranceMapper.getByConditions(params);
			if(null !=trackInsurance && trackInsurance.size()>0){
				throw new RuntimeException(bean.getInsuranceBillNo()+"该保单号已存在，请检查");
			}
		}
		
		//插入保险表
		if(bean.getType().equals(Constants.InsuranceType.JOIN)){
			bean.setBalance(bean.getAmount());
		}else{
			bean.setBalance(new BigDecimal(0));
		}
		bean.setStatus(Constants.InsuranceStatus.NEW);//新建
		bean.setPayStatus(Constants.InsurancePayStatus.WEI);//未支付
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		trackInsuranceMapper.insert(bean);
		
		Double sumAmount = 0.0d;
		//插入保险明细表
		if(null != detailList && detailList.size()>0 ){
			for(int i=0;i<detailList.size();i++){
				TrackInsuranceDetail detail = detailList.get(i);
				detail.setParentId(bean.getId());
				detail.setInsertTime(new Date());
				detail.setInsertUser(oper);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				trackInsuranceDetailMapper.insert(detail);
				
				sumAmount = sumAmount + detail.getAmount().doubleValue();
			}
			
			//判断保费金额是否与明细总金额相等
			if(sumAmount != bean.getAmount().doubleValue()){
				throw new RuntimeException("保费金额与明细总金额不相等,请检查");
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="根据id获取保费信息")
	public TrackInsurance getById(Integer id) throws Exception {
		TrackInsurance bean = trackInsuranceMapper.getById(id);
		if(null == bean)
		{
			throw new RuntimeException("实体为空!");
		}
		//参加保险的有明细
		if(bean.getType().equals(Constants.InsuranceType.JOIN)){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("parentId", bean.getId());
			params.put("delFlag", Constants.DelFlag.N);
			List<TrackInsuranceDetail> detailList = trackInsuranceDetailMapper.getByConditions(params);
			bean.setDetailList(detailList);
		}
		//支付记录信息
		Map<String, Object> par = new HashMap<String, Object>();
		par.put("delFlag", Constants.DelFlag.N);
		par.put("insuranceId", id);
		List<TrackInsurancePayLog> list = trackInsurancePayLogMapper.getByConditions(par);
		bean.setInsurancePayLogList(list);
		return bean;
	}

	@Override
	@SystemServiceLog(description="更新保费信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TrackInsurance bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("保费信息为空");
		}
		
		//参加保险需要有明细
		List<TrackInsuranceDetail> detailList = bean.getDetailList();
		if(bean.getType().equals(Constants.InsuranceType.JOIN) && null == detailList){
			throw new RuntimeException("参加保险的险种明细为空");
		}
		
		//验证参加保险的保单号是否已经存在
		if(bean.getType().equals(Constants.InsuranceType.JOIN)){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("type", Constants.InsuranceType.JOIN);
			params.put("insuranceBillNo", bean.getInsuranceBillNo());
			params.put("delFlag", Constants.DelFlag.N);
			List<TrackInsurance> trackInsurance =trackInsuranceMapper.getByConditions(params);
			if(null !=trackInsurance && trackInsurance.size()>0 && (int)trackInsurance.get(0).getId() != (int)bean.getId()){
				throw new RuntimeException(bean.getInsuranceBillNo()+"该保单号已存在，请检查");
			}
		}
		
		//更新保险表
		if(bean.getType().equals(Constants.InsuranceType.JOIN)){
			bean.setBalance(bean.getAmount());
		}else{
			bean.setBalance(new BigDecimal(0));
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		trackInsuranceMapper.update(bean);
		
		//根据parentId删除原先的明细
		trackInsuranceDetailMapper.deleteByParentId(bean.getId());
		
		Double sumAmount = 0.0d;
		//插入保险明细表
		if(null != detailList && detailList.size()>0 ){
			for(int i=0;i<detailList.size();i++){
				TrackInsuranceDetail detail = detailList.get(i);
				detail.setParentId(bean.getId());
				detail.setInsertTime(new Date());
				detail.setInsertUser(oper);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				trackInsuranceDetailMapper.insert(detail);
				
				sumAmount = sumAmount + detail.getAmount().doubleValue();
			}
			
			//判断保费金额是否与明细总金额相等
			if(sumAmount != bean.getAmount().doubleValue()){
				throw new RuntimeException("保费金额与明细总金额不相等,请检查");
			}
		}

	}

	@Override
	@SystemServiceLog(description="更新附件地址")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateFilePath(TrackInsurance bean,HttpServletRequest req) throws Exception {
		TrackInsurance old = trackInsuranceMapper.getById( bean.getId() );
		
		//发票附件路径
		String invoiceAttachPath = bean.getInvoiceAttachPath();
		if( StringUtils.isNotEmpty(invoiceAttachPath) && !invoiceAttachPath.equals( old.getInvoiceAttachPath() )){
			String newFilePath = commonService.reStoreFile( Constants.UploadType.INSURANCE, invoiceAttachPath , req);
			bean.setInvoiceAttachPath(newFilePath);
		}

		//保单路径
		String insuranceBillPath = bean.getInsuranceBillPath();
		if( StringUtils.isNotEmpty(insuranceBillPath) && !insuranceBillPath.equals( old.getInsuranceBillPath() )){
			String newFilePath = commonService.reStoreFile( Constants.UploadType.INSURANCE, insuranceBillPath , req);
			bean.setInsuranceBillNo(newFilePath);
		}
		
		//付款记录路径
		String payLogPath = bean.getPayLogPath();
		if( StringUtils.isNotEmpty(payLogPath) && !payLogPath.equals( old.getPayLogPath() )){
			String newFilePath = commonService.reStoreFile( Constants.UploadType.INSURANCE, payLogPath , req);
			bean.setPayLogPath(newFilePath);
		}
		
		//事故认定书路径
		String accidentReportPath = bean.getAccidentReportPath();
		if( StringUtils.isNotEmpty(accidentReportPath) && !accidentReportPath.equals( old.getAccidentReportPath() )){
			String newFilePath = commonService.reStoreFile( Constants.UploadType.INSURANCE, accidentReportPath , req);
			bean.setAccidentReportPath(newFilePath);
		}
		
		trackInsuranceMapper.updateById(bean);
		
	}
	
	@Override
	@SystemServiceLog(description="删除保费信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		//更新保险表
		trackInsuranceMapper.updateById(params);
		
		//更新保险明细表
		params.put("parentId", id);
		trackInsuranceDetailMapper.updateByParentId(params);
	}

	@Override
	@SystemServiceLog(description="提交保费信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", Constants.InsuranceStatus.SUBMIT);//已提交
		//更新保险表
		trackInsuranceMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="新增支付/索赔保险费用")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void savePayLog(TrackInsurancePayLog bean, String oper)
			throws Exception {
		
		//若是索赔费用，则更新保险表的balance
		if(bean.getType().equals(Constants.InsurancePayType.IN)){
			TrackInsurance inBean = trackInsuranceMapper.getById(bean.getInsuranceId());
			
			//更新保险表中的balance=balance+本次索赔金额
			Map<String, Object> params1 = new HashMap<String, Object>();
			params1.put("id", bean.getInsuranceId());
			params1.put("balance", inBean.getBalance().doubleValue()+bean.getAmount().doubleValue());
			trackInsuranceMapper.updateById(params1);
		}
		
		//查看之前的支付是否有存款
		Double amount1 = 0.0d;
		Double amount2 = 0.0d;
		Double amount3 = 0.0d;
		List<TrackInsurancePayLog> logList = trackInsurancePayLogMapper.getGroupAmount();
		if(null != logList && logList.size()>0){
			for(int i=0;i<logList.size();i++){
				TrackInsurancePayLog log = logList.get(i);
				if(log.getType().equals(Constants.InsurancePayType.OUT)){
					amount1 = amount1 + log.getAmount().doubleValue();
				}else if(log.getType().equals(Constants.InsurancePayType.IN)){
					amount2 = amount2 + log.getAmount().doubleValue();
				}else if(log.getType().equals(Constants.InsurancePayType.OFFSET)){
					amount3 = amount3 + log.getAmount().doubleValue();
				}
			}
		}
		
		//插入初始的费用
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		trackInsurancePayLogMapper.insert(bean);
		
		Double amount = bean.getAmount().doubleValue();
		
		//支付总金额:本次金额+之前余的
		amount = amount + amount1 + amount2 - amount3;
		
		//查看保费中是否有欠费记录
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", Constants.InsuranceType.JOIN);//参加保险
		params.put("status", Constants.InsuranceStatus.SUBMIT);//已提交
		params.put("arrFlag", "Y");//拖欠标志
		List<TrackInsurance> list = trackInsuranceMapper.getByConditions(params);
		if(null != list && list.size()>0){
			for(int i=0;i<list.size();i++){
				TrackInsurance trIn = list.get(i);
				System.out.println(trIn.getBalance());
				Double balance = trIn.getBalance().doubleValue();//欠费金额
				
				//比较支付剩余钱和当前欠费的大小
				if(amount >= balance){
					//插入抵充支付信息
					TrackInsurancePayLog pay = new TrackInsurancePayLog();
					pay.setType(Constants.InsurancePayType.OFFSET);//已经抵充的参保费用
					pay.setParentId(bean.getId());
					pay.setInsuranceId(trIn.getId());
					pay.setInsuranceNo(trIn.getInsuranceBillNo());
					pay.setAmount(trIn.getBalance());
					pay.setMark("保险抵充");
					pay.setInsertTime(new Date());
					pay.setInsertUser(oper);
					pay.setUpdateTime(new Date());
					pay.setUpdateUser(oper);
					pay.setDelFlag(Constants.DelFlag.N);
					trackInsurancePayLogMapper.insert(pay);
					
					//更新保险表中的balance为0
					Map<String, Object> paramsUp = new HashMap<String, Object>();
					paramsUp.put("id", trIn.getId());
					paramsUp.put("balance", "0");
					trackInsuranceMapper.updateById(paramsUp);
					
					amount = amount - balance;
					
				}else if(amount < balance){
					//插入抵充支付信息
					TrackInsurancePayLog pay = new TrackInsurancePayLog();
					pay.setType(Constants.InsurancePayType.OFFSET);//已经抵充的参保费用
					pay.setParentId(bean.getId());
					pay.setInsuranceId(trIn.getId());
					pay.setInsuranceNo(trIn.getInsuranceBillNo());
					pay.setAmount(new BigDecimal(amount));
					pay.setMark("保险抵充");
					pay.setInsertTime(new Date());
					pay.setInsertUser(oper);
					pay.setUpdateTime(new Date());
					pay.setUpdateUser(oper);
					pay.setDelFlag(Constants.DelFlag.N);
					trackInsurancePayLogMapper.insert(pay);
					
					//更新保险表中的balance为balance-amount
					Map<String, Object> paramsUp = new HashMap<String, Object>();
					paramsUp.put("id", trIn.getId());
					paramsUp.put("balance", balance-amount);
					trackInsuranceMapper.updateById(paramsUp);
					
					break;//已经全部抵充，跳出循环
				}
				
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="查询保费信息：用于打印")
	public List<TrackInsurance> getPrintData(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		params.put("orderFlag", "Y");
		return trackInsuranceMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="保费信息导出")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到装运预付申请数据
		params.put("delFlag", Constants.DelFlag.N);
		params.put("orderFlag", "Y");
		List<TrackInsurance> detailList = trackInsuranceMapper.getByConditions(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "保费数据");//
		sheetData.put("titleMergeSize", 12);//导出数据的列数
		
		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("类型");
		tableHeadList.add("货运车号");
		tableHeadList.add("保险公司");
		tableHeadList.add("保单号");
		tableHeadList.add("保险开始时间");
		tableHeadList.add("保险结束时间");
		tableHeadList.add("总金额");
		tableHeadList.add("备注");
		tableHeadList.add("插入时间");
		tableHeadList.add("更新时间");
		tableHeadList.add("状态");
		sheetData.put("tableHeader", tableHeadList);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<detailList.size();i++){
			//获取每一行数据
			TrackInsurance trackIn = detailList.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			if("0".equals(trackIn.getInsuranceType()))
			{
				rowData.add("交强险");
			}
			else if("1".equals(trackIn.getInsuranceType()))
			{
				rowData.add("商业险");
			}
			else if("2".equals(trackIn.getInsuranceType()))
			{
				rowData.add("货运险");
			}
			else
			{
				rowData.add("");
			}
			rowData.add(trackIn.getCarNumber());			
			rowData.add(trackIn.getInsuranceCompany());
			rowData.add(trackIn.getInsuranceBillNo());
			if(trackIn.getStartTime() != null){
				rowData.add( sdf.format(trackIn.getStartTime()) );
			}else{
				rowData.add("");
			}
			
			if(trackIn.getEndTime() != null){
				rowData.add( sdf.format(trackIn.getEndTime()) );
			}else{
				rowData.add("");
			}
			
			if(trackIn.getAmount() != null){
				rowData.add(String.valueOf(trackIn.getAmount()));
			}else{
				rowData.add("");
			}
			
			/*if(trackIn.getStatus().equals(Constants.InsurancePayType.OUT)){
				rowData.add("支付参加保险费用");
			}else if(trackIn.getStatus().equals(Constants.InsurancePayType.IN)){
				rowData.add("报保险的赔付费用");
			}else if(trackIn.getStatus().equals(Constants.InsurancePayType.OFFSET)){
				rowData.add("已经抵充的参保费用");
			}*/
			
			/*if(trackIn.getNoticeTime() != null){
				rowData.add( sdf.format(trackIn.getNoticeTime()) );
			}else{
				rowData.add("");
			}*/
			
			rowData.add(trackIn.getMark());
			
			//rowData.add(trackIn.getInsertUser());
			
			if(trackIn.getInsertTime() != null){
				rowData.add( sdf.format(trackIn.getInsertTime()) );
			}else{
				rowData.add("");
			}
			
			//rowData.add(trackIn.getUpdateUser());
			if(trackIn.getUpdateTime() != null){
				rowData.add( sdf.format(trackIn.getUpdateTime()) );
			}else{
				rowData.add("");
			}
			//0-新建，1-生效中，2-已失效
			if("0".equals(trackIn.getStatus()))
			{
				rowData.add("新建");
			}
			if("1".equals(trackIn.getStatus()))
			{
				rowData.add("生效中");
			}
			if("2".equals(trackIn.getStatus()))
			{
				rowData.add("已失效");
			}
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}
	
	@Override
	@SystemServiceLog(description="获取保费支付列表信息")
	public Pager<TrackInsurancePayLog> getPayPageData(Map<String, Object> params)
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
		List<TrackInsurancePayLog> list = trackInsurancePayLogMapper.getPageList(params);
		int totalCount = trackInsurancePayLogMapper.getPageTotalCount(params);
		
		Pager<TrackInsurancePayLog> pager = new Pager<TrackInsurancePayLog>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="获取保费支付的明细")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public List<TrackInsurancePayLog> getPayDetailList(Integer id)
			throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentId", id);
		params.put("delFlag", Constants.DelFlag.N);
		return trackInsurancePayLogMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="支付")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void zhiFu(Integer id, String oper) throws Exception {
		TrackInsurance bean = trackInsuranceMapper.getById(id);
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setPayStatus(Constants.InsurancePayStatus.YI);
		bean.setId(id);
		trackInsuranceMapper.update(bean);
		
		//插入支付记录
		TrackInsurancePayLog tp = new TrackInsurancePayLog();
		tp.setType(bean.getType());
		tp.setInsuranceId(id);
		tp.setInsuranceNo(bean.getInsuranceBillNo());
		tp.setAmount(bean.getAmount());
		tp.setMark(bean.getMark());
		tp.setInsertTime(new Date());
		tp.setInsertUser(oper);
		tp.setDelFlag(Constants.DelFlag.N);
		trackInsurancePayLogMapper.insert(tp);
		
		//插入现金收支
		double money = bean.getAmount().doubleValue();
		CashInOut cash = new CashInOut();
		cash.setDepartmentId(userMapper.getById(Integer.parseInt(oper)).getDepartmentId());
		cash.setBusinessType(Constants.CashInOutBusinessType.TrackInsurance);
		cash.setType(Constants.CashInOutType.OUT);
		cash.setDetailId(id);
		cash.setMark("保费申请");
		cash.setMoney( money );
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
