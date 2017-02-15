package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.ScheduleBillDetailMapper;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.domain.OneWayProfit;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.service.CostMngService;
import com.jshpsoft.service.IncomeMngService;
import com.jshpsoft.service.OneWayProfitService;
import com.jshpsoft.util.Constants;

/**
 * 单程利润计算表
 * @author  ww 
 * @date 2017年1月9日 下午1:04:26
 */
@Service("oneWayProfitService")
public class OneWayProfitServiceImpl implements OneWayProfitService {
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private IncomeMngService incomeMngService;
	
	@Autowired
	private CostMngService costMngService;
	
	@Autowired
	private ScheduleBillDetailMapper scheduleBillDetailMapper;
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private CarStockMapper carStockMapper;

	@Override
	public List<OneWayProfit> getListData(Map<String, Object> params)
			throws Exception {
		/*String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}*/
		params.put("delFlag", Constants.DelFlag.N);
		List<ScheduleBill> slist = scheduleBillMapper.getByConditions(params);
		return this.getProfitList(slist, params);
	}

	public List<OneWayProfit> getProfitList(List<ScheduleBill> slist, Map<String, Object> scheduleParams) throws Exception
	{
		List<OneWayProfit> oplist = new ArrayList<OneWayProfit>();
		
		Map<String, Object> params = new HashMap<String, Object>();
		//调度单的过滤条件
		params.putAll(scheduleParams);
		
		long start = System.currentTimeMillis();
		params.put("notWhere", "notWhere");
		//状态:1,2,3  类型 0,1
		params.put("statusIn", Constants.WaibillStatus.UNREVIEW.getValue() + "," + Constants.WaibillStatus.UNRECEIPT.getValue() + "," + Constants.WaibillStatus.FINISHED.getValue() );
		params.put("typeIn", Constants.WaybillType.SPC+ "," +Constants.WaybillType.ESC);
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceCar> list = waybillMapper.getInComePageList(params);
		long start2 = System.currentTimeMillis();
		System.out.println("---getInComePageList："+(start2-start));
		
		long start3 = 0;
		//进行解析
		if(null !=list && list.size()>0){
			for(int i=0;i<list.size();i++){
				BalanceCar bean = list.get(i);
				bean = incomeMngService.getBalanceCar(bean);//获取每台的数据
				if( i==0){
					start3 = System.currentTimeMillis();
					
				}
			}
		}
		System.out.println("---getBalanceCar单次："+(start3-start2));
		
		long start4 = System.currentTimeMillis();
		System.out.println("---getBalanceCar整个："+list.size()+"----"+(start4-start2));
		
		params.clear();
		//调度单的过滤条件
		params.putAll(scheduleParams);
		params.put("notWhere", "notWhere");
		//状态:3,4;调度单明细类型:0,2
		params.put("statusIn", Constants.ScheduleBillStatus.ONWAY + "," + Constants.ScheduleBillStatus.FINISH );
		params.put("typeIn", Constants.ScheduleDetailType.SPC+ "," +Constants.ScheduleDetailType.ESC);
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceCar> blist = scheduleBillMapper.getCostPageList(params);
		long start5 = System.currentTimeMillis();
		System.out.println("----getCostPageList："+(start5-start4));
		long start6 = 0;
		if(null != blist && blist.size() > 0)
		{
			for(int i = 0;i<blist.size();i++)
			{
				BalanceCar bean = blist.get(i);
				bean = costMngService.getBalanceCar(bean);
				if( i==0){
					start6 = System.currentTimeMillis();
					
				}
			}
		}
		System.out.println("---getBalanceCar单次："+(start6-start5));
		long start7 = System.currentTimeMillis();
		System.out.println("---getBalanceCar整个："+blist.size()+"----"+(start7-start5));
		//根据调度单合并应收运费
		if(null != slist && slist.size() > 0) 
		{
			for(int i = 0;i<slist.size();i++)
			{
				OneWayProfit owp = new OneWayProfit();
				BigDecimal receiveMoney = new BigDecimal("0");//应收运费
				BigDecimal onWayMoney = new BigDecimal("0");//在途费用
				owp.setId(slist.get(i).getId());
				owp.setScheduleBillNo(slist.get(i).getScheduleBillNo());
				owp.setSendTime(slist.get(i).getSendTime());
				owp.setCarNumber(slist.get(i).getCarNumber());
				owp.setDriverName(slist.get(i).getDriverName());
				if(null != slist.get(i).getAmount() && !"".equals(slist.get(i).getAmount()))
				{
					owp.setAmount(slist.get(i).getAmount());
				}
				else
				{
					owp.setAmount(0);
				}
				
				if(null != list && list.size() > 0)
				{
					for(int j = 0;j<list.size();j++)
					{
						if(null !=list.get(j).getScheduleBillNo() && !"".equals(list.get(j).getScheduleBillNo()))
						{
							if(slist.get(i).getScheduleBillNo().equals(list.get(j).getScheduleBillNo()))
							{
								receiveMoney = new BigDecimal(list.get(j).getBalancePrice()+"").add(receiveMoney);
								
							}
						}
					}
				}
				
				if(null != blist && blist.size() > 0)
				{
					for(int k = 0;k<blist.size();k++)
					{
						if(null !=blist.get(k).getScheduleBillNo() && !"".equals(blist.get(k).getScheduleBillNo()))
						{
							if(slist.get(i).getScheduleBillNo().equals(blist.get(k).getScheduleBillNo()))
							{
								onWayMoney =new BigDecimal(blist.get(k).getBalancePrice()+"").add(onWayMoney);
								
							}
						}
					}
				}
				owp.setReceiveMoney(receiveMoney.doubleValue());
				owp.setOnWayMoney(onWayMoney.doubleValue());
				owp.setChaMoney(receiveMoney.subtract(onWayMoney).doubleValue());
				oplist.add(owp);
			}
		}
		long end = System.currentTimeMillis();
		System.err.println("-----总："+"---"+blist.size()+"---"+(end-start));
		
		
////----------------------------------------------------------------拼接bean在查询---------------------------------------------------------------------------------------------------		
//		List<OneWayProfit> oplist = new ArrayList<OneWayProfit>();
//		long start = System.currentTimeMillis();
//		long start2 = 0;
//		if(null != slist && slist.size() > 0) 
//		{
//			for(int i = 0;i<slist.size();i++)
//			{
//				OneWayProfit owp = new OneWayProfit();
//				BigDecimal receiveMoney = new BigDecimal("0");//应收运费
//				BigDecimal onWayMoney = new BigDecimal("0");//在途费用
//				owp.setId(slist.get(i).getId());
//				owp.setScheduleBillNo(slist.get(i).getScheduleBillNo());
//				owp.setSendTime(slist.get(i).getSendTime());
//				owp.setCarNumber(slist.get(i).getCarNumber());
//				owp.setDriverName(slist.get(i).getDriverName());
//				if(null != slist.get(i).getAmount() && !"".equals(slist.get(i).getAmount()))
//				{
//					owp.setAmount(slist.get(i).getAmount());
//				}
//				else
//				{
//					owp.setAmount(0);
//				}
//				
//				//得到调度单明细中的库存车子id
//				List<ScheduleBillDetail> sdList = scheduleBillDetailMapper.getByBillNo(slist.get(i).getScheduleBillNo());
//				if(null != sdList && sdList.size() > 0)
//				{
//					for(int m=0; m<sdList.size(); m++)
//					{
//						ScheduleBillDetail sd = sdList.get(m);
//						if(null != sd.getCarStockIds() && !"".equals(sd.getCarStockIds()))
//						{
//							String[] ids = sd.getCarStockIds().split(",");
//							if(ids.length > 0)
//							{
//								for(int j = 0;j<ids.length;j++)
//								{
//									long start3 = System.currentTimeMillis();
//									BalanceCar bean = new BalanceCar();
//									CarStock carStock = carStockMapper.getById(Integer.parseInt(ids[j]));
//									bean.setId(carStock.getId());
//									if(null == carStock.getTransportPrice())
//									{
//										bean.setBalancePrice(0);//价格  对于二手车
//									}
//									else
//									{
//										bean.setBalancePrice(carStock.getTransportPrice().doubleValue());//价格  对于二手车
//									}
//									bean.setBrand(carStock.getBrand());//品牌
//									bean.setModel(carStock.getModel());//车型
//									Waybill waybill = waybillMapper.getById(carStock.getWaybillId());
//									bean.setSupplierId(waybill.getSupplierId());
//									bean.setStartAddress(waybill.getStartAddress());
//									bean.setTargetProvince(waybill.getTargetProvince());
//									bean.setTargetCity(waybill.getTargetCity());
//									bean.setScheduleBillNo(slist.get(i).getScheduleBillNo());
//									System.out.println("---111:"+(System.currentTimeMillis()-start3));
//									bean = incomeMngService.getBalanceCar(bean);//收入
//									receiveMoney = new BigDecimal(bean.getBalancePrice()+"").add(receiveMoney);
//									System.out.println("---收入  一辆车的时间："+(System.currentTimeMillis()-start3));
//									long start4 = System.currentTimeMillis();
//									BalanceCar bean2 = new BalanceCar();
//									bean2.setId(carStock.getId());
//									if(null == carStock.getTransportPrice())
//									{
//										bean2.setBalancePrice(0);//价格  对于二手车
//									}
//									else
//									{
//										bean2.setBalancePrice(carStock.getTransportPrice().doubleValue());//价格  对于二手车
//									}
//									bean2.setBrand(carStock.getBrand());//品牌
//									bean2.setModel(carStock.getModel());//车型
//									bean2.setOutSourcingId(slist.get(i).getOutSourcingId());
//									bean2.setSupplierId(waybill.getSupplierId());
//									bean2.setStartAddress(waybill.getStartAddress());
//									bean2.setTargetProvince(waybill.getTargetProvince());
//									bean2.setTargetCity(waybill.getTargetCity());
//									bean2.setScheduleBillNo(slist.get(i).getScheduleBillNo());
//									bean2 = costMngService.getBalanceCar(bean2);//在途
//									onWayMoney =new BigDecimal(bean2.getBalancePrice()+"").add(onWayMoney);
//									System.out.println("--在途   一辆车的时间："+(System.currentTimeMillis()-start4));
//									System.out.println("----一辆车总的时间："+(System.currentTimeMillis()-start3));
//								}
//							}
//						}
//					}
//				}
//				owp.setReceiveMoney(receiveMoney.doubleValue());
//				owp.setOnWayMoney(onWayMoney.doubleValue());
//				owp.setChaMoney(receiveMoney.subtract(onWayMoney).doubleValue());
//				oplist.add(owp);
//				
//				if(i==0){
//					start2 = System.currentTimeMillis();
//				}
//				System.out.println("----一个调度单循环的时间:"+(start2-start));
//			}
//		}
//		long end = System.currentTimeMillis();
//		System.err.println("-----总："+(end-start));
//		
		
		
		return oplist;
		
	}

	@Override
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		List<OneWayProfit> list = this.getListData(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "单程利润计算表");//
		sheetData.put("titleMergeSize", 9);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("调度单号");
		tableHeadList.add("装运日期");
		tableHeadList.add("装运车号");
		tableHeadList.add("驾驶员");
		tableHeadList.add("台数");
		tableHeadList.add("应收运费");
		tableHeadList.add("在途费用");
		tableHeadList.add("毛利润");
		sheetData.put("tableHeader", tableHeadList);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		if(null != list && list.size() > 0)
		{
			for(int i=0;i<list.size();i++){
				//获取每一行数据
				OneWayProfit op = list.get(i);
				
				//加载数据
				List<String> rowData = new ArrayList<String>();
				rowData.add(String.valueOf(i+1));
				rowData.add(op.getScheduleBillNo());
				if(null != op.getSendTime())
				{
					rowData.add( sdf.format(op.getSendTime()) );
				}
				else
				{
					rowData.add("");
				}
				rowData.add(op.getCarNumber());
				rowData.add(op.getDriverName());
				rowData.add(op.getAmount()+"");
				rowData.add(op.getReceiveMoney()+"");
				rowData.add(op.getOnWayMoney()+"");
				BigDecimal bd1 = new BigDecimal(Double.toString(op.getReceiveMoney())); 
				BigDecimal bd2 = new BigDecimal(Double.toString(op.getOnWayMoney())); 
				rowData.add(bd1.subtract(bd2).doubleValue()+"");
				
				tableData.add(rowData);
			}
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}
}
