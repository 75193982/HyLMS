package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
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
import com.jshpsoft.dao.CarStockInOutDetailMapper;
import com.jshpsoft.dao.CarStockInOutMapper;
import com.jshpsoft.dao.SupplierBusinessMapper;
import com.jshpsoft.dao.SupplierBusinessPriceMapper;
import com.jshpsoft.dao.SupplierMapper;
import com.jshpsoft.dao.TransportPriceMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.AttachMoneyLog;
import com.jshpsoft.domain.BalanceBill;
import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.domain.BalancePriceSetting;
import com.jshpsoft.domain.CarStockInOut;
import com.jshpsoft.domain.CarStockInOutDetail;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.SupplierBusiness;
import com.jshpsoft.domain.SupplierBusinessPrice;
import com.jshpsoft.domain.TransportPriceSetting;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.IncomeMngService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("incomeMngService")
public class IncomeMngServiceImpl implements IncomeMngService {
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private CarStockInOutMapper carStockInOutMapper;
	
	@Autowired
	private BalancePriceMapper balancePriceMapper;
	
	@Autowired
	private AttachMoneyLogMapper attachMoneyLogMapper;
	
	@Autowired
	private SupplierMapper supplierMapper;
	
	@Autowired
	private CarStockInOutDetailMapper carStockInOutDetailMapper;
	
	@Autowired
	private BalanceBillMapper balanceBillMapper;
	
	@Autowired
	private SupplierBusinessMapper supplierBusinessMapper;
	
	@Autowired
	private SupplierBusinessPriceMapper supplierBusinessPriceMapper;
	
	@Autowired
	private TransportPriceMapper transportPriceMapper;

	@Override
	@SystemServiceLog(description="获取收入管理信息")
	public Pager<BalanceCar> getPageData(Map<String, Object> params)
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
		List<BalanceCar> list = waybillMapper.getInComePageList(params);
		//进行解析
		list = this.getLastBalanceCar(list);
		int totalCount = waybillMapper.getInComePageTotalCount(params);
		
		Pager<BalanceCar> pager = new Pager<BalanceCar>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存额外计费")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(AttachMoneyLog bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("额外计费信息为空");
		}
		
		//插入收入管理的额外计费
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		attachMoneyLogMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="获取额外计费信息")
	public List<AttachMoneyLog> getAttachDetail(Map<String, Object> params) throws Exception {
		
		params.put("delFlag", Constants.DelFlag.N);
		return attachMoneyLogMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="删除额外计费")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		//更新
		attachMoneyLogMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="获取收入管理打印数据")
	public List<BalanceCar> getPrint(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceCar> list = waybillMapper.getInComeByConditions(params);
		//进行解析
		list = this.getLastBalanceCar(list);
		return list;
	}

	@Override
	@SystemServiceLog(description="收入管理导出数据")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到收入管理数据
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceCar> list = waybillMapper.getInComeByConditions(params);
		//进行解析
		list = this.getLastBalanceCar(list);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "收入管理数据");//
		sheetData.put("titleMergeSize", 22);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("供应商");
		tableHeadList.add("品牌");
		tableHeadList.add("车型");
		tableHeadList.add("车架号");
		tableHeadList.add("下单日期");
		tableHeadList.add("运单号");
		tableHeadList.add("装运车号");
		tableHeadList.add("装运日期");
		tableHeadList.add("调度单号");
		tableHeadList.add("出发地");
		tableHeadList.add("目的省");
		tableHeadList.add("目的地");
		tableHeadList.add("台数");
		tableHeadList.add("公里数");
		tableHeadList.add("结算单价");
		tableHeadList.add("结算运费");
		tableHeadList.add("驳板费");
		tableHeadList.add("加价运费");
		tableHeadList.add("其他扣除");
		tableHeadList.add("最终费用");
		tableHeadList.add("运单状态");
		sheetData.put("tableHeader", tableHeadList);
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			BalanceCar waybill = list.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(waybill.getSupplierName());
			rowData.add(waybill.getBrand());
			rowData.add(waybill.getModel());
			rowData.add(waybill.getVin());
			rowData.add(waybill.getWaybillDate());
			rowData.add(waybill.getWaybillNo());
			rowData.add(waybill.getCarNumber());
			rowData.add(waybill.getScheduleDate());
			rowData.add(waybill.getScheduleBillNo());
			rowData.add(waybill.getStartAddress());
			rowData.add(waybill.getTargetProvince());
			rowData.add(waybill.getTargetCity());
			rowData.add(String.valueOf(waybill.getCount()));
			
			if(waybill.getDistance() != null){
				rowData.add(String.valueOf(waybill.getDistance()));
			}else{
				rowData.add("");
			}
			
			rowData.add(String.valueOf(waybill.getPrice()));
			rowData.add(String.valueOf(waybill.getBalancePrice()));
			rowData.add(String.valueOf(waybill.getBargePrice()));
			rowData.add(String.valueOf(waybill.getFarePrice()));
			rowData.add(String.valueOf(waybill.getOtherDeduct()));
			rowData.add(String.valueOf(waybill.getSumPrice()));
			
			if(waybill.getWaybillStatus().equals(Constants.WaibillStatus.UNREVIEW.getValue())){
				rowData.add("待复核");
			}else if(waybill.getWaybillStatus().equals(Constants.WaibillStatus.UNRECEIPT.getValue())){
				rowData.add("待回执");
			}else if(waybill.getWaybillStatus().equals(Constants.WaibillStatus.FINISHED.getValue())){
				rowData.add("已完成");
			}
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}
		
	@SystemServiceLog(description="解析获取公里数、结算单价、驳板费、加价费用、其他扣除、结算费用、最终费用")
	public List<BalanceCar> getLastBalanceCar(List<BalanceCar> list) throws Exception {
		
		//解析获取  公里数、结算单价、驳板费、加价费用、其他扣除、结算费用
		if(null !=list && list.size()>0){
			for(int i=0;i<list.size();i++){
				BalanceCar bean = list.get(i);
				bean = this.getBalanceCar(bean);
				
				//查询是否已经对账
				/*Map<String, Object> params = new HashMap<String, Object>();
				params.put("businessId", bean.getId());
				List<BalanceBill> balanceList = balanceBillMapper.getByConditionsUp(params);
				if(null != balanceList && balanceList.size()>0 ){
					bean.setBalanceFlag("N");//可以对账
				}else{
					bean.setBalanceFlag("Y");//不可以
				}*/
			}
		}
		
		return list;
	}
	
	public BalanceCar getBalanceCar(BalanceCar bean) throws Exception {
		
		//判断当前商品车是否为二手车
		if(!String.valueOf(bean.getType()).equals( Constants.WaybillType.ESC )){
			//获取结算方式
			if(null != bean.getSupplierId() && !"".equals(bean.getSupplierId()) && null != bean.getBrand() && !"".equals(bean.getBrand()))
			{
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("supplierId", bean.getSupplierId());
				params.put("brandName", bean.getBrand());
				params.put("delFlag", Constants.DelFlag.N);
				List<SupplierBusiness> supB = supplierBusinessMapper.getByConditions(params);
				if(null != supB && supB.size()>0){
					String balanceType = supB.get(0).getBalanceType();
					if(null != balanceType){
						if(null != bean.getStartAddress() && !"".equals(bean.getStartAddress()) && null != bean.getTargetProvince() && !"".equals(bean.getTargetProvince()) && null != bean.getTargetCity() && !"".equals(bean.getTargetCity()))
						{
							Map<String, Object> paramsSel = new HashMap<String, Object>();
							paramsSel.put("businessId", supB.get(0).getId());
							paramsSel.put("startAddress", bean.getStartAddress());
							paramsSel.put("endProvince", bean.getTargetProvince());
							paramsSel.put("endAddress", bean.getTargetCity());
							paramsSel.put("delFlag", Constants.DelFlag.N);
							if(balanceType.equals("0")){//车型
								if(null != bean.getModel() && !"".equals(bean.getModel()))
								{
									paramsSel.put("carTypeCheck", bean.getModel());
									List<SupplierBusinessPrice> supBPList = supplierBusinessPriceMapper.getByConditions(paramsSel);
									if(null != supBPList && supBPList.size()>0 ){
										SupplierBusinessPrice supBP = supBPList.get(0);
										bean.setDistance(supBP.getDistance());
										bean.setPrice(supBP.getPrice());
										bean.setBalancePrice( CommonUtil.formatDouble(supBP.getDistance()*supBP.getPrice()) );
									}
								}
							}else if(balanceType.equals("1")){//单价
								List<SupplierBusinessPrice> supBPList = supplierBusinessPriceMapper.getByConditions(paramsSel);
								if(null != supBPList && supBPList.size()>0 ){
									SupplierBusinessPrice supBP = supBPList.get(0);
									bean.setDistance(supBP.getDistance());
									bean.setPrice(supBP.getPrice());
									bean.setBalancePrice( CommonUtil.formatDouble(supBP.getDistance()*supBP.getPrice()) );
								}
								
							}else if(balanceType.equals("2")){//总价
								List<SupplierBusinessPrice> supBPList = supplierBusinessPriceMapper.getByConditions(paramsSel);
								if(null != supBPList && supBPList.size()>0 ){
									SupplierBusinessPrice supBP = supBPList.get(0);
									bean.setDistance(supBP.getDistance());
									bean.setPrice(supBP.getPrice());
									bean.setBalancePrice(supBP.getPrice());
								}
								
							}else{
								throw new RuntimeException("结算模式不正确，请检查");
							}
						}
			
					}
					
				}
				
				//获取驳板费
				List<TransportPriceSetting>  trP = transportPriceMapper.getByConditions(params);
				if(null != trP && trP.size()>0){
					bean.setBargePrice(trP.get(0).getPrice().doubleValue());
				}
			}
		}else{//二手车
			bean.setPrice(bean.getTransportPrice());
			bean.setBalancePrice(bean.getTransportPrice());
			bean.setBargePrice(0);
		}
		
		//获取额外费用
		Map<String, Object> paramsAtt = new HashMap<String, Object>();
		paramsAtt.put("carStockId", bean.getId());
		paramsAtt.put("attachMold", Constants.attachMold.INCOME);
		paramsAtt.put("delFlag", Constants.DelFlag.N);
		
		List<AttachMoneyLog> attList = attachMoneyLogMapper.getByConditions(paramsAtt);
		if(null != attList ){
			double farePrice = 0;
			double otherDeduct = 0;
			
			for(int i=0;i<attList.size();i++){
				if(attList.get(i).getChargeType() == Constants.chargeType.FARE){
					if(null != attList.get(i).getAmount())
					{
						farePrice += attList.get(i).getAmount().doubleValue();
					}
					
				}else{
					if(null != attList.get(i).getAmount())
					{
						otherDeduct += attList.get(i).getAmount().doubleValue();
					}
				}
			}
			
			bean.setFarePrice( CommonUtil.formatDouble(farePrice) );
			bean.setOtherDeduct( CommonUtil.formatDouble(otherDeduct) );
		}
		//最终费用：结算费用-驳板费用+加价运费-其他扣除
		bean.setSumPrice( CommonUtil.formatDouble(bean.getBalancePrice()-bean.getBargePrice()+bean.getFarePrice()-bean.getOtherDeduct()) );
		
		return bean;
	}
	
	@SystemServiceLog(description="解析获取数量、结算方式、结算金额、额外费用、总金额")
	public List<Waybill> getLastWayBill(List<Waybill> list) throws Exception {
		
		//解析获取数量、结算方式、结算金额、额外费用、总金额
		if(null !=list && list.size()>0){
			for(int i=0;i<list.size();i++){
				Waybill bean = list.get(i);
				bean = this.getWayBill(bean);
				
				//查询是否已经对账
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("businessId", bean.getId());
				List<BalanceBill> balanceList = balanceBillMapper.getByConditionsUp(params);
				if(null != balanceList && balanceList.size()>0 ){
					bean.setBalanceFlag("N");//可以对账
				}else{
					bean.setBalanceFlag("Y");//不可以
				}
			}
		}
		
		return list;
	}

	public Waybill getWayBill(Waybill bean) throws Exception {
		
		//预先set、金额值为0
		bean.setCount(0);
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
			bean.setCount(carList.get(0).getCount());
			parentId = String.valueOf(carList.get(0).getId());
		}
		
		//结算方式、结算金额--状态不是‘已完成’的，需要根据供应商id到basic_balancePriceSetting中获取
		if(!bean.getStatus().equals(Constants.WaibillStatus.FINISHED.getValue() )){
			
			String balanceType="";
			//到供应商表中获取结算方式
			Supplier supplier = supplierMapper.getById(bean.getSupplierId());
			if(null != supplier){
				balanceType = supplier.getBalanceType();
				bean.setBalanceType(balanceType);
			}
			
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
	@SystemServiceLog(description="执行对账")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void balance(Integer id, String oper) throws Exception {
		Waybill bean = waybillMapper.getById(id);
		
		if(null == bean){
			throw new RuntimeException("对账的运单信息不存在，请检查");
		}
		//获取数量、结算方式、结算金额、额外费用、总金额
		bean = this.getWayBill(bean);
		
		//插入信息到对账信息表
		BalanceBill balance = new BalanceBill();
		balance.setType(Constants.BalanceBillType.UP);//0上游对账
		balance.setBusinessId(bean.getId());
		balance.setCarCount(bean.getCount());
		balance.setDistance(bean.getDistance());
		balance.setStatus(Constants.BalanceStatus.NEW);//0新建
		balance.setBalanceType(bean.getBalanceType());
		balance.setBalanceAmount(bean.getSumAmount());
		balance.setMark("收入对账");
		balance.setInsertTime(new Date());
		balance.setInsertUser(oper);
		balance.setUpdateTime(new Date());
		balance.setUpdateUser(oper);
		balance.setDelFlag(Constants.DelFlag.N);
		balanceBillMapper.insert(balance);
	}

	@Override
	public double getSumPrice(Map<String, Object> params) throws Exception {
		
		double sumPrice = 0;
		//得到收入管理数据
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceCar> list = waybillMapper.getInComeByConditions(params);
		//进行解析
		list = this.getLastBalanceCar(list);
		
		for(int i=0;i<list.size();i++){
			sumPrice += list.get(i).getSumPrice();
		}
		
		return CommonUtil.formatDouble(sumPrice);
	}
}
