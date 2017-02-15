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
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.InvoiceMapper;
import com.jshpsoft.domain.Invoice;
import com.jshpsoft.service.InvoiceService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 发票管理service
 * @author  ww 
 * @date 2016年12月20日 上午11:04:35
 */
@Service("invoiceService")
public class InvoiceServiceImpl implements InvoiceService {
	
	@Autowired
	private InvoiceMapper invoiceMapper;

	@Override
	@SystemServiceLog(description="保存、更新发票管理")
	public void save(Invoice bean, String oper) throws Exception {
		Integer id = bean.getId();
		if(null == id)
		{
			bean.setInsertUser(oper);
			bean.setInsertTime(new Date());
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setStatus(Constants.CarInOutStatus.NEW);
			invoiceMapper.insert(bean);
		}
		else
		{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			invoiceMapper.update(bean);
		}
	}

	@Override
	@SystemServiceLog(description="删除发票管理")
	public void delete(int id, String oper) throws Exception {
		Invoice invoice = invoiceMapper.getById(id);
		if(null == invoice)
		{
			throw new RuntimeException("查询实体为空");
		}
		invoice.setUpdateTime(new Date());
		invoice.setUpdateUser(oper);
		invoice.setDelFlag(Constants.DelFlag.Y);
		invoiceMapper.update(invoice);
	}

	@Override
	public Pager<Invoice> getPageData(Map<String, Object> params)
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
		
		List<Invoice> list = invoiceMapper.getPageList(params);
		int totalCount = invoiceMapper.getPageTotalCount(params);
		
		Pager<Invoice> pager = new Pager<Invoice>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	public Invoice getById(Integer id) throws Exception {
		return invoiceMapper.getById(id);
	}

	@Override
	public List<Invoice> getByConditions(Map<String, Object> params)
			throws Exception {
		return invoiceMapper.getByConditions(params);
	}

	@Override
	public void submit(Integer id, String operId) throws Exception {
		Invoice bean = invoiceMapper.getById(id);
		if(null == bean)
		{
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(Constants.CarInOutStatus.UNREVIEW);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		invoiceMapper.update(bean);
		
	}

	@Override
	@Transactional
	public void auditSuccess(Integer detailId, int status, int operId)
			throws Exception {
		Invoice bean = invoiceMapper.getById(detailId);
		if(null == bean)
		{
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(String.valueOf(status));
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId+"");
		invoiceMapper.update(bean);
		
		
	}

	@Override
	@Transactional
	public void auditForConfirm(Integer detailId, int status, int operId)
			throws Exception {
		Invoice bean = invoiceMapper.getById(detailId);
		if(null == bean)
		{
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(String.valueOf(status));
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId+"");
		invoiceMapper.update(bean);
		
	}

	@Override
	@Transactional
	public void auditFail(Integer detailId, int status, int operId)
			throws Exception {
		auditForConfirm(detailId, status, operId);
		
	}

	@Override
	@SystemServiceLog(description="导出发票信息")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到发票数据
		List<Invoice> detailList = invoiceMapper.getByConditions(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "发票信息数据");//
		sheetData.put("titleMergeSize", 8);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("发票号");
		tableHeadList.add("开票时间");
		tableHeadList.add("收款方");
		tableHeadList.add("开票金额");
		tableHeadList.add("税金");
		tableHeadList.add("价税合计");
		tableHeadList.add("备注");
		
		sheetData.put("tableHeader", tableHeadList);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<detailList.size();i++){
			//获取每一行数据
			Invoice invoice = detailList.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(invoice.getInvoiceNo());
			if(null != invoice.getOperateTime())
			{
				rowData.add(sdf.format(invoice.getOperateTime()));
			}
			else
			{
				rowData.add("");
			}
			rowData.add(invoice.getTitle());
			rowData.add(invoice.getAmount()+"");
			rowData.add(invoice.getDuty()+"");
			BigDecimal b1 = new BigDecimal(new Double(invoice.getAmount()).toString());  
			BigDecimal b2 = new BigDecimal(new Double(invoice.getDuty()).toString());  
			rowData.add(b1.add(b2).doubleValue()+"");
			rowData.add(invoice.getMark());
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

}
