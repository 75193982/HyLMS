package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.CashWaitingPayLogMapper;
import com.jshpsoft.dao.DepartmentMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.CashWaitingPayLog;
import com.jshpsoft.domain.Department;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.CashWaitingPayLogService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("cashWaitingPayLogService")
public class CashWaitingPayLogServiceImpl implements CashWaitingPayLogService {
	
	@Autowired
	private CashWaitingPayLogMapper cashWaitingPayLogMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private CashInOutMapper cashInOutMapper;
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Override
	@SystemServiceLog(description="获取待付信息")
	public Pager<CashWaitingPayLog> getPageData(Map<String, Object> params)
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
		List<CashWaitingPayLog> list = cashWaitingPayLogMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				int receiveUser = list.get(i).getReceiveUser();
				User user = userMapper.getById(receiveUser);
				if( null != user ){
					list.get(i).setReceiveUserName(user.getName());
				}
				String insertUser = list.get(i).getInsertUser();
				if( null != insertUser ){
					user = userMapper.getById( Integer.parseInt(insertUser) );
					if( null != user ){
						list.get(i).setInsertUserName( user.getName() );
					}
				}
				String updateUser = list.get(i).getUpdateUser();
				if( null != updateUser ){
					user = userMapper.getById( Integer.parseInt(updateUser) );
					if( null != user ){
						list.get(i).setUpdateUserName( user.getName() );
					}
				}
				int deptId = list.get(i).getDepartmentId();
				Department dept = departmentMapper.getById(deptId);
				if( null != dept ){
					list.get(i).setDepartmentName(dept.getName());
				}
			}
		}
		int totalCount = cashWaitingPayLogMapper.getPageTotalCount(params);
		
		Pager<CashWaitingPayLog> pager = new Pager<CashWaitingPayLog>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增待付信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(CashWaitingPayLog bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("待付信息为空");
		}
		
		User user = userMapper.getById(Integer.parseInt(oper));
		int departmentId = 0;
		if( null != user && null != user.getDepartmentId() ){
			departmentId = user.getDepartmentId();
		}
		bean.setDepartmentId(departmentId);
		//插入数据到待付表
		bean.setStatus(Constants.CashWaitingPayLogStatus.NEW);//未支付
		bean.setSystemFlag(Constants.SystemFlag.Y);
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		cashWaitingPayLogMapper.insert(bean);
		
	}

	@Override
	@SystemServiceLog(description="根据id获取待付信息")
	public CashWaitingPayLog getById(Integer id) throws Exception {
		return cashWaitingPayLogMapper.getById(id);
	}
	
	@Override
	@SystemServiceLog(description="更新待付信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void pay(int id, String oper) throws Exception {
		CashWaitingPayLog bean = cashWaitingPayLogMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("待付信息为空！");
		}
		//更新表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setStatus(Constants.CashWaitingPayLogStatus.PAY);//已支付
		cashWaitingPayLogMapper.update(bean);
		
		//插入现金收支表-支出
		User user = userMapper.getById(bean.getReceiveUser());
		CashInOut cash = new CashInOut();
		cash.setDepartmentId(user.getDepartmentId());
		cash.setBusinessType(Constants.CashInOutBusinessType.TransportCostDiscount);
		cash.setType(Constants.CashInOutType.OUT);
		cash.setDetailId(bean.getId());
		cash.setMark("驾驶员报销的现金待付");
		cash.setMoney( bean.getMoney() );
		cash.setDelFlag(Constants.DelFlag.N);
		cash.setInsertTime(new Date());
		cash.setInsertUser(oper);
		cash.setUpdateTime(new Date());
		cash.setUpdateUser(oper);
		cash.setStatus(Constants.CashInOutStatus.SUBMIT);
		cash.setSystemFlag(Constants.SystemFlag.Y);
		cashInOutMapper.insert(cash);
		
	}

}
