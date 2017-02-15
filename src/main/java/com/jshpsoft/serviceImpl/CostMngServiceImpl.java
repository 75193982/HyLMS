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
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.OutSourcingBusinessMapper;
import com.jshpsoft.dao.OutSourcingBusinessPriceMapper;
import com.jshpsoft.dao.OutSourcingMapper;
import com.jshpsoft.dao.ScheduleBillDetailMapper;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.SupplierMapper;
import com.jshpsoft.dao.TrackMapper;
import com.jshpsoft.dao.TransportCostApplyMapper;
import com.jshpsoft.dao.TransportPriceMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.AttachMoneyLog;
import com.jshpsoft.domain.BalanceBill;
import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.domain.BalancePriceSetting;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.OutSourcingBusiness;
import com.jshpsoft.domain.OutSourcingBusinessPrice;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleBillDetail;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TransportCostApply;
import com.jshpsoft.domain.TransportPriceSetting;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CostMngService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("costMngService")
public class CostMngServiceImpl implements CostMngService {
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private TrackMapper trackMapper;

	@Autowired
	private TransportCostApplyMapper transportCostApplyMapper;
	
	@Autowired
	private ScheduleBillDetailMapper scheduleBillDetailMapper;
	
	@Autowired
	private CarStockMapper carStockMapper;
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private SupplierMapper supplierMapper;
	
	@Autowired
	private BalancePriceMapper balancePriceMapper;
	
	@Autowired
	private OutSourcingMapper outSourcingMapper;
	
	@Autowired
	private BalanceBillMapper balanceBillMapper;
	
	@Autowired
	private OutSourcingBusinessMapper outSourcingBusinessMapper;
	
	@Autowired
	private OutSourcingBusinessPriceMapper outSourcingBusinessPriceMapper;
	
	@Autowired
	private AttachMoneyLogMapper attachMoneyLogMapper;
	
	@Autowired
	private TransportPriceMapper transportPriceMapper;

	@Override
	@SystemServiceLog(description="获取成本管理信息")
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
		List<BalanceCar> list = scheduleBillMapper.getCostPageList(params);
		//进行解析
		list = this.getLastBalanceCar(list);
		int totalCount = scheduleBillMapper.getCostPageTotalCount(params);
		
		Pager<BalanceCar> pager = new Pager<BalanceCar>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="获取成本管理打印数据")
	public List<BalanceCar> getPrint(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceCar> list = scheduleBillMapper.getCostByConditions(params);
		//进行解析
		list = this.getLastBalanceCar(list);
		return list;
	}

	@Override
	@SystemServiceLog(description="成本管理导出数据")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到成本管理数据
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceCar> list = scheduleBillMapper.getCostByConditions(params);
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
		sheetData.put("title", "成本管理数据");//
		sheetData.put("titleMergeSize", 23);//导出数据的列数
		
		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("承运商");
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
		tableHeadList.add("调度单状态");
		sheetData.put("tableHeader", tableHeadList);

		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			BalanceCar waybill = list.get(i);
		
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(waybill.getOutSourcingName());
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
			
			if(waybill.getScheduleStatus().equals(Constants.ScheduleBillStatus.ONWAY)){
				rowData.add("在途");
			}else if(waybill.getScheduleStatus().equals(Constants.ScheduleBillStatus.FINISH)){
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
			if(null != bean.getOutSourcingId() && !"".equals(bean.getOutSourcingId()) && null != bean.getBrand() && !"".equals(bean.getBrand()) && null != bean.getSupplierId() && !"".equals(bean.getSupplierId()))
			{
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("outSourcingId", bean.getOutSourcingId());
				params.put("supplierId", bean.getSupplierId());//bean.getBrand()
				params.put("brandName", bean.getBrand());
				params.put("delFlag", Constants.DelFlag.N);
				List<OutSourcingBusiness> supB = outSourcingBusinessMapper.getByConditions(params);
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
									List<OutSourcingBusinessPrice> supBPList = outSourcingBusinessPriceMapper.getByConditions(paramsSel);
									if(null != supBPList && supBPList.size()>0 ){
										OutSourcingBusinessPrice supBP = supBPList.get(0);
										bean.setDistance(supBP.getDistance());
										bean.setPrice(supBP.getPrice());
										bean.setBalancePrice( CommonUtil.formatDouble(supBP.getDistance()*supBP.getPrice()) );
									}
								}
							}else if(balanceType.equals("1")){//单价
								List<OutSourcingBusinessPrice> supBPList = outSourcingBusinessPriceMapper.getByConditions(paramsSel);
								if(null != supBPList && supBPList.size()>0 ){
									OutSourcingBusinessPrice supBP = supBPList.get(0);
									bean.setDistance(supBP.getDistance());
									bean.setPrice(supBP.getPrice());
									bean.setBalancePrice( CommonUtil.formatDouble(supBP.getDistance()*supBP.getPrice()) );
								}
								
							}else if(balanceType.equals("2")){//总价
								List<OutSourcingBusinessPrice> supBPList = outSourcingBusinessPriceMapper.getByConditions(paramsSel);
								if(null != supBPList && supBPList.size()>0 ){
									OutSourcingBusinessPrice supBP = supBPList.get(0);
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
				params.put("supplierId", bean.getSupplierId());
				params.put("brandName", bean.getBrand());
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
		paramsAtt.put("attachMold", Constants.attachMold.COST);
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
	
	@SystemServiceLog(description="解析获取车队名称、驳运费用、油费、总金额")
	public List<ScheduleBill> getLastScheduleBill(List<ScheduleBill> list) throws Exception {
		
		if(null !=list && list.size()>0){
			for(int i=0;i<list.size();i++){
				ScheduleBill bean = list.get(i);
				bean = this.getScheduleBill(bean);
			
				//查询是否已经对账
				Map<String, Object> params = new HashMap<String, Object>();
				params.put("businessId", bean.getId());
				List<BalanceBill> balanceList = balanceBillMapper.getByConditionsDown(params);
				if(null != balanceList && balanceList.size()>0 ){
					bean.setBalanceFlag("N");//可以对账
				}else{
					bean.setBalanceFlag("Y");//不可以
				}
				
			}
		}
		
		return list;
	}
	
	public ScheduleBill getScheduleBill(ScheduleBill bean) throws Exception {
		
		//根据车牌号获取车队类型
		Map<String, Object> paramsTrack = new HashMap<String, Object>();
		paramsTrack.put("no", bean.getCarNumber());
		paramsTrack.put("delFlag", Constants.DelFlag.N);
		List<Track> trackList = trackMapper.getByConditions(paramsTrack);
		if(null !=trackList && trackList.size()>0){
			Integer outId = trackList.get(0).getOutSourcingId();
			
			//得到外协单位的油费计算比例
			Integer  oilCostRatio = 0;
			OutSourcing outSour = outSourcingMapper.getById(outId);
			if(null != outSour && null !=outSour.getTransportOilCostRatio()){
				oilCostRatio =outSour.getTransportOilCostRatio();
				bean.setCarTrackName(outSour.getName());
				bean.setOilBalanceRatio(oilCostRatio);
			}
			
			//驳运费用---具体到每辆商品车：供应商id、品牌、车型
			//得到调度单明细信息
			List<ScheduleBillDetail> schDetail = scheduleBillDetailMapper.getByBillNo(bean.getScheduleBillNo());
			if(null !=schDetail && schDetail.size()>0){
				Double cashAmount = 0.0d;
				Double oilAmount = 0.0d;
				
				for(int j=0;j<schDetail.size();j++){
					ScheduleBillDetail detail = schDetail.get(j);
					
					//获取商品车信息
					String carStockIds = detail.getCarStockIds();
					Map<String, Object> paramsCar = new HashMap<String, Object>();
					paramsCar.put("carStockIds", carStockIds);
					List<CarStock> carList = carStockMapper.getByConditions(paramsCar);
					if(null !=carList && carList.size()>0){
						for(int k=0;k<carList.size();k++){
							CarStock car = carList.get(k);
							String balanceType="";
							Integer supplierId=0;
							//根据运单id得到供应商id
							Waybill waybill = waybillMapper.getById(car.getWaybillId());
							if(null != waybill){
								supplierId = waybill.getSupplierId();
								//到供应商表中获取结算方式
								Supplier supplier = supplierMapper.getById(supplierId);
								if(null != supplier){
									balanceType = supplier.getBalanceType();
								}
							}
							
							if(Constants.BalanceType.PRICE.equals(balanceType)){//单价
								
								Map<String, Object> paramsBalance = new HashMap<String, Object>();
								paramsBalance.put("supplierId", supplierId);
								paramsBalance.put("delFlag", Constants.DelFlag.N);
								List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
								if(null !=balabceList && balabceList.size()>0){
									cashAmount = cashAmount +  balabceList.get(0).getPrice().doubleValue()*waybill.getDistance();
								}
								
							}else if(Constants.BalanceType.DISTANCE.equals(balanceType)){//公里数--具体到每辆商品车：供应商id、品牌、车型
								
								Map<String, Object> paramsBalance = new HashMap<String, Object>();
								paramsBalance.put("supplierId", supplierId);
								paramsBalance.put("brand", car.getBrand());
								paramsBalance.put("carType", car.getModel());
								paramsBalance.put("delFlag", Constants.DelFlag.N);
								List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
								if(null !=balabceList && balabceList.size()>0){
									cashAmount = cashAmount + balabceList.get(0).getPrice().doubleValue()*waybill.getDistance();
								}
								
							}else if(Constants.BalanceType.SUMPRICE.equals(balanceType)){//总价
								
								Map<String, Object> paramsBalance = new HashMap<String, Object>();
								paramsBalance.put("supplierId", supplierId);
								paramsBalance.put("delFlag", Constants.DelFlag.N);
								List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
								if(null !=balabceList && balabceList.size()>0){
									cashAmount = cashAmount +  balabceList.get(0).getPrice().doubleValue()/carList.size();
								}
								
							}
							
							
						}//for(int k=0;k<carList.size();k++){
					}
					
					
				}//for(int j=0;j<schDetail.size();j++){
				
				bean.setCashAmount((new BigDecimal(cashAmount)).setScale(2,BigDecimal.ROUND_HALF_UP));
				oilAmount = cashAmount*oilCostRatio/100;
				bean.setOilAmount((new BigDecimal(oilAmount)).setScale(2,BigDecimal.ROUND_HALF_UP));
				bean.setSumAmount((new BigDecimal(bean.getCashAmount().doubleValue()+bean.getOilAmount().doubleValue())).setScale(2,BigDecimal.ROUND_HALF_UP));
				
			}

		}
		
		return bean;
	}
	
	@Override
	@SystemServiceLog(description="执行对账")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void balance(Integer id, String oper) throws Exception {
		ScheduleBill bean = scheduleBillMapper.getById(id);
		
		if(null == bean){
			throw new RuntimeException("对账的调度单信息不存在，请检查");
		}
		
		//获取驳运费用、油费、油费结算比率、总金额
		bean = this.getScheduleBill(bean);
		
		//插入信息到对账信息表
		BalanceBill balance = new BalanceBill();
		balance.setType(Constants.BalanceBillType.DOWN);//1下游对账
		balance.setBusinessId(bean.getId());
		balance.setCarCount(bean.getAmount());
		//balance.setDistance(0);
		balance.setStatus(Constants.BalanceStatus.NEW);//0新建
		//balance.setBalanceType("");
		balance.setTransportAmount(bean.getCashAmount());
		balance.setOilAmount(bean.getOilAmount());
		balance.setOilBalanceRatio(bean.getOilBalanceRatio());
		balance.setBalanceAmount(bean.getSumAmount());
		balance.setMark("成本对账");
		balance.setInsertTime(new Date());
		balance.setInsertUser(oper);
		balance.setUpdateTime(new Date());
		balance.setUpdateUser(oper);
		balance.setDelFlag(Constants.DelFlag.N);
		balanceBillMapper.insert(balance);
	}
	
	public ScheduleBill getScheduleBill_old(ScheduleBill bean) throws Exception {
		
		//根据车牌号获取车队类型
		Map<String, Object> paramsTrack = new HashMap<String, Object>();
		paramsTrack.put("no", bean.getCarNumber());
		paramsTrack.put("delFlag", Constants.DelFlag.N);
		List<Track> trackList = trackMapper.getByConditions(paramsTrack);
		if(null !=trackList && trackList.size()>0){
			Integer outId = trackList.get(0).getOutSourcingId();
			if(outId==0){//公司车队
				bean.setCarTrackName("公司车队");
				
				//驳运费用、油费、总金额
				Map<String, Object> paramsCost = new HashMap<String, Object>();
				paramsCost.put("scheduleBillNo", bean.getScheduleBillNo());
				paramsCost.put("carNumber", bean.getCarNumber());
				paramsCost.put("status", Constants.CostApplyStatus.FINISH);
				paramsCost.put("delFlag", Constants.DelFlag.N);
				List<TransportCostApply> costList = transportCostApplyMapper.getByConditions(paramsCost);
				if(null !=costList && costList.size()>0){
					bean.setCashAmount((new BigDecimal(costList.get(0).getAmount())).setScale(2,BigDecimal.ROUND_HALF_UP));
					bean.setOilAmount((new BigDecimal(costList.get(0).getOilAmount())).setScale(2,BigDecimal.ROUND_HALF_UP));
					bean.setSumAmount((new BigDecimal( costList.get(0).getAmount() + costList.get(0).getOilAmount() )).setScale(2,BigDecimal.ROUND_HALF_UP));
				}
					
			}else{//外协车队
				bean.setCarTrackName("外协车队");
				
				//得到外协单位的油费计算比例
				Double  oilCostRatio = 0.0d;
				OutSourcing outSour = outSourcingMapper.getById(outId);
				if(null != outSour && null !=outSour.getTransportOilCostRatio()){
					oilCostRatio =outSour.getTransportOilCostRatio().doubleValue();
				}
				
				//驳运费用---具体到每辆商品车：供应商id、品牌、车型
				//得到调度单明细信息
				List<ScheduleBillDetail> schDetail = scheduleBillDetailMapper.getByBillNo(bean.getScheduleBillNo());
				if(null !=schDetail && schDetail.size()>0){
					Double cashAmount = 0.0d;
					Double oilAmount = 0.0d;
					
					for(int j=0;j<schDetail.size();j++){
						ScheduleBillDetail detail = schDetail.get(j);
						
						//获取商品车信息
						String carStockIds = detail.getCarStockIds();
						Map<String, Object> paramsCar = new HashMap<String, Object>();
						paramsCar.put("carStockIds", carStockIds);
						List<CarStock> carList = carStockMapper.getByConditions(paramsCar);
						if(null !=carList && carList.size()>0){
							for(int k=0;k<carList.size();k++){
								CarStock car = carList.get(k);
								String balanceType="";
								Integer supplierId=0;
								//根据运单id得到供应商id
								Waybill waybill = waybillMapper.getById(car.getWaybillId());
								if(null != waybill){
									supplierId = waybill.getSupplierId();
									//到供应商表中获取结算方式
									Supplier supplier = supplierMapper.getById(supplierId);
									if(null != supplier){
										balanceType = supplier.getBalanceType();
									}
								}
								
								if(Constants.BalanceType.PRICE.equals(balanceType)){//单价
									
									Map<String, Object> paramsBalance = new HashMap<String, Object>();
									paramsBalance.put("supplierId", supplierId);
									paramsBalance.put("delFlag", Constants.DelFlag.N);
									List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
									if(null !=balabceList && balabceList.size()>0){
										cashAmount = cashAmount +  balabceList.get(0).getPrice().doubleValue()*waybill.getDistance();
									}
									
								}else if(Constants.BalanceType.DISTANCE.equals(balanceType)){//公里数--具体到每辆商品车：供应商id、品牌、车型
									
									Map<String, Object> paramsBalance = new HashMap<String, Object>();
									paramsBalance.put("supplierId", supplierId);
									paramsBalance.put("brand", car.getBrand());
									paramsBalance.put("carType", car.getModel());
									paramsBalance.put("delFlag", Constants.DelFlag.N);
									List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
									if(null !=balabceList && balabceList.size()>0){
										cashAmount = cashAmount + balabceList.get(0).getPrice().doubleValue()*waybill.getDistance();
									}
									
								}else if(Constants.BalanceType.SUMPRICE.equals(balanceType)){//总价
									
									Map<String, Object> paramsBalance = new HashMap<String, Object>();
									paramsBalance.put("supplierId", supplierId);
									paramsBalance.put("delFlag", Constants.DelFlag.N);
									List<BalancePriceSetting> balabceList = balancePriceMapper.getByConditions(paramsBalance);
									if(null !=balabceList && balabceList.size()>0){
										cashAmount = cashAmount +  balabceList.get(0).getPrice().doubleValue();
									}
									
								}
								
								
							}//for(int k=0;k<carList.size();k++){
						}
						
						
					}//for(int j=0;j<schDetail.size();j++){
					
					bean.setCashAmount((new BigDecimal(cashAmount)).setScale(2,BigDecimal.ROUND_HALF_UP));
					oilAmount = cashAmount*oilCostRatio/100;
					bean.setOilAmount((new BigDecimal(oilAmount)).setScale(2,BigDecimal.ROUND_HALF_UP));
					bean.setSumAmount((new BigDecimal(bean.getCashAmount().doubleValue()+bean.getOilAmount().doubleValue())).setScale(2,BigDecimal.ROUND_HALF_UP));
					
				}
				
			}//外协车队
		}
		
		return bean;
	}
	

	@Override
	public double getSumPrice(Map<String, Object> params) throws Exception {
		
		double sumPrice = 0;
		//得到成本管理数据
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceCar> list = scheduleBillMapper.getCostByConditions(params);
		//进行解析
		list = this.getLastBalanceCar(list);
		
		for(int i=0;i<list.size();i++){
			sumPrice += list.get(i).getSumPrice();
		}
		
		return CommonUtil.formatDouble(sumPrice);
	}
}
