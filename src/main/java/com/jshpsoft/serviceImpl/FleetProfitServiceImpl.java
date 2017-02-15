package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.dao.OutSourcingMapper;
import com.jshpsoft.dao.SalaryPayDetailMapper;
import com.jshpsoft.dao.TrackInsuranceMapper;
import com.jshpsoft.dao.TrackMaintenanceApplyMapper;
import com.jshpsoft.dao.TrackMapper;
import com.jshpsoft.dao.TrackTyreChangeApplyMapper;
import com.jshpsoft.dao.TransportCostApplyMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.domain.FleetProfit;
import com.jshpsoft.domain.FleetProfitYM;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.domain.SalaryPayDetail;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.domain.TrackMaintenanceApply;
import com.jshpsoft.domain.TrackTyreChangeApply;
import com.jshpsoft.domain.TransportCostApply;
import com.jshpsoft.service.FleetProfitService;
import com.jshpsoft.service.IncomeMngService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;

/**
 * @author  ww 
 * @date 2017年1月11日 上午10:53:47
 */
@Service("fleetProfitService")
public class FleetProfitServiceImpl implements FleetProfitService {
	
	@Autowired  
	private OutSourcingMapper outSourcingMapper;
	
	@Autowired  
	private TrackMapper trackMapper;
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private IncomeMngService incomeMngService;
	
	@Autowired
	private TrackInsuranceMapper trackInsuranceMapper;
	
	@Autowired
	private TransportCostApplyMapper transportCostApplyMapper;
	
	@Autowired
	private TrackMaintenanceApplyMapper trackMaintenanceApplyMapper;
	
	@Autowired
	private SalaryPayDetailMapper salaryPayDetailMapper;
	
	@Autowired
	private TrackTyreChangeApplyMapper trackTyreChangeApplyMapper;

	@Override
	public List<FleetProfitYM> getListData(Map<String, Object> params)
			throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<FleetProfitYM> ymList = new ArrayList<FleetProfitYM>();//只有车队，车队也属于承运商,list只有一条
		Map<String,Object> par = new HashMap<String, Object>();
		par.put("delFlag", Constants.DelFlag.N);
		List<OutSourcing> ol = outSourcingMapper.getByConditions(par);
		Integer outSouringId = 0;//车队id
		if(null != ol && ol.size() > 0)
		{
			for(int i = 0;i<ol.size();i++)
			{
				if("车队".equals(ol.get(i).getName()))
				{
					outSouringId = ol.get(i).getId();
				}
			}
		}
		String sendTime  = "";//前台参数  年月
		if(null != params.get("sendTime") && "" != params.get("sendTime"))
		{
			sendTime = params.get("sendTime").toString();
			params.put("sendTimeYear", sendTime.substring(0,sendTime.length()-3));//先查出全年的
		}
		else
		{
			throw new RuntimeException("日期为空!");
		}
		params.put("sendTimeYear",params.get("sendTime"));
		//params.put("pageStartIndex", 0);
		//params.put("pageEndIndex", 10);
		//状态:1,2,3  类型 0,1
		params.put("statusIn", Constants.WaibillStatus.UNREVIEW.getValue() + "," + Constants.WaibillStatus.UNRECEIPT.getValue() + "," + Constants.WaibillStatus.FINISHED.getValue() );
		params.put("typeIn", Constants.WaybillType.SPC+ "," +Constants.WaybillType.ESC);
		params.put("delFlag", Constants.DelFlag.N);
		params.put("notWhere", "notWhere");
		List<BalanceCar> list = waybillMapper.getInComePageList(params);
		//进行解析
		if(null !=list && list.size()>0){
			for(int i=0;i<list.size();i++){
				BalanceCar bean = list.get(i);
				bean = incomeMngService.getBalanceCar(bean);//获取每台的数据
			}
		}
		
		FleetProfitYM ym = new FleetProfitYM();
		FleetProfit mfp = new FleetProfit();//月利润
		FleetProfit yfp = new FleetProfit();//年利润
		BigDecimal mcarIncome = new BigDecimal("0");//月   商品车
		BigDecimal mshCarIncome = new BigDecimal("0");//月   二手车
		BigDecimal ycarIncome = new BigDecimal("0");//年   商品车
		BigDecimal yshCarIncome = new BigDecimal("0");//年    二手车
		if(null != list && list.size() > 0)
		{
			for(int j = 0;j<list.size();j++)
			{
				BalanceCar b = list.get(j);
					Track track = trackMapper.getByCarNumber(b.getCarNumber());//车牌号查询承运商
					if(null != track)
					{
						if(outSouringId.equals(track.getOutSourcingId()))//等于车队
						{
							if("0".equals(b.getType()))//商品车
							{
								ycarIncome = new BigDecimal(b.getBalancePrice()+"").add(ycarIncome);
							}
							if("1".equals(b.getType()))//二手车
							{
								yshCarIncome = new BigDecimal(b.getBalancePrice()+"").add(yshCarIncome);
							}
							if(null != b.getScheduleDate() && "" != b.getScheduleDate())
							{
								String scheduleDate = b.getScheduleDate().substring(0,b.getScheduleDate().length()-3);
								if(scheduleDate.equals(sendTime))//年月相等
								{
									if("0".equals(b.getType()))//商品车
									{
										mcarIncome = new BigDecimal(b.getBalancePrice()+"").add(mcarIncome);
									}
									if("1".equals(b.getType()))//二手车
									{
										mshCarIncome = new BigDecimal(b.getBalancePrice()+"").add(mshCarIncome);
									}
								}
							}
						}
					}
			}
		}
		mfp.setCarIncome(mcarIncome.doubleValue());
		mfp.setShCarIncome(mshCarIncome.doubleValue());
		yfp.setCarIncome(ycarIncome.doubleValue());
		yfp.setShCarIncome(yshCarIncome.doubleValue()); 
		
		//保险赔款
		BigDecimal minsuranceIncome = new BigDecimal("0");//月
		BigDecimal yinsuranceIncome = new BigDecimal("0");//年
		//保险分摊
		BigDecimal minsuranceCost = new BigDecimal("0");//月
		BigDecimal yinsuranceCost = new BigDecimal("0");//年
		
		//par.put("type", Constants.InsurancePayType.IN);//出险
		par.put("reportTime", sendTime.substring(0,sendTime.length()-3));//年
		List<TrackInsurance> tiList = trackInsuranceMapper.getByConditions(par);
		if(null != tiList && tiList.size() > 0)
		{
			for(int i = 0;i<tiList.size();i++)
			{
				Track track = trackMapper.getByCarNumber(tiList.get(i).getCarNumber());
				if(null != track)
				{
					if(outSouringId.equals(track.getOutSourcingId()))//等于车队
					{
						if(Constants.InsurancePayType.IN.equals(tiList.get(i).getType()))
						{
							yinsuranceIncome = tiList.get(i).getAmount().add(yinsuranceIncome);
							if(null != tiList.get(i).getReportTime())
							{
								String reportTime = sdf.format(tiList.get(i).getReportTime());
								String rtime = reportTime.substring(0,reportTime.length()-3);
								if(rtime.equals(sendTime))
								{
									minsuranceIncome = tiList.get(i).getAmount().add(minsuranceIncome);
								}
							}
						}
						if(Constants.InsurancePayType.OUT.equals(tiList.get(i).getType()))
						{
							yinsuranceCost = tiList.get(i).getAmount().add(yinsuranceCost);
							if(null != tiList.get(i).getReportTime())
							{
								String reportTime = sdf.format(tiList.get(i).getReportTime());
								String rtime = reportTime.substring(0,reportTime.length()-3);
								if(rtime.equals(sendTime))
								{
									minsuranceCost = tiList.get(i).getAmount().add(minsuranceCost);
								}
							}
						}
					}
				}
			}
		}
		mfp.setInsuranceIncome(minsuranceIncome.doubleValue());
		yfp.setInsuranceIncome(yinsuranceIncome.doubleValue());
		mfp.setInsuranceCost(minsuranceCost.doubleValue());
		yfp.setInsuranceCost(yinsuranceCost.doubleValue());
		mfp.setIncomeSum((mcarIncome.add(mshCarIncome).add(minsuranceIncome)).doubleValue());//月收入总费用
		yfp.setIncomeSum((ycarIncome.add(yshCarIncome).add(yinsuranceIncome)).doubleValue());//年收入总费用
		
		
		//运输在途费用(驾驶员报销   现金+油费)
		BigDecimal mdriverCost = new BigDecimal("0");//月驾驶员报销
		BigDecimal ydriverCost = new BigDecimal("0");//年驾驶员报销
		//油卡折现成本     计算公式=收入乘以40%减去当期驾驶员报账的油卡费用再乘以0.05
		BigDecimal moilCardCost =new BigDecimal("0");//月油卡折现成本
		BigDecimal yoilCardCost = new BigDecimal("0");//年油卡折现成本
		BigDecimal moilAmount = new BigDecimal("0");//月 总油费
		BigDecimal yoilAmount = new BigDecimal("0");//年总油费
		par.clear();
		par.put("delFlag", Constants.DelFlag.N);
		par.put("applyTime", sendTime.substring(0,sendTime.length()-3));
		List<TransportCostApply> tcList= transportCostApplyMapper.getByConditions(par);
		if(null != tcList && tcList.size() > 0)
		{
			for(int i = 0;i<tcList.size();i++)
			{
				Track track = trackMapper.getByCarNumber(tcList.get(i).getCarNumber());
				if(null != track)
				{
					if(outSouringId.equals(track.getOutSourcingId()))//等于车队
					{
						ydriverCost = new BigDecimal(tcList.get(i).getOilAmount()+"").add(new BigDecimal(tcList.get(i).getAmount()+"")).add(ydriverCost);
						yoilAmount = new BigDecimal(tcList.get(i).getOilAmount()+"").add(yoilAmount);
						if(null != tcList.get(i).getApplyTime())
						{
							String applyTime = sdf.format(tcList.get(i).getApplyTime());
							String atime = applyTime.substring(0,applyTime.length()-3);
							if(atime.equals(sendTime))
							{
								mdriverCost = new BigDecimal(tcList.get(i).getOilAmount()+"").add(new BigDecimal(tcList.get(i).getAmount()+"")).add(mdriverCost);
								moilAmount = new BigDecimal(tcList.get(i).getOilAmount()+"").add(moilAmount);
							}
						}
					}
				}
			}
		}
		mfp.setDriverCost(mdriverCost.doubleValue());
		yfp.setDriverCost(ydriverCost.doubleValue());
		BigDecimal a = new BigDecimal(mfp.getIncomeSum()+"").multiply(new BigDecimal("0.4"));
		BigDecimal b = a.subtract(moilAmount);
		BigDecimal c = b.multiply(new BigDecimal("0.05"));
		
		BigDecimal d = new BigDecimal(yfp.getIncomeSum()+"").multiply(new BigDecimal("0.4"));
		BigDecimal e = d.subtract(yoilAmount);
		BigDecimal f = e.multiply(new BigDecimal("0.05"));
		
		moilCardCost = c;
		yoilCardCost = f;
		mfp.setOilCardCost(CommonUtil.formatDouble(moilCardCost.doubleValue()));
		yfp.setOilCardCost(CommonUtil.formatDouble(yoilCardCost.doubleValue()));
		
		//鲁卡通
		BigDecimal mlukatong = new BigDecimal("0");
		BigDecimal ylukatong = new BigDecimal("0");
		
		mfp.setLukatong(mlukatong.doubleValue());
		yfp.setLukatong(ylukatong.doubleValue());
		
		//大车维修包月费
		BigDecimal mcarRepairCost = new BigDecimal("0");
		BigDecimal ycarRepairCost = new BigDecimal("0");
		par.clear();
		par.put("delFlag", Constants.DelFlag.N);
		par.put("insertTime", sendTime.substring(0,sendTime.length()-3));
		List<TrackMaintenanceApply> taList = trackMaintenanceApplyMapper.getByConditions(par);
		if(null != taList && taList.size() > 0)
		{
			for(int i = 0;i<taList.size();i++)
			{
				Track track = trackMapper.getByCarNumber(taList.get(i).getCarNumber());
				if(null != track)
				{
					if(outSouringId.equals(track.getOutSourcingId()))//等于车队
					{
						ycarRepairCost = taList.get(i).getAmount().add(ycarRepairCost);
						if(null != taList.get(i).getInsertTime())
						{
							String insertTime = sdf.format(taList.get(i).getInsertTime());
							String itime = insertTime.substring(0,insertTime.length()-3);
							if(itime.equals(sendTime))
							{
								mcarRepairCost = taList.get(i).getAmount().add(mcarRepairCost);
							}
						}
					}
				}
			}
		}
		mfp.setCarRepairCost(mcarRepairCost.doubleValue());
		yfp.setCarRepairCost(ycarRepairCost.doubleValue());
		
		//驾驶员工资
		BigDecimal mdriverPay = new BigDecimal("0");
		BigDecimal ydriverPay = new BigDecimal("0");
		par.clear();
		par.put("delFlag", Constants.DelFlag.N);
		par.put("driverFlag", Constants.DelFlag.Y);
		par.put("salaryTime", sendTime.substring(0, sendTime.length()-3));
		List<SalaryPayDetail> spList = salaryPayDetailMapper.getByConditions(par);
		if(null != spList && spList.size() > 0)
		{
			for(int i = 0;i < spList.size();i++)
			{
				Map<String,Object> p = new HashMap<String, Object>();
				p.put("delFlag", Constants.DelFlag.N);
				p.put("driverId", spList.get(i).getUserId());
				List<Track> tracklist = trackMapper.getByConditions(p); 
				if(null != tracklist && tracklist.size() > 0)
				{
					Track track = tracklist.get(0);
					if(null != track)
					{
						if(outSouringId.equals(track.getOutSourcingId()))//等于车队
						{
							ydriverPay = new BigDecimal(spList.get(i).getAmount()+"").add(ydriverPay);
							if(null != spList.get(i).getSalaryTime() && "" != spList.get(i).getSalaryTime())
							{
								String salaryTime = spList.get(i).getSalaryTime();
								if(salaryTime.equals(sendTime))
								{
									mdriverPay = new BigDecimal(spList.get(i).getAmount()+"").add(mdriverPay);
								}
							}
						}
					}
				}
			}
		}
		mfp.setDriverPay(mdriverPay.doubleValue());
		yfp.setDriverPay(ydriverPay.doubleValue());
		
		//车队办公人员工资
		BigDecimal mofficePay = new BigDecimal("0");
		BigDecimal yofficePay = new BigDecimal("0");
		
		mfp.setOfficePay(mofficePay.doubleValue());
		yfp.setOfficePay(yofficePay.doubleValue());
		
		//轮胎费用  审核通过的  状态为2
		BigDecimal mtireCost = new BigDecimal("0");
		BigDecimal ytireCost = new BigDecimal("0");
		par.clear();
		par.put("delFlag", Constants.DelFlag.N);
		par.put("status", Constants.TrackTyreChangeStatus.FINISH);
		par.put("insertTime", sendTime.substring(0, sendTime.length()-3));
		List<TrackTyreChangeApply> ttcList = trackTyreChangeApplyMapper.getByConditions(par);
		if(null != ttcList && ttcList.size() > 0)
		{
			for(int i = 0;i<ttcList.size();i++)
			{
				Track track = trackMapper.getByCarNumber(ttcList.get(i).getCarNumber());
				if(null != track)
				{
					if(outSouringId.equals(track.getOutSourcingId()))//等于车队
					{
						ytireCost = new BigDecimal(ttcList.get(i).getPrice()+"").add(ytireCost) ;
						if(null != ttcList.get(i).getInsertTime())
						{
							String insertTime = sdf.format(ttcList.get(i).getInsertTime());
							String itime = insertTime.substring(0,insertTime.length()-3);
							if(itime.equals(itime))
							{
								mtireCost = new BigDecimal(ttcList.get(i).getPrice()+"").add(mtireCost);
							}
						}
					}
				}
			}
		}
		mfp.setTireCost(mtireCost.doubleValue());
		yfp.setTireCost(ytireCost.doubleValue());
		
		//车队费用
		BigDecimal mfleetCost = new BigDecimal("0");
		BigDecimal yfleetCost = new BigDecimal("0");
		
		mfp.setFleetCost(mfleetCost.doubleValue());
		yfp.setFleetCost(yfleetCost.doubleValue());
		
		//场地租金
		BigDecimal mrentCost = new BigDecimal("0");
		BigDecimal yrentCost = new BigDecimal("0");
		mfp.setRentCost(mrentCost.doubleValue());
		yfp.setRentCost(yrentCost.doubleValue());
		
		//挂车年审
		BigDecimal mtrailerCost = new BigDecimal("0");
		BigDecimal ytrailerCost = new BigDecimal("0");
		mfp.setTrailerCost(mtrailerCost.doubleValue());
		yfp.setTrailerCost(ytrailerCost.doubleValue());
		
		//二维
		BigDecimal merWeiCost = new BigDecimal("0");
		BigDecimal yerWeiCost = new BigDecimal("0");
		mfp.setErWeiCost(merWeiCost.doubleValue());
		yfp.setErWeiCost(yerWeiCost.doubleValue());
			
		BigDecimal costSum = mdriverCost.add(mlukatong).add(minsuranceCost).add(mcarRepairCost).add(mdriverPay).add(mofficePay).add(mtireCost).add(mfleetCost).add(mrentCost).add(mtrailerCost).add(merWeiCost).add(moilCardCost);
		mfp.setCostSum(CommonUtil.formatDouble(costSum.doubleValue()));
		BigDecimal costSum2 = ydriverCost.add(ylukatong).add(yinsuranceCost).add(ycarRepairCost).add(ydriverPay).add(yofficePay).add(ytireCost).add(yfleetCost).add(yrentCost).add(ytrailerCost).add(yerWeiCost).add(yoilCardCost);
		yfp.setCostSum(CommonUtil.formatDouble(costSum2.doubleValue()));
		
		ym.setMonthProfit(mfp);
		ym.setYearProfit(yfp);
		ymList.add(ym);
		return ymList;
	}

	@Override
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		List<FleetProfitYM> list = this.getListData(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "车队利润表");//
		sheetData.put("titleMergeSize", 3);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("项目");
		tableHeadList.add("本月金额");
		tableHeadList.add("本年金额");
		sheetData.put("tableHeader", tableHeadList);

		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		if(null != list && list.size() > 0)
		{
			FleetProfitYM ym = list.get(0);
			FleetProfit mfp = ym.getMonthProfit();
			FleetProfit yfp = ym.getYearProfit();
				//加载数据
				List<String> rowData = new ArrayList<String>();
				rowData.add("车队运费总收入");
				rowData.add(mfp.getIncomeSum()+"");
				rowData.add(yfp.getIncomeSum()+"");
				
				List<String> rowData2 = new ArrayList<String>();
				rowData2.add("其中：主营计划收入");
				rowData2.add(mfp.getCarIncome()+"");
				rowData2.add(yfp.getCarIncome()+"");
				
				List<String> rowData3 = new ArrayList<String>();
				rowData3.add("二手车及其他");
				rowData3.add(mfp.getShCarIncome()+"");
				rowData3.add(yfp.getShCarIncome()+"");
				
				List<String> rowData4 = new ArrayList<String>();
				rowData4.add("保险赔款");
				rowData4.add(mfp.getInsuranceIncome()+"");
				rowData4.add(yfp.getInsuranceIncome()+"");
				
				List<String> rowData5 = new ArrayList<String>();
				rowData5.add("车队运费成本");
				rowData5.add(mfp.getCostSum()+"");
				rowData5.add(yfp.getCostSum()+"");
				
				List<String> rowData6 = new ArrayList<String>();
				rowData6.add("其中：运输在途成本");
				rowData6.add(mfp.getDriverCost()+"");
				rowData6.add(yfp.getDriverCost()+"");
				
				List<String> rowData7 = new ArrayList<String>();
				rowData7.add("鲁卡通费用");
				rowData7.add(mfp.getLukatong()+"");
				rowData7.add(yfp.getLukatong()+"");
				
				List<String> rowData8 = new ArrayList<String>();
				rowData8.add("保险分摊(月分摊)");
				rowData8.add(mfp.getInsuranceCost()+"");
				rowData8.add(yfp.getInsuranceCost()+"");
				
				List<String> rowData9 = new ArrayList<String>();
				rowData9.add("大车维修包月费");
				rowData9.add(mfp.getCarRepairCost()+"");
				rowData9.add(yfp.getCarRepairCost()+"");
				
				List<String> rowData10 = new ArrayList<String>();
				rowData10.add("驾驶员工资");
				rowData10.add(mfp.getDriverPay()+"");
				rowData10.add(yfp.getDriverPay()+"");
				
				List<String> rowData11 = new ArrayList<String>();
				rowData11.add("车队办公人员工资");
				rowData11.add(mfp.getOfficePay()+"");
				rowData11.add(yfp.getOfficePay()+"");
				
				List<String> rowData12 = new ArrayList<String>();
				rowData12.add("轮胎费用");
				rowData12.add(mfp.getTireCost()+"");
				rowData12.add(yfp.getTireCost()+"");
				
				List<String> rowData13 = new ArrayList<String>();
				rowData13.add("车队费用");
				rowData13.add(mfp.getFleetCost()+"");
				rowData13.add(yfp.getFleetCost()+"");
				
				List<String> rowData14 = new ArrayList<String>();
				rowData14.add("场地租金");
				rowData14.add(mfp.getRentCost()+"");
				rowData14.add(yfp.getRentCost()+"");
				
				List<String> rowData15 = new ArrayList<String>();
				rowData15.add("挂车年审(月分摊)");
				rowData15.add(mfp.getTrailerCost()+"");
				rowData15.add(yfp.getTrailerCost()+"");
				
				List<String> rowData16 = new ArrayList<String>();
				rowData16.add("二维(月分摊)");
				rowData16.add(mfp.getErWeiCost()+"");
				rowData16.add(yfp.getErWeiCost()+"");
				
				List<String> rowData17 = new ArrayList<String>();
				rowData17.add("油卡折现成本");
				rowData17.add(mfp.getOilCardCost()+"");
				rowData17.add(yfp.getOilCardCost()+"");
				
				List<String> rowData18 = new ArrayList<String>();
				rowData18.add("本月利润");
				rowData18.add((new BigDecimal(mfp.getIncomeSum()+"").subtract(new BigDecimal(mfp.getCostSum()+""))).doubleValue()+"");
				rowData18.add((new BigDecimal(yfp.getIncomeSum()+"").subtract(new BigDecimal(yfp.getCostSum()+""))).doubleValue()+"");
				
				tableData.add(rowData);
				tableData.add(rowData2);
				tableData.add(rowData3);
				tableData.add(rowData4);
				tableData.add(rowData5);
				tableData.add(rowData6);
				tableData.add(rowData7);
				tableData.add(rowData8);
				tableData.add(rowData9);
				tableData.add(rowData10);
				tableData.add(rowData11);
				tableData.add(rowData12);
				tableData.add(rowData13);
				tableData.add(rowData14);
				tableData.add(rowData15);
				tableData.add(rowData16);
				tableData.add(rowData17);
				tableData.add(rowData18);
				
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

}
