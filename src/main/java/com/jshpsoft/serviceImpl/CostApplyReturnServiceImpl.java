package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.CostApplyMapper;
import com.jshpsoft.dao.CostApplyReturnMapper;
import com.jshpsoft.dao.DepartmentMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.CostApply;
import com.jshpsoft.domain.CostApplyReturn;
import com.jshpsoft.domain.Department;
import com.jshpsoft.service.CostApplyReturnService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月8日 下午1:07:03
 */
@Service("costApplyReturnService")
public class CostApplyReturnServiceImpl implements CostApplyReturnService{
	
	@Resource
	private CostApplyReturnMapper costApplyReturnMapper;
	
	@Resource
	private CostApplyMapper costApplyMapper;
	
	@Resource
	private CashInOutMapper cashInOutMapper;
	
	@Resource
	private DepartmentMapper departmentMapper;
	
	@Resource
	private CommonService commonService;

	@Override
	public Pager<CostApplyReturn> getPageData(Map<String, Object> params)
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
		
		List<CostApplyReturn> list = costApplyReturnMapper.getPageList(params);
		int totalCount = costApplyReturnMapper.getPageTotalCount(params);
		
		Pager<CostApplyReturn> pager = new Pager<CostApplyReturn>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存、更新核销申请")
	public void save(CostApplyReturn bean, String operId) throws Exception {
		Integer id = bean.getId();
		if( null == id ){
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("costApplyBillNo", bean.getCostApplyBillNo());
			List<CostApplyReturn> list = costApplyReturnMapper.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				throw new RuntimeException("预付申请单号不能重复保存！");
			}
			bean.setStatus(Constants.CostApplyReturnForOfficeStatus.NEW);
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			costApplyReturnMapper.insert(bean);
		}else{
			CostApplyReturn c= costApplyReturnMapper.getById(bean.getId());
			if(!bean.getCostApplyBillNo().equals(c.getCostApplyBillNo()))
			{
				Map<String,Object> params = new HashMap<String, Object>();
				params.put("costApplyBillNo", bean.getCostApplyBillNo());
				List<CostApplyReturn> list = costApplyReturnMapper.getByConditions(params);
				if(null != list && list.size() > 0)
				{
					throw new RuntimeException("预付申请单号不能重复保存！");
				}
			}
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			costApplyReturnMapper.update(bean);
		}
		
	}

	@Override
	public CostApplyReturn getById(Integer id) throws Exception {
		return costApplyReturnMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除核销申请")
	public void delete(Integer id, String operId) throws Exception {
		CostApplyReturn bean = costApplyReturnMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		costApplyReturnMapper.update(bean);
		
	}

	@Override
	@Transactional
	@SystemServiceLog(description="提交核销申请")
	public void submit(Integer id, String operId) throws Exception {
		CostApplyReturn bean = costApplyReturnMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(Constants.CostApplyReturnForOfficeStatus.SUBMIT);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		costApplyReturnMapper.update(bean);
		
		//添加到流程中
		commonService.addToProcessForCostApplyRetrun( 
				Constants.ProcessType.HXFYSQD, 
				id, 
				Integer.parseInt(operId), 
				CommonUtil.getProcessName(Constants.ProcessType.HXFYSQD, "预付申请单号-"+bean.getCostApplyBillNo())
				);
				
	}

	@Override
	@Transactional
	public void auditSuccess(Integer detailId, int status, int operId)
			throws Exception 
	{
		CostApplyReturn bean = costApplyReturnMapper.getById(detailId);
		if(null == bean)
		{
			throw new RuntimeException("数据查询不到");
		}
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("billNo", bean.getCostApplyBillNo());
		List<CostApply> list = costApplyMapper.getByConditions(params);
		if(null != list && list.size() > 0)
		{
			CostApply c = list.get(0);
			if(null != c)
			{
				c.setStatus(Constants.CostApplyForOfficeStatus.HEXIAO);//已核销
				c.setUpdateTime(new Date());
				c.setUpdateUser(operId+"");
				costApplyMapper.update(c);
			}
		}
		
		//
		bean.setStatus(Constants.CostApplyReturnForOfficeStatus.FINISH);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId+"");
		costApplyReturnMapper.update(bean);
		
		//插入现金收支
		double money = bean.getReturnAmount();
		CashInOut cash = new CashInOut();
		cash.setDepartmentId(bean.getDepartmentId());
		cash.setBusinessType(Constants.CashInOutBusinessType.CostApplyReturn);
		if( money > 0 ){
			cash.setType( Constants.CashInOutType.IN );
			cash.setMoney( money );
		}else{
			cash.setType( Constants.CashInOutType.OUT );
			cash.setMoney( CommonUtil.formatDouble(0-money) );
		}
		cash.setDetailId(detailId);
		cash.setMark("核销费用申请【预付申请单号-"+bean.getCostApplyBillNo()+"】");
		cash.setDelFlag(Constants.DelFlag.N);
		cash.setInsertTime(new Date());
		cash.setInsertUser(operId+"");
		cash.setUpdateTime(new Date());
		cash.setUpdateUser(operId+"");
		cash.setStatus(Constants.CashInOutStatus.SUBMIT);
		cash.setSystemFlag(Constants.SystemFlag.Y);
		cashInOutMapper.insert(cash);
				
	}

	@Override
	public void auditForConfirm(Integer detailId, int status, int operId)
			throws Exception {
		
		CostApplyReturn bean = costApplyReturnMapper.getById(detailId);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(String.valueOf(status));
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(String.valueOf(operId));
		costApplyReturnMapper.update(bean);
		
	}

	@Override
	public void auditFail(Integer detailId, int status, int operId)
			throws Exception {
		//审核不通过后状态为部门审核是，需要确认提交人是否是部门负责人。状态设置为0
		if( Constants.CostApplyForOfficeStatus.SUBMIT.equals(status+"") ){
			//检查当前提交人是否是申请部门的负责人，如果不是，则提交给部门负责人（第二个节点），如果是，则提交给财务审核（第三个节点）
			CostApplyReturn detail = costApplyReturnMapper.getById(detailId);
			if( null == detail.getDepartmentId() || 0 == detail.getDepartmentId() ){
				throw new RuntimeException("申请部门信息不能为空！");
			}
			Department department = departmentMapper.getById(detail.getDepartmentId());
			if( null == department ){
				throw new RuntimeException("申请部门对应的部门记录不存在！");
			}
			Integer leaderId = department.getLeaderId();
			if( null == leaderId || 0 == leaderId ){
				throw new RuntimeException("申请部门的负责人信息未设置！");
			}
			if( detail.getInsertUser().equals(leaderId.toString()) ){
				status = 0;
			}
			
		}
					
		auditForConfirm( detailId, status, operId);
		
	}

}
