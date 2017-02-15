package com.jshpsoft.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.DepartmentMapper;
import com.jshpsoft.dao.DutyMapper;
import com.jshpsoft.dao.SalaryPayAllowanceDetailMapper;
import com.jshpsoft.dao.SalaryPayDetailMapper;
import com.jshpsoft.dao.SalaryPayMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.Department;
import com.jshpsoft.domain.Duty;
import com.jshpsoft.domain.SalaryPay;
import com.jshpsoft.domain.SalaryPayDetail;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.SalaryPayService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service
public class SalaryPayServiceImpl implements SalaryPayService {

	@Autowired
	private SalaryPayMapper salaryPayMapper;
	
	@Autowired
	private SalaryPayDetailMapper salaryPayDetailMapper;
	
	@Autowired
	private SalaryPayAllowanceDetailMapper salaryPayAllowanceDetailMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	private DutyMapper dutyMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Override
	@SystemServiceLog(description="查询工资发放列表信息")
	public Pager<SalaryPay> getPageData(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		
		List<SalaryPay> list = salaryPayMapper.getPageList(params);
		if( null != list && list.size()> 0 ){
			for(int i=0; i<list.size(); i++){
				SalaryPay bean = list.get(i);
				//提交人
				String insertUserId = bean.getInsertUser();
				if( StringUtils.isNotEmpty(insertUserId) ){
					User user = userMapper.getById( Integer.parseInt(insertUserId));
					if( null != user ){
						list.get(i).setInsertUserName( user.getName() );
					}
					
				}
				String updateUserId = bean.getUpdateUser();
				if( StringUtils.isNotEmpty(updateUserId) ){
					User user = userMapper.getById( Integer.parseInt(updateUserId));
					if( null != user ){
						list.get(i).setUpdateUserName( user.getName() );
					}
					
				}
				
			}
		}
		int totalCount = salaryPayMapper.getPageTotalCount(params);
		
		Pager<SalaryPay> pager = new Pager<SalaryPay>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="条件查询工资")
	public List<SalaryPay> getByConditions(Map<String, Object> params) throws Exception {
		
		return salaryPayMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="查询所有工资")
	public List<SalaryPay> getAllListData(Map<String, Object> params) throws Exception {
		List<SalaryPay> list = salaryPayMapper.getByConditions(params);
		
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				//详细信息
				params = new HashMap<String, Object>();
				params.put( "delFlag", Constants.DelFlag.N );
				params.put( "parentId", list.get(i).getId() );
				List<SalaryPayDetail> detailList = salaryPayDetailMapper.getByConditions(params);
				list.get(i).setDetailList(detailList);
				
			}
		}
		
		return list;
	}
	
	@Override
	@SystemServiceLog(description="查询工资详细信息")
	public SalaryPay getById(Integer id) throws Exception {
		return salaryPayMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="保存工资发放信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(SalaryPay bean, String operId) throws Exception {
		//生成详细信息
		if( null == bean ){
			throw new RuntimeException("信息不能为空！");
		}
		//生成详细信息
		List<SalaryPayDetail> detailList = bean.getDetailList();
		if( null == detailList || detailList.size() == 0 ){
			throw new RuntimeException("详细信息不能为空！");
		}
		
		Integer id = bean.getId();
		if( null == id || 0 == id ){
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			bean.setStatus(Constants.SalaryPayStatus.NEW);
			salaryPayMapper.insert(bean);
			id = bean.getId();
			
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			salaryPayMapper.update(bean);
			
			//删除原先的详细记录
			salaryPayDetailMapper.deleteByParentId(id);
			
		}
		
		int userCount = 0;
		double totalAmount = 0;
		//生成详细信息
		if( null != detailList && detailList.size() > 0 ){
			for(int i=0; i<detailList.size(); i++){
				SalaryPayDetail detail = detailList.get(i);
				double basicSalary = detail.getBasicSalary();
				double allowanceAmount = detail.getAllowanceAmount();
				double fineAmount = detail.getFineAmount();
				double amount = basicSalary + allowanceAmount - fineAmount;
				detail.setAmount(CommonUtil.formatDouble(amount));
				detail.setStatus(Constants.SalaryPayStatus.NEW);
				detail.setParentId(id);
				detail.setSalaryTime(bean.getSalaryTime());
				detail.setDelFlag(Constants.DelFlag.N);
				detail.setInsertTime(new Date());
				detail.setInsertUser(operId);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(operId);
				
				if( null !=  detail.getDepartmentId() ){
					Department department = departmentMapper.getById(detail.getDepartmentId());
					if( null != department ){
						detail.setDepartmentName(department.getName());
					}
					//
					User user = userMapper.getById(detail.getUserId());
					if( null != user ){
						Duty duty = dutyMapper.getById(user.getDutyId());
						if( null != duty ){
							detail.setDutyName(duty.getName());
						}
					}
				}
				
				salaryPayDetailMapper.insert(detail);
				totalAmount += amount;
				userCount++;
			}
		}
		
		bean.setUserCount(userCount);
		bean.setAmount(totalAmount);
		salaryPayMapper.update(bean);
		
	}



	@Override
	@SystemServiceLog(description="发放工资")
	public void pay(Integer id, String operId) throws Exception {
		
		SalaryPay pay = salaryPayMapper.getById(id);
		if( null == pay ){
			throw new RuntimeException("数据查询不到！");
		}
		pay.setStatus(Constants.SalaryPayStatus.PAY);
		pay.setUpdateTime(new Date());
		pay.setUpdateUser(operId);
		salaryPayMapper.update(pay);
		
		//更新明细
		Map<String, Object> params = new HashMap<String, Object>();
		List<SalaryPayDetail> detailList = salaryPayDetailMapper.getByConditions(params);
		if( null != detailList && detailList.size() > 0 ){
			for(int i=0; i<detailList.size(); i++){
				SalaryPayDetail detail = detailList.get(i);
				detail.setStatus(Constants.SalaryPayStatus.PAY);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(operId);
				salaryPayDetailMapper.update(detail);
			}
		}
		
	}
	
	
	@Override
	@SystemServiceLog(description="获取工资发放的详细信息")
	public SalaryPay getByDetailInfo(Integer id) throws Exception {
		SalaryPay bean = salaryPayMapper.getById(id);
		//详细信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put( "delFlag", Constants.DelFlag.N );
		params.put( "parentId", bean.getId() );
		List<SalaryPayDetail> detailList = salaryPayDetailMapper.getByConditions(params);
		bean.setDetailList(detailList);
		
		return bean;
	}
	
	@Override
	@SystemServiceLog(description="删除工资信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void delete(Integer id, String operId) throws Exception {
		SalaryPay bean = salaryPayMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到！");
		}
		if( !Constants.SalaryPayStatus.NEW.equals(bean.getStatus()) ){
			throw new RuntimeException("已发放的数据不可删除！");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		salaryPayMapper.update(bean);
		
		//删除工资发放信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put( "delFlag", Constants.DelFlag.N );
		params.put( "parentId", bean.getId() );
		List<SalaryPayDetail> detailList = salaryPayDetailMapper.getByConditions(params);
		if( null != detailList && detailList.size() > 0 ){
			for(int i=0; i<detailList.size(); i++){
				SalaryPayDetail detail = detailList.get(i);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(operId);
				detail.setDelFlag(Constants.DelFlag.Y);
				salaryPayDetailMapper.update(detail);
				
//				//删除工资发放对应的补助信息
//				params = new HashMap<String, Object>();
//				params.put( "delFlag", Constants.DelFlag.N );
//				params.put( "payDetailId", detail.getId() );
//				List<SalaryPayAllowanceDetail> allowanceList = salaryPayAllowanceDetailMapper.getByConditions(params);
//				if( null != allowanceList && allowanceList.size() > 0 ){
//					for(int j=0; j<allowanceList.size(); j++){
//						SalaryPayAllowanceDetail allowanceDetail = allowanceList.get(j);
//						allowanceDetail.setUpdateTime(new Date());
//						allowanceDetail.setUpdateUser(operId);
//						allowanceDetail.setDelFlag(Constants.DelFlag.Y);
//						salaryPayAllowanceDetailMapper.update(allowanceDetail);
//						
//					}
//				}
				
			}
		}
		
		
	}

	@Override
	public List<SalaryPayDetail> getTemplateData(String driverFlag, String salaryTime)
			throws Exception {
		//salaryTime：yyyy-MM转为yyyyMM
		if( StringUtils.isNotEmpty(salaryTime) ){
			salaryTime = salaryTime.substring(0, 4)+salaryTime.substring(5);
		}
		
		Map<String, Object> params = new HashMap<String, Object>();
		int outSourcingIdForOwnCompany = commonService.getOutSourcingIdForOwnCompany();//获取公司的驾驶员
		if( 0 == outSourcingIdForOwnCompany ){
			throw new RuntimeException("配置表中未添加公司车队名称配置或公司车队名称不匹配！");
		}
		
		params.put( "delFlag", Constants.DelFlag.N );
		if( "Y".equals(driverFlag) ){//只取公司的驾驶员
			params.put( "driverFlag", "Y" );//驾驶员
			params.put( "outSourcingId", outSourcingIdForOwnCompany);//公司的驾驶员
		}else{//所有员工
			params.put( "outSourcingIdForOwnCompany", outSourcingIdForOwnCompany);//公司的驾驶员+公司其他员工
		}
		List<User> userList = userMapper.getByConditions(params);
		List<SalaryPayDetail> list = new ArrayList<SalaryPayDetail>();
		if( null != userList && userList.size() > 0 ){
			for(int i=0; i<userList.size(); i++){
				User user = userList.get(i);
				if( null != user ){
					SalaryPayDetail bean = new SalaryPayDetail();
					Duty duty = dutyMapper.getById(user.getDutyId());
					if( null != duty ){
						bean.setDutyName(duty.getName());
						//基本工资
						bean.setBasicSalary(duty.getSalary());
					}else{
						bean.setBasicSalary(0);
					}
					
					//20170204 公里数由用户自己填写
					//里程补助：驾驶员
//					if( "Y".equals(driverFlag) ){
//						bean.setAllowanceAmount( commonService.getDriverSalaryDistanceAllowance( user.getId(), salaryTime ) );
//					}else{
//						bean.setAllowanceAmount(0);
//					}
					bean.setAllowanceAmount(0);
					bean.setAllowanceDistance(0);
					if( null !=  user.getDepartmentId() ){
						bean.setDepartmentId(user.getDepartmentId());
						Department department = departmentMapper.getById(user.getDepartmentId());
						if( null != department ){
							bean.setDepartmentName(department.getName());
						}
					}
					bean.setUserId(user.getId());
					bean.setUserName(user.getName());
					list.add(bean);
					
				}
			}
		}
		return list;
	}

	@Override
	public List<SalaryPayDetail> getDetailInfoForConditions(
			Map<String, Object> params) throws Exception {
		
		return salaryPayDetailMapper.getByConditions(params);
	}

	@Override
	public Map<String, Object> getAllListDataForExportData( Map<String, Object> params) throws Exception {
		Map<String, Object> formatData = new HashMap<String, Object>();
		
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet1");
		formatData.put("sheetList", sheetList);
		
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "工资发放汇总");
		sheetData.put("titleMergeSize", 7);
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("工资归属时间");
		tableHeadList.add("人数");
		tableHeadList.add("发放总金额");
		tableHeadList.add("状态");
		tableHeadList.add("操作时间");
		tableHeadList.add("操作人");
		sheetData.put("tableHeader", tableHeadList);
		
		List<List<String>> tableData = new ArrayList<List<String>>();
		List<SalaryPay> list = this.getAllListData(params);
		if(null != list && list.size() > 0){
			double totalAmount = 0;
			for(int i = 0; i < list.size(); i++){
				List<String> rowData = new ArrayList<String>();
				rowData.add(String.valueOf(i+1));
				rowData.add(list.get(i).getSalaryTime());
				rowData.add(list.get(i).getUserCount()+"");
				rowData.add(list.get(i).getAmount()+"");
				totalAmount += list.get(i).getAmount();
				String status = list.get(i).getStatus();
				if( Constants.SalaryPayStatus.NEW.equals(status) ){
					rowData.add("新建");
				}else{
					rowData.add("已发放");
				}
				Date updateTime = list.get(i).getUpdateTime();
				if( null != updateTime ){
					rowData.add(CommonUtil.format(updateTime, Constants.DATE_TIME_FORMAT_SHORT));
				}else{
					rowData.add("");
				}
				String updateUser = list.get(i).getUpdateUser();
				if( StringUtils.isNotEmpty(updateUser) ){
					User user = userMapper.getById( Integer.parseInt(updateUser) );
					if( null != user ){
						rowData.add(user.getName());
					}else{
						rowData.add("");
					}
				}
				tableData.add(rowData);
			}
			//合计
			List<String> rowData = new ArrayList<String>();
			rowData.add("");
			rowData.add("");
			rowData.add("合计");
			rowData.add(""+totalAmount);
			rowData.add("");
			rowData.add("");
			rowData.add("");
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		return formatData;
	}

	@Override
	public Map<String, Object> getByDetailInfoForExportData(Integer id)
			throws Exception {
		Map<String, Object> formatData = new HashMap<String, Object>();
		
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet1");
		formatData.put("sheetList", sheetList);
		
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "工资发放明细");
		sheetData.put("titleMergeSize", 10);
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("用户名");
		tableHeadList.add("部门");
		tableHeadList.add("岗位");
		tableHeadList.add("工资归属时间");
		tableHeadList.add("基本工资");
		tableHeadList.add("里程数(公里)");
		tableHeadList.add("补助合计");
		tableHeadList.add("罚扣合计");
		tableHeadList.add("应发合计");
		sheetData.put("tableHeader", tableHeadList);
		
		List<List<String>> tableData = new ArrayList<List<String>>();
		//详细信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put( "delFlag", Constants.DelFlag.N );
		params.put( "parentId", id );
		List<SalaryPayDetail> list = salaryPayDetailMapper.getByConditions(params);
		if(null != list && list.size() > 0){
			double totalAmount = 0;
			for(int i = 0; i < list.size(); i++){
				List<String> rowData = new ArrayList<String>();
				rowData.add(String.valueOf(i+1));
				rowData.add(list.get(i).getUserName());
				rowData.add(list.get(i).getDepartmentName());
				rowData.add(list.get(i).getDutyName());
				rowData.add(list.get(i).getSalaryTime());
				rowData.add(list.get(i).getBasicSalary()+"");
				rowData.add(list.get(i).getAllowanceDistance()+"");
				rowData.add(list.get(i).getAllowanceAmount()+"");
				rowData.add(list.get(i).getFineAmount()+"");
				rowData.add(list.get(i).getAmount()+"");
				totalAmount += list.get(i).getAmount();
//				String status = list.get(i).getStatus();
//				if( Constants.SalaryPayStatus.NEW.equals(status) ){
//					rowData.add("新建");
//				}else{
//					rowData.add("已发放");
//				}
//				Date updateTime = list.get(i).getUpdateTime();
//				if( null == updateTime ){
//					rowData.add(CommonUtil.format(updateTime, Constants.DATE_TIME_FORMAT_SHORT));
//				}else{
//					rowData.add("");
//				}
//				String updateUser = list.get(i).getUpdateUser();
//				if( StringUtils.isNotEmpty(updateUser) ){
//					User user = userMapper.getById( Integer.parseInt(updateUser) );
//					if( null != user ){
//						rowData.add(user.getName());
//					}else{
//						rowData.add("");
//					}
//				}
				tableData.add(rowData);
			}
			//合计
			List<String> rowData = new ArrayList<String>();
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("");
			rowData.add("合计");
			rowData.add(""+totalAmount);
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		return formatData;
	}
	
}
