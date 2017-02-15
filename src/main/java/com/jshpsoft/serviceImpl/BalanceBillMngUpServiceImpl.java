package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
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
import com.jshpsoft.dao.AttachMoneyLogMapper;
import com.jshpsoft.dao.BalanceBillMapper;
import com.jshpsoft.dao.BalancePriceMapper;
import com.jshpsoft.dao.BusinessOperateLogMapper;
import com.jshpsoft.dao.CarStockInOutDetailMapper;
import com.jshpsoft.dao.CarStockInOutMapper;
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.AttachMoneyLog;
import com.jshpsoft.domain.BalanceBill;
import com.jshpsoft.domain.BalancePriceSetting;
import com.jshpsoft.domain.BusinessOperateLog;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.CarStockInOut;
import com.jshpsoft.domain.CarStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.BalanceBillMngUpService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("balanceBillMngUpService")
public class BalanceBillMngUpServiceImpl implements BalanceBillMngUpService {
	
	@Autowired
	private BalanceBillMapper balanceBillMapper;
	
	@Autowired
	private CarStockMapper carStockMapper;
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private CarStockInOutMapper carStockInOutMapper;
	
	@Autowired
	private BalancePriceMapper balancePriceMapper;
	
	@Autowired
	private CarStockInOutDetailMapper carStockInOutDetailMapper;
	
	@Autowired
	private AttachMoneyLogMapper attachMoneyLogMapper;
	
	@Autowired
	private BusinessOperateLogMapper businessOperateLogMapper;
	
	@Override
	@SystemServiceLog(description="查询对账列表信息")
	public Pager<BalanceBill> getPageData(Map<String, Object> params) throws Exception {
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
		List<BalanceBill> list = balanceBillMapper.getPageListUp(params);
		int totalCount = balanceBillMapper.getPageTotalCountUp(params);
		
		Pager<BalanceBill> pager = new Pager<BalanceBill>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	
	@Override
	@SystemServiceLog(description="根据id获取对账明细")
	public BalanceBill getById(Integer id) throws Exception {
		return balanceBillMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="根据id获取对账打印明细")
	public BalanceBill getDetailPrintData(Integer id) throws Exception {
		BalanceBill bean = balanceBillMapper.getDetailByIdUp(id);
		if(null != bean){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("waybillId", bean.getBusinessId());
			List<CarStock> detail = carStockMapper.getByConditions(params);
			bean.setDetailList(detail);
		}
		return bean;
	}
	
	@Override
	@SystemServiceLog(description="获取结算总金额")
	public Double getAmount(Map<String, Object> params) throws Exception {
		
		
		if(params.get("carCount").toString().equals("")){
			throw new RuntimeException("台数为空");
		}
		Integer carCount =  Integer.parseInt(params.get("carCount").toString());
		
		if(params.get("distance").toString().equals("")){
			throw new RuntimeException("公里数为空");
		}
		Integer distance =  Integer.parseInt(params.get("distance").toString());
		
		String balanceType =  params.get("balanceType").toString();
		if(balanceType.equals("")){
			throw new RuntimeException("结算方式为空");
		}
		
		BalanceBill balanceBill = balanceBillMapper.getById(Integer.parseInt(params.get("id").toString()));
		if(null == balanceBill){
			throw new RuntimeException("该id的对账信息不存在");
		}
		
		Waybill bean = waybillMapper.getById(balanceBill.getBusinessId());
		if(null == bean){
			throw new RuntimeException("对账的运单信息不存在，请检查");
		}
		
		bean.setCount(carCount);
		bean.setDistance(distance);
		bean.setBalanceType(balanceType);
		//获取结算金额、额外费用、总金额
		bean = this.getWayBill(bean);
		
		return bean.getSumAmount().doubleValue();
	}
	
	public Waybill getWayBill(Waybill bean) throws Exception {
		
		//预先set、金额值为0
		bean.setAmount(new BigDecimal(0));
		bean.setAttachAmount(new BigDecimal(0));
		bean.setSumAmount(new BigDecimal(0));
		
		String parentId = "";
		
		//数量
		Map<String, Object> paramsCount = new HashMap<String, Object>();
		paramsCount.put("businessId", bean.getId());
		paramsCount.put("type", Constants.CarType.IN);
		paramsCount.put("status", Constants.CarInOutStatus.FINISH);
		paramsCount.put("delFlag", Constants.DelFlag.N);
		List<CarStockInOut> carList = carStockInOutMapper.getByConditions(paramsCount);
		if(null !=carList && carList.size()>0){
			parentId = String.valueOf(carList.get(0).getId());
		}
		
		String balanceType=bean.getBalanceType();
		
		if(Constants.BalanceType.PRICE.equals(balanceType)){//单价
			
			Map<String, Object> paramsBalance = new HashMap<String, Object>();
			paramsBalance.put("supplierId", bean.getSupplierId());
			paramsBalance.put("delFlag", Constants.DelFlag.N);
			List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
			if(null !=balabceList && balabceList.size()>0){
				bean.setAmount((new BigDecimal( balabceList.get(0).getPrice().doubleValue()*bean.getCount()*bean.getDistance() )).setScale(2,BigDecimal.ROUND_HALF_UP));
			}
			
		}else if(Constants.BalanceType.DISTANCE.equals(balanceType)){//公里数--具体到每辆商品车：供应商id、品牌、车型
			
			//根据运单编号到商品车出入库明细表中获取
			Map<String, Object> paramsDetail = new HashMap<String, Object>();
			paramsDetail.put("parentId", parentId);
			paramsDetail.put("delFlag", Constants.DelFlag.N);
			List<CarStockInOutDetail> carDetailList = carStockInOutDetailMapper.getByConditions(paramsDetail);
			if(null !=carDetailList && carDetailList.size()>0){
				Double amount = 0.0d;
				for(int j=0;j<carDetailList.size();j++){
					CarStockInOutDetail detail = carDetailList.get(j);
					
					Map<String, Object> paramsBalance = new HashMap<String, Object>();
					paramsBalance.put("supplierId", bean.getSupplierId());
					paramsBalance.put("brand", detail.getBrand());
					paramsBalance.put("carType", detail.getModel());
					paramsBalance.put("delFlag", Constants.DelFlag.N);
					List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
					if(null !=balabceList && balabceList.size()>0){
						amount = amount + balabceList.get(0).getPrice().doubleValue()*bean.getDistance();
					}
					
				}
				bean.setAmount((new BigDecimal(amount)).setScale(2,BigDecimal.ROUND_HALF_UP));
			}
			
		}else if(Constants.BalanceType.SUMPRICE.equals(balanceType)){//总价
			
			Map<String, Object> paramsBalance = new HashMap<String, Object>();
			paramsBalance.put("supplierId", bean.getSupplierId());
			paramsBalance.put("delFlag", Constants.DelFlag.N);
			List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
			if(null !=balabceList && balabceList.size()>0){
				bean.setAmount(balabceList.get(0).getPrice().setScale(2,BigDecimal.ROUND_HALF_UP));
			}
			
		}
		
		//额外费用、总费用
		Map<String, Object> paramsAttach = new HashMap<String, Object>();
		paramsAttach.put("detailId", bean.getId());
		paramsAttach.put("delFlag", Constants.DelFlag.N);
		List<AttachMoneyLog> attachList = attachMoneyLogMapper.getByConditions(paramsAttach);
		
		Double attachAmount = 0.0d;
		if(null !=attachList && attachList.size()>0){
			for(int j=0;j<attachList.size();j++){
				AttachMoneyLog attach = attachList.get(j);
				if(attach.getType().equals(Constants.AttachType.FIXED)){
					attachAmount = attachAmount + attach.getAmount().doubleValue();
				}else if(attachList.get(j).getType().equals(Constants.AttachType.RATIO)){
					attachAmount = attachAmount + (attach.getRatio()*bean.getAmount().doubleValue())/100;
				}
			}
		}
		bean.setAttachAmount((new BigDecimal(attachAmount)).setScale(2,BigDecimal.ROUND_HALF_UP));
		bean.setSumAmount((new BigDecimal( bean.getAmount().doubleValue()+bean.getAttachAmount().doubleValue() )).setScale(2,BigDecimal.ROUND_HALF_UP));
		
		return bean;
	}
	
	@Override
	@SystemServiceLog(description="编辑对账信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(BalanceBill bean, String oper) throws Exception {
		
		if( null == bean ){
			throw new RuntimeException("对账信息为空");
		}
				
		BalanceBill beanOld = balanceBillMapper.getById(bean.getId());
		
		//比较,插入sys_businessOperateLog表
		String operateDetail="";
		if(beanOld.getCarCount()!=bean.getCarCount()){
			operateDetail += "台数由"+beanOld.getCarCount()+"修改为"+bean.getCarCount()+",";
		}
		if(beanOld.getDistance()!=bean.getDistance()){
			operateDetail += "公里数由"+beanOld.getDistance()+"修改为"+bean.getDistance()+",";
		}
		if(beanOld.getBalanceType()!=bean.getBalanceType()){
			operateDetail += "结算方式由"+beanOld.getBalanceType()+"修改为"+bean.getBalanceType()+",";
		}
		if(beanOld.getBalanceAmount()!=bean.getBalanceAmount()){
			operateDetail += "结算总金额由"+beanOld.getBalanceAmount()+"修改为"+bean.getBalanceAmount()+",";
		}
		
		if(!operateDetail.equals("")){
			BusinessOperateLog log = new BusinessOperateLog();
			log.setType(Constants.BusinessLogType.BALANCEDOWN);//10
			log.setDetailId(bean.getId());
			log.setOperate("更新");
			log.setOperator(oper);
			log.setOperateTime(new Date());
			log.setOperateDetail(operateDetail);
			businessOperateLogMapper.insert(log);
		}
		
		//更新
		beanOld.setCarCount(bean.getCarCount());
		beanOld.setDistance(bean.getDistance());
		beanOld.setBalanceType(bean.getBalanceType());
		beanOld.setBalanceAmount(bean.getBalanceAmount());
		beanOld.setMark(bean.getMark());
		beanOld.setUpdateTime(new Date());
		beanOld.setUpdateUser(oper);
		balanceBillMapper.update(beanOld);
	}

	@Override
	@SystemServiceLog(description="确认对账信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void sure(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("verifyTime", new Date());
		params.put("verifyUser", oper);
		params.put("status", Constants.BalanceStatus.SURE);
		balanceBillMapper.updateById(params);
	}


	@Override
	@SystemServiceLog(description="获取打印对账信息列表")
	public List<BalanceBill> getPrint(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return balanceBillMapper.getByConditionsUp(params);
	}


	@Override
	@SystemServiceLog(description="导出对账信息列表")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到装运费用核算申请数据
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceBill> detailList = balanceBillMapper.getByConditionsUp(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "上游对账信息列表");//
		sheetData.put("titleMergeSize", 11);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("供应商");
		tableHeadList.add("运单号");
		tableHeadList.add("品牌");
		tableHeadList.add("台数");
		tableHeadList.add("公里数");
		tableHeadList.add("结算方式");
		tableHeadList.add("结算总金额");
		tableHeadList.add("状态");
		tableHeadList.add("运单插入时间");
		tableHeadList.add("确认时间");
		sheetData.put("tableHeader", tableHeadList);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<detailList.size();i++){
			//获取每一行数据
			BalanceBill balanceBill = detailList.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			
			rowData.add(String.valueOf(i+1));
			rowData.add(balanceBill.getSupplierName());
			rowData.add(balanceBill.getWaybillNo());
			rowData.add(balanceBill.getBrand());
			
			if(balanceBill.getCarCount() != null){
				rowData.add(String.valueOf(balanceBill.getCarCount()));
			}else{
				rowData.add("");
			}
			
			if(balanceBill.getDistance() != null){
				rowData.add(String.valueOf(balanceBill.getDistance()));
			}else{
				rowData.add("");
			}

			rowData.add(balanceBill.getBalanceType());
			
			if(balanceBill.getBalanceAmount() != null){
				rowData.add(String.valueOf(balanceBill.getBalanceAmount()));
			}else{
				rowData.add("");
			}
			
			if(balanceBill.getStatus().equals(Constants.BalanceStatus.NEW)){
				rowData.add("新建");
			}else if(balanceBill.getStatus().equals(Constants.BalanceStatus.SURE)){
				rowData.add("已确认");
			}
			
			if(balanceBill.getInsertTime() !=null){
				rowData.add( sdf.format(balanceBill.getInsertTime()) );
			}else{
				rowData.add("");
			}
			
			if(balanceBill.getVerifyTime() !=null){
				rowData.add( sdf.format(balanceBill.getVerifyTime()) );
			}else{
				rowData.add("");
			}
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

}
