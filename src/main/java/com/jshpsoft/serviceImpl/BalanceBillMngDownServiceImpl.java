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
import com.jshpsoft.dao.BalanceBillMapper;
import com.jshpsoft.dao.BusinessOperateLogMapper;
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.ScheduleBillDetailMapper;
import com.jshpsoft.domain.BalanceBill;
import com.jshpsoft.domain.BusinessOperateLog;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.ScheduleBillDetail;
import com.jshpsoft.service.BalanceBillMngDownService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("balanceBillMngDownService")
public class BalanceBillMngDownServiceImpl implements BalanceBillMngDownService {
	
	@Autowired
	private BalanceBillMapper balanceBillMapper;
	
	@Autowired
	private CarStockMapper carStockMapper;	
	
	@Autowired
	private BusinessOperateLogMapper businessOperateLogMapper;
	
	@Autowired
	private ScheduleBillDetailMapper scheduleBillDetailMapper;
	
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
		List<BalanceBill> list = balanceBillMapper.getPageListDown(params);
		int totalCount = balanceBillMapper.getPageTotalCountDown(params);
		
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
		BalanceBill bean = balanceBillMapper.getDetailByIdDown(id);
		if(null != bean){
			
			List<ScheduleBillDetail> detailList = scheduleBillDetailMapper.getByBillNo(bean.getScheduleBillNo());
			
			bean.setScheduleList(detailList);
			
			if(null != detailList && detailList.size()>0){
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
					
				}
			}
			
		}
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
		if(beanOld.getTransportAmount()!=bean.getTransportAmount()){
			operateDetail += "驳运费用由"+beanOld.getTransportAmount()+"修改为"+bean.getTransportAmount()+",";
		}
		if(beanOld.getOilAmount()!=bean.getOilAmount()){
			operateDetail += "总油费由"+beanOld.getOilAmount()+"修改为"+bean.getOilAmount()+",";
		}
		if(beanOld.getOilBalanceRatio()!=bean.getOilBalanceRatio()){
			operateDetail += "油费结算比率由"+beanOld.getOilBalanceRatio()+"修改为"+bean.getOilBalanceRatio()+",";
		}
		if(beanOld.getBalanceAmount()!=bean.getBalanceAmount()){
			operateDetail += "结算总金额由"+beanOld.getBalanceAmount()+"修改为"+bean.getBalanceAmount()+",";
		}
		
		if(!operateDetail.equals("")){
			BusinessOperateLog log = new BusinessOperateLog();
			log.setType(Constants.BusinessLogType.BALANCEDOWN);//11
			log.setDetailId(bean.getId());
			log.setOperate("更新");
			log.setOperator(oper);
			log.setOperateTime(new Date());
			log.setOperateDetail(operateDetail);
			businessOperateLogMapper.insert(log);
		}
		
		//更新
		beanOld.setCarCount(bean.getCarCount());
		beanOld.setTransportAmount(bean.getTransportAmount());
		beanOld.setOilAmount(bean.getOilAmount());
		beanOld.setOilBalanceRatio(bean.getOilBalanceRatio());
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
		return balanceBillMapper.getByConditionsDown(params);
	}


	@Override
	@SystemServiceLog(description="导出对账信息列表")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到对账信息
		params.put("delFlag", Constants.DelFlag.N);
		List<BalanceBill> detailList = balanceBillMapper.getByConditionsDown(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "下游对账信息列表");//
		sheetData.put("titleMergeSize", 8);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("车队名称");
		tableHeadList.add("调度单号");
		tableHeadList.add("台数");
		tableHeadList.add("结算总金额");
		tableHeadList.add("状态");
		tableHeadList.add("调度时间");
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
			rowData.add(balanceBill.getCarTrackName());
			rowData.add(balanceBill.getScheduleBillNo());
			
			if(balanceBill.getCarCount() != null){
				rowData.add(String.valueOf(balanceBill.getCarCount()));
			}else{
				rowData.add("");
			}
			
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
