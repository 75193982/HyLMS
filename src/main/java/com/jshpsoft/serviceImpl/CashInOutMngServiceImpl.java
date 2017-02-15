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
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.CashInOutMngService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("cashInOutMngService")
public class CashInOutMngServiceImpl implements CashInOutMngService {
	
	@Autowired
	private CashInOutMapper cashInOutMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Override
	@SystemServiceLog(description="获取收支信息")
	public Pager<CashInOut> getPageData(Map<String, Object> params)
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
		List<CashInOut> list = cashInOutMapper.getPageList(params);
		int totalCount = cashInOutMapper.getPageTotalCount(params);
		
		Pager<CashInOut> pager = new Pager<CashInOut>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增收支信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(CashInOut bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("收支信息为空");
		}
		
		User user = userMapper.getById(Integer.parseInt(oper));
		int departmentId = 0;
		if( null != user && null != user.getDepartmentId() ){
			departmentId = user.getDepartmentId();
		}
		bean.setDepartmentId(departmentId);
		//插入数据到收支表
		bean.setStatus(Constants.CashInOutStatus.NEW);//0新建
		bean.setSystemFlag(Constants.SystemFlag.N);
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		cashInOutMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取收支信息")
	public CashInOut getById(Integer id) throws Exception {
		return cashInOutMapper.getById(id);
	}
	
	@Override
	@SystemServiceLog(description="更新收支信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(CashInOut bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("收支信息为空");
		}
		
		//更新表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		cashInOutMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除收支信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		cashInOutMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="提交收支信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status", Constants.CashInOutStatus.SUBMIT);//已提交
		//更新
		cashInOutMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="导出收支信息")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到收支数据
		params.put("delFlag", Constants.DelFlag.N);
		List<CashInOut> detailList = cashInOutMapper.getByConditions(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "收支信息");//
		sheetData.put("titleMergeSize", 8);//导出数据的列数
		 /*type-类型、mark-事由、money-金额、status-状态、insertUser-插入人、insertTime-插入时间*/
		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("类型");
		tableHeadList.add("部门");
		tableHeadList.add("事由");
		tableHeadList.add("金额");
		tableHeadList.add("状态");
		tableHeadList.add("插入人");
		tableHeadList.add("插入时间");
		sheetData.put("tableHeader", tableHeadList);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<detailList.size();i++){
			//获取每一行数据
			CashInOut inOut = detailList.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			
			if(inOut.getType().equals(Constants.CashInOutType.IN)){
				rowData.add("收入");
			}else if(inOut.getType().equals(Constants.CashInOutType.OUT)){
				rowData.add("支出");
			}
			rowData.add(inOut.getDepartmentName());
			rowData.add(inOut.getMark());	
			
			rowData.add(String.valueOf(inOut.getMoney()));
			
			if(inOut.getStatus().equals(Constants.CashInOutStatus.NEW)){
				rowData.add("新建");
			}else if(inOut.getStatus().equals(Constants.CashInOutStatus.SUBMIT)){
				rowData.add("已提交");
			}
			
			rowData.add(inOut.getInsertUser());
			if(inOut.getInsertTime() != null){
				rowData.add( sdf.format(inOut.getInsertTime()) );
			}else{
				rowData.add("");
			}
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

	@Override
	@SystemServiceLog(description="获取打印收支信息")
	public List<CashInOut> getPrint(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return cashInOutMapper.getByConditions(params);
	}

	
}
