package com.jshpsoft.serviceImpl;

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
import com.jshpsoft.dao.ContactFundsMapper;
import com.jshpsoft.domain.ContactFunds;
import com.jshpsoft.service.ContactFundsService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("contactFundsService")
public class ContactFundsServiceImpl implements ContactFundsService {
	
	@Autowired
	private ContactFundsMapper contactFundsMapper;
	
	@Override
	@SystemServiceLog(description="查询往来款列表信息")
	public Pager<ContactFunds> getPageData(Map<String, Object> params) throws Exception {
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
		List<ContactFunds> list = contactFundsMapper.getPageList(params);
		int totalCount = contactFundsMapper.getPageTotalCount(params);
		
		Pager<ContactFunds> pager = new Pager<ContactFunds>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="获取往来款信息")
	public List<ContactFunds> getPrintData(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return contactFundsMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="导出供应商往来款信息")
	public Map<String, Object> getRecExportData(Map<String, Object> params)
			throws Exception {
		//得到往来款信息数据
		params.put("delFlag", Constants.DelFlag.N);
		List<ContactFunds> list = contactFundsMapper.getByConditions(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "应收往来款信息");
		sheetData.put("titleMergeSize", 9);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("供应商");
		tableHeadList.add("账款日期");
		tableHeadList.add("款项类型");
		tableHeadList.add("现金金额");
		tableHeadList.add("油卡金额");
		tableHeadList.add("总金额");
		tableHeadList.add("状态");
		tableHeadList.add("备注");
		sheetData.put("tableHeader", tableHeadList);
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			ContactFunds fund = list.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(fund.getBusinessName());
			rowData.add(fund.getFundDate());
			
			if(fund.getFundType().equals(Constants.FundType.ALL)){
				rowData.add("应收款");
			}else if(fund.getFundType().equals(Constants.FundType.GIVE)){
				rowData.add("实收款");
			}
			
			rowData.add(String.valueOf(fund.getCashAmount()));
			rowData.add(String.valueOf(fund.getOilAmount()));
			rowData.add(String.valueOf(fund.getAmount()));
			
			if(fund.getStatus().equals(Constants.ContactFundsStatus.NEW)){
				rowData.add("草稿");
			}else if(fund.getStatus().equals(Constants.ContactFundsStatus.SUBMIT)){
				rowData.add("提交");
			}
			
			rowData.add(fund.getMark());
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

	@Override
	@SystemServiceLog(description="导出承运商往来款信息")
	public Map<String, Object> getPayExportData(Map<String, Object> params)
			throws Exception {
		//得到往来款信息数据
		params.put("delFlag", Constants.DelFlag.N);
		List<ContactFunds> list = contactFundsMapper.getByConditions(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "应付往来款信息");
		sheetData.put("titleMergeSize", 9);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("承运商");
		tableHeadList.add("账款日期");
		tableHeadList.add("款项类型");
		tableHeadList.add("现金金额");
		tableHeadList.add("油卡金额");
		tableHeadList.add("总金额");
		tableHeadList.add("状态");
		tableHeadList.add("备注");
		sheetData.put("tableHeader", tableHeadList);
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			ContactFunds fund = list.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(fund.getBusinessName());
			rowData.add(fund.getFundDate());
			
			if(fund.getFundType().equals(Constants.FundType.ALL)){
				rowData.add("应付款");
			}else if(fund.getFundType().equals(Constants.FundType.GIVE)){
				rowData.add("实付款");
			}
			
			rowData.add(String.valueOf(fund.getCashAmount()));
			rowData.add(String.valueOf(fund.getOilAmount()));
			rowData.add(String.valueOf(fund.getAmount()));
			
			if(fund.getStatus().equals(Constants.ContactFundsStatus.NEW)){
				rowData.add("草稿");
			}else if(fund.getStatus().equals(Constants.ContactFundsStatus.SUBMIT)){
				rowData.add("提交");
			}
			
			rowData.add(fund.getMark());
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}
	
	@Override
	@SystemServiceLog(description="保存往来款信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(ContactFunds bean, String oper) throws Exception {
		
		if( null == bean ){
			throw new RuntimeException("往来款信息为空");
		}
		
		int id = bean.getId();
		
		if(id != 0){//更新
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			contactFundsMapper.update(bean);
		}else{//新增
			bean.setStatus(Constants.ContactFundsStatus.NEW);//0草稿
			bean.setInsertTime(new Date());
			bean.setInsertUser(oper);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			bean.setDelFlag(Constants.DelFlag.N);
			contactFundsMapper.insert(bean);
		}
		
	}

	@Override
	@SystemServiceLog(description="根据id获取往来款信息")
	public ContactFunds getById(Integer id) throws Exception {
		return contactFundsMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除往来款信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		contactFundsMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="提交往来款信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status",Constants.ContactFundsStatus.SUBMIT);//1提交
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		contactFundsMapper.updateById(params);	
	}

	@Override
	@SystemServiceLog(description="获取往来款报表")
	public List<ContactFunds> getReportData(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return contactFundsMapper.getReportData(params);
	}

	@Override
	@SystemServiceLog(description="导出应收往来款报表")
	public Map<String, Object> getRecExportReport(Map<String, Object> params)
			throws Exception {
		//得到往来款报表数据
		params.put("delFlag", Constants.DelFlag.N);
		List<ContactFunds> list = contactFundsMapper.getReportData(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", String.valueOf(params.get("fundDate"))+"月应收往来款报表");
		sheetData.put("titleMergeSize", 6);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("供应商");
		tableHeadList.add("应收运费");
		tableHeadList.add("实收运费");
		tableHeadList.add("应收余额");
		tableHeadList.add("备注");
		sheetData.put("tableHeader", tableHeadList);
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			ContactFunds fund = list.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(fund.getBusinessName());
			rowData.add(String.valueOf(fund.getAllAmount()));
			rowData.add(String.valueOf(fund.getGiveAmount()));
			rowData.add(String.valueOf(fund.getAllAmount().doubleValue()-fund.getGiveAmount().doubleValue()));
			rowData.add("");
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

	@Override
	@SystemServiceLog(description="导出应付往来款报表")
	public Map<String, Object> getPayExportReport(Map<String, Object> params)
			throws Exception {
		//得到往来款报表数据
		params.put("delFlag", Constants.DelFlag.N);
		List<ContactFunds> list = contactFundsMapper.getReportData(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", String.valueOf(params.get("fundDate"))+"月应付往来款报表");
		sheetData.put("titleMergeSize", 6);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("承运商");
		tableHeadList.add("应付运费");
		tableHeadList.add("实付运费");
		tableHeadList.add("应付余额");
		tableHeadList.add("备注");
		sheetData.put("tableHeader", tableHeadList);
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			ContactFunds fund = list.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(fund.getBusinessName());
			rowData.add(String.valueOf(fund.getAllAmount()));
			rowData.add(String.valueOf(fund.getGiveAmount()));
			rowData.add(String.valueOf(fund.getAllAmount().doubleValue()-fund.getGiveAmount().doubleValue()));
			rowData.add("");
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}
}
