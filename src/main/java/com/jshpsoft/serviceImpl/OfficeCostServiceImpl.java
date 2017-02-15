package com.jshpsoft.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CostApplyMapper;
import com.jshpsoft.domain.CostApply;
import com.jshpsoft.service.OfficeCostService;
import com.jshpsoft.util.CommonUtil;

@Service("officeCostService")
public class OfficeCostServiceImpl implements OfficeCostService {
	
	@Autowired
	private CostApplyMapper costApplyMapper;
	
	@Override
	@SystemServiceLog(description="获取办公费用报表")
	public List<CostApply> getReportData(Map<String, Object> params)
			throws Exception {
		
		//获取查询月的费用
		params.put("monthFlag", "Y");
		List<CostApply> list = costApplyMapper.getReportData(params);
		
		//获取累计费用
		params.put("sumFlag", "Y");
		List<CostApply> listSum = costApplyMapper.getReportData(params);
		
		//将累计费用添加到列表中
		for(int i=0; i<list.size(); i++){
			list.get(i).setSumAmount(listSum.get(i).getAmount());
		}
		
		return list;
	}

	@Override
	@SystemServiceLog(description="导出办公费用报表")
	public Map<String, Object> getExportReport(Map<String, Object> params)
			throws Exception {
		List<CostApply> list = this.getReportData(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", String.valueOf(params.get("applyDate"))+"月办公费用报表");
		sheetData.put("titleMergeSize", 5);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("归属项目");
		tableHeadList.add("归属部门");
		tableHeadList.add("本月金额");
		tableHeadList.add("累计金额");
		sheetData.put("tableHeader", tableHeadList);
		
		double amount = 0;
		double sumAmount = 0;
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			CostApply apply = list.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(apply.getTypeName());
			rowData.add(apply.getDepartmentName());
			rowData.add(String.valueOf(apply.getAmount()));
			rowData.add(String.valueOf(apply.getSumAmount()));
			
			tableData.add(rowData);
			
			amount += apply.getAmount();
			sumAmount += apply.getSumAmount();
		}
		
		//合计
		List<String> rowData = new ArrayList<String>();
		rowData.add("");
		rowData.add("合计");
		rowData.add("");
		rowData.add(String.valueOf( CommonUtil.formatDouble(amount) ));
		rowData.add(String.valueOf( CommonUtil.formatDouble(sumAmount) ));
		
		tableData.add(rowData);
				
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

}
