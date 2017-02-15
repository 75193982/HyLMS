package com.jshpsoft.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.OtherContactsLogMapper;
import com.jshpsoft.dao.OtherContactsMapper;
import com.jshpsoft.domain.OtherContacts;
import com.jshpsoft.domain.OtherContactsLog;
import com.jshpsoft.service.OtherContactsService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("otherContactsService")
public class OtherContactsServiceImpl implements OtherContactsService {
	
	@Autowired
	private OtherContactsMapper otherContactsMapper;
	
	@Autowired
	private OtherContactsLogMapper otherContactsLogMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Override
	@SystemServiceLog(description="查询其他往来款列表信息")
	public Pager<OtherContacts> getPageData(Map<String, Object> params) throws Exception {
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
		List<OtherContacts> list = otherContactsMapper.getPageList(params);
		int totalCount = otherContactsMapper.getPageTotalCount(params);
		
		Pager<OtherContacts> pager = new Pager<OtherContacts>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="获取其他往来款信息")
	public List<OtherContacts> getPrintData(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return otherContactsMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="导出其他应收款信息")
	public Map<String, Object> getRecExportData(Map<String, Object> params)
			throws Exception {
		//得到往来款信息数据
		params.put("delFlag", Constants.DelFlag.N);
		List<OtherContacts> list = otherContactsMapper.getByConditions(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "其他应收款信息");
		sheetData.put("titleMergeSize", 14);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("经办人");
		tableHeadList.add("摘要");
		tableHeadList.add("借出时间");
		tableHeadList.add("借款期限");
		tableHeadList.add("提醒时间");
		tableHeadList.add("借出金额");
		tableHeadList.add("借款利息");
		tableHeadList.add("本息合计");
		tableHeadList.add("借款核减金额");
		tableHeadList.add("核减时间");
		tableHeadList.add("实际应收");
		tableHeadList.add("状态");
		tableHeadList.add("备注");
		sheetData.put("tableHeader", tableHeadList);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			OtherContacts con = list.get(i);

			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(con.getOperateUser());
			rowData.add(con.getName());
			rowData.add(sdf.format(con.getOperateTime()));
			
			if(con.getStartTime() != null && con.getEndTime() != null){
				rowData.add(sdf.format(con.getStartTime())+"到"+sdf.format(con.getEndTime()));
			}else{
				rowData.add("");
			}
			
			if(con.getNoticeTime() != null){
				rowData.add( sdf.format(con.getNoticeTime()) );
			}else{
				rowData.add("");
			}

			rowData.add(String.valueOf(con.getAmount()));
			rowData.add(String.valueOf(con.getRatio()));
			rowData.add(String.valueOf(con.getTotalAmount()));
			rowData.add(String.valueOf(con.getDecreaseAmount()));
			
			if(con.getDecreaseTime() != null){
				rowData.add( sdf.format(con.getDecreaseTime()) );
			}else{
				rowData.add("");
			}
			rowData.add(String.valueOf(con.getActualAmount()));
			
			if(con.getStatus().equals(Constants.OtherContactsStatus.NEW)){
				rowData.add("新建");
			}else if(con.getStatus().equals(Constants.OtherContactsStatus.SUBMIT)){
				rowData.add("已提交");
			}else if(con.getStatus().equals(Constants.OtherContactsStatus.FINISH)){
				rowData.add("已完成");
			}
			
			rowData.add(con.getMark());
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

	@Override
	@SystemServiceLog(description="导出其他应付款信息")
	public Map<String, Object> getPayExportData(Map<String, Object> params)
			throws Exception {
		//得到往来款信息数据
		params.put("delFlag", Constants.DelFlag.N);
		List<OtherContacts> list = otherContactsMapper.getByConditions(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "其他应付款信息");
		sheetData.put("titleMergeSize", 14);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("经办人");
		tableHeadList.add("摘要");
		tableHeadList.add("借入时间");
		tableHeadList.add("借款期限");
		tableHeadList.add("提醒时间");
		tableHeadList.add("借入金额");
		tableHeadList.add("借款利息");
		tableHeadList.add("本息合计");
		tableHeadList.add("借款核减金额");
		tableHeadList.add("核减时间");
		tableHeadList.add("实际应付");
		tableHeadList.add("状态");
		tableHeadList.add("备注");
		sheetData.put("tableHeader", tableHeadList);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			OtherContacts con = list.get(i);

			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(con.getOperateUser());
			rowData.add(con.getName());
			rowData.add(sdf.format(con.getOperateTime()));
			if(con.getStartTime() != null && con.getEndTime() != null){
				rowData.add(sdf.format(con.getStartTime())+"到"+sdf.format(con.getEndTime()));
			}else{
				rowData.add("");
			}
			
			if(con.getNoticeTime() != null){
				rowData.add( sdf.format(con.getNoticeTime()) );
			}else{
				rowData.add("");
			}

			rowData.add(String.valueOf(con.getAmount()));
			rowData.add(String.valueOf(con.getRatio()));
			rowData.add(String.valueOf(con.getTotalAmount()));
			rowData.add(String.valueOf(con.getDecreaseAmount()));
			
			if(con.getDecreaseTime() != null){
				rowData.add( sdf.format(con.getDecreaseTime()) );
			}else{
				rowData.add("");
			}
			rowData.add(String.valueOf(con.getActualAmount()));
			
			if(con.getStatus().equals(Constants.OtherContactsStatus.NEW)){
				rowData.add("新建");
			}else if(con.getStatus().equals(Constants.OtherContactsStatus.SUBMIT)){
				rowData.add("已提交");
			}else if(con.getStatus().equals(Constants.OtherContactsStatus.FINISH)){
				rowData.add("已完成");
			}
			
			rowData.add(con.getMark());
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}
	
	@Override
	@SystemServiceLog(description="保存其他往来款信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(OtherContacts bean, String oper, HttpServletRequest req) throws Exception {
		
		if( null == bean ){
			throw new RuntimeException("其他往来款信息为空");
		}
		
		Date date = new Date();
		int id = bean.getId();
		
		if(id != 0){//更新
			
			//附件处理
			OtherContacts old = otherContactsMapper.getById(bean.getId());
			String attachFilePath = bean.getAttachFilePath();
			if( StringUtils.isNotEmpty(attachFilePath) && !attachFilePath.equals( old.getAttachFilePath() )){
				String newFilePath = commonService.reStoreFileForBatch( Constants.UploadType.OTHERCONTACTS, attachFilePath , req);
				bean.setAttachFilePath( newFilePath );
			}
			
			bean.setUpdateTime(date);
			bean.setUpdateUser(oper);
			otherContactsMapper.updateByConditions(bean);
			
			//删除log记录再插入
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("otherContactId", id);
			params.put("updateTime", new Date());
			params.put("updateUser", oper);
			params.put("delFlag", Constants.DelFlag.Y);
			otherContactsLogMapper.updateByConId(params);
			
			if(bean.getDecreaseAmount() != 0 ){
				OtherContactsLog log = new OtherContactsLog();
				log.setOtherContactId(id);
				log.setAmount(bean.getDecreaseAmount());
				log.setOperateTime(bean.getDecreaseTime());
				log.setMark("首次核销");
				log.setInsertTime(date);
				log.setInsertUser(oper);
				log.setUpdateTime(date);
				log.setUpdateUser(oper);
				log.setDelFlag(Constants.DelFlag.N);
				otherContactsLogMapper.insert(log);
			}
			
		}else{//新增
			bean.setStatus(Constants.OtherContactsStatus.NEW);
			bean.setInsertTime(date);
			bean.setInsertUser(oper);
			bean.setUpdateTime(date);
			bean.setUpdateUser(oper);
			bean.setDelFlag(Constants.DelFlag.N);
			//附件处理
			String attachFilePath = bean.getAttachFilePath();
			if( StringUtils.isNotEmpty(attachFilePath) ){
				String newFilePath = commonService.reStoreFileForBatch( Constants.UploadType.OTHERCONTACTS, attachFilePath , req);
				bean.setAttachFilePath( newFilePath );
			}
			otherContactsMapper.insert(bean);
			
			//插入log记录
			if(bean.getDecreaseAmount() != 0 ){
				OtherContactsLog log = new OtherContactsLog();
				log.setOtherContactId(bean.getId());
				log.setAmount(bean.getDecreaseAmount());
				log.setOperateTime(bean.getDecreaseTime());
				log.setMark("首次核销");
				log.setInsertTime(date);
				log.setInsertUser(oper);
				log.setUpdateTime(date);
				log.setUpdateUser(oper);
				log.setDelFlag(Constants.DelFlag.N);
				otherContactsLogMapper.insert(log);
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="根据id获取其他往来款信息")
	public OtherContacts getById(Integer id) throws Exception {
		return otherContactsMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除其他往来款信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		otherContactsMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="提交其他往来款信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status",Constants.OtherContactsStatus.SUBMIT);//1提交
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		
		//判断是否全部核销
		OtherContacts bean = otherContactsMapper.getById(id);
		if(bean.getActualAmount() <= 0){
			params.put("status",Constants.OtherContactsStatus.FINISH);//2完成
		}
		
		otherContactsMapper.updateById(params);	
	}

	@Override
	@SystemServiceLog(description="保存核销记录")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void saveLog(OtherContactsLog bean, String oper) throws Exception {
		
		double sumAmount = bean.getAmount();
		
		//判断是否全部核销
		List<OtherContactsLog> list = otherContactsLogMapper.getLogList(bean.getOtherContactId());
		if(null != list && list.size() >0 ){			
			for(int i=0;i<list.size();i++){
				sumAmount += list.get(i).getAmount();
			}			
		}
		
		OtherContacts con = otherContactsMapper.getById(bean.getOtherContactId());
		if((con.getTotalAmount()-sumAmount) <= 0){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", bean.getOtherContactId());
			params.put("status",Constants.OtherContactsStatus.FINISH);//2完成
			params.put("updateTime", new Date());
			params.put("updateUser", oper);
			otherContactsMapper.updateById(params);	
		}
		
		Date date = new Date();
		bean.setInsertTime(date);
		bean.setInsertUser(oper);
		bean.setUpdateTime(date);
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		otherContactsLogMapper.insert(bean);

	}

	@Override
	@SystemServiceLog(description="获取核销记录")
	public List<OtherContactsLog> getLogById(Integer id) throws Exception {
		return otherContactsLogMapper.getLogList(id);
	}
	
	@Override
	@SystemServiceLog(description="获取其他往来款报表")
	public List<OtherContacts> getReportData(Map<String, Object> params)
			throws Exception {
		
		params.put("delFlag", Constants.DelFlag.N);
		List<OtherContacts> list = otherContactsMapper.getByConditions(params);
		if(null != list && list.size() > 0){
			for(int i=0;i<list.size();i++){
				OtherContacts con = list.get(i);
				double sumAmount = 0;
				List<OtherContactsLog> logList = otherContactsLogMapper.getLogList(con.getId());
				if(null != logList && logList.size() >0 ){
					
					for(int j=0;j<logList.size();j++){
						sumAmount += logList.get(j).getAmount();
					}
				}
				
				con.setDecreaseAmount(sumAmount);
				con.setActualAmount(con.getTotalAmount()-sumAmount);
			}
		}
		return list;
	}

	@Override
	@SystemServiceLog(description="导出其他应收款报表")
	public Map<String, Object> getRecExportReport(Map<String, Object> params)
			throws Exception {
		//得到往来款报表数据
		List<OtherContacts> list = this.getReportData(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "其他应收款报表");
		sheetData.put("titleMergeSize", 6);//导出数据的列数
		
		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("经办人");
		tableHeadList.add("摘要");
		tableHeadList.add("借出总金额");
		tableHeadList.add("核销总金额");
		tableHeadList.add("余额");
		sheetData.put("tableHeader", tableHeadList);
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			OtherContacts con = list.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(con.getOperateUser());
			rowData.add(con.getName());
			rowData.add(String.valueOf(con.getTotalAmount()));
			rowData.add(String.valueOf(con.getDecreaseAmount()));
			rowData.add(String.valueOf(con.getActualAmount()));
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

	@Override
	@SystemServiceLog(description="导出其他应付款报表")
	public Map<String, Object> getPayExportReport(Map<String, Object> params)
			throws Exception {
		//得到往来款报表数据
		List<OtherContacts> list = this.getReportData(params);

		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "其他应付款报表");
		sheetData.put("titleMergeSize", 6);//导出数据的列数
		
		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("经办人");
		tableHeadList.add("摘要");
		tableHeadList.add("借入总金额");
		tableHeadList.add("核销总金额");
		tableHeadList.add("余额");
		sheetData.put("tableHeader", tableHeadList);
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<list.size();i++){
			//获取每一行数据
			OtherContacts con = list.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			rowData.add(con.getOperateUser());
			rowData.add(con.getName());
			rowData.add(String.valueOf(con.getTotalAmount()));
			rowData.add(String.valueOf(con.getDecreaseAmount()));
			rowData.add(String.valueOf(con.getActualAmount()));
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

}
