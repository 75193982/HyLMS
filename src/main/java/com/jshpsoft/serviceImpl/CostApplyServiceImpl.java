package com.jshpsoft.serviceImpl;

import java.text.SimpleDateFormat;
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
import com.jshpsoft.dao.DepartmentMapper;
import com.jshpsoft.dao.ProcessDetailMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.CostApply;
import com.jshpsoft.domain.Department;
import com.jshpsoft.service.CostApplyService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月7日 上午10:56:37
 */
@Service("costApplyService")
public class CostApplyServiceImpl implements CostApplyService {
	
	@Resource
	private CostApplyMapper costApplyMapper;

	@Resource
	private CommonService commonService;
	
	@Resource
	private UserMapper userMapper;
	
	@Resource
	private CashInOutMapper cashInOutMapper;
	
	@Resource
	private DepartmentMapper departmentMapper;
	
	@Resource
	private ProcessDetailMapper processDetailMapper;
	
	@Override
	public Pager<CostApply> getPageData(Map<String, Object> params)
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
		
		List<CostApply> list = costApplyMapper.getPageList(params);
		int totalCount = costApplyMapper.getPageTotalCount(params);
		
		Pager<CostApply> pager = new Pager<CostApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	
	}

	@Override
	@SystemServiceLog(description="保存、更新费用申请")
	public void save(CostApply bean, String operId) throws Exception {
		Integer id = bean.getId();
		if( null == id ){
			String costApplyNo = CommonUtil.getCostApplyNo_YF();//  YF+yyyyMMdd
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String a = sdf.format(new Date());
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("insertTime", a);
			List<CostApply> list = costApplyMapper.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				String no = list.get(0).getBillNo();//取第一条即是单号最大
				costApplyNo += getNextNo(no.substring(10));
			}
			else
			{
				costApplyNo +="00001";
			}
			
			bean.setBillNo(costApplyNo);
			bean.setApplyTime(new Date());
			bean.setStatus(Constants.CostApplyForOfficeStatus.NEW);
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			costApplyMapper.insert(bean);
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			costApplyMapper.update(bean);
		}
		
	}

	public String getNextNo(String no){
		String result = String.format("%0" + no.length() + "d", Integer.parseInt(no) + 1);
        return result;
	}

	@Override
	public CostApply getById(Integer id) throws Exception {
		return costApplyMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除费用申请")
	public void delete(Integer id, String operId) throws Exception {
		CostApply bean = costApplyMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		costApplyMapper.update(bean);
		
	}
	
	@Override
	@Transactional
	public void submit(Integer id, String operId) throws Exception {
		CostApply bean = costApplyMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(Constants.CostApplyForOfficeStatus.SUBMIT);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		costApplyMapper.update(bean);
		
		//添加到流程中
		commonService.addToProcessForCostApply( 
				Constants.ProcessType.FYSQD, 
				id, 
				Integer.parseInt(operId), 
				CommonUtil.getProcessName(Constants.ProcessType.FYSQD, bean.getName())
				);
		
	}

	@Override
	@Transactional
	public void auditSuccess(Integer detailId, int status, int operId)
			throws Exception {
		//更新主表
		CostApply bean = costApplyMapper.getById(detailId);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(String.valueOf(status));
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(String.valueOf(operId));
		costApplyMapper.update(bean);
		
		//插入现金收支-支出
		double money = bean.getAmount();
		CashInOut cash = new CashInOut();
		cash.setDepartmentId(bean.getDepartmentId());
		cash.setBusinessType(Constants.CashInOutBusinessType.CostApply);
		cash.setType(Constants.CashInOutType.OUT);
		cash.setDetailId(detailId);
		cash.setMark("预付费用申请【单号-"+bean.getBillNo()+"】");
		cash.setMoney( money );
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
	@Transactional
	public void auditForConfirm(Integer detailId, int status, int operId)
			throws Exception {
		//更新主表
		CostApply bean = costApplyMapper.getById(detailId);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(String.valueOf(status));
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(String.valueOf(operId));
		costApplyMapper.update(bean);
		
	}

	@Override
	@Transactional
	public void auditFail(Integer detailId, int status, int operId)
			throws Exception {
		
		//审核不通过后状态为部门审核是，需要确认提交人是否是部门负责人。状态设置为0
		if( Constants.CostApplyForOfficeStatus.SUBMIT.equals(status+"") ){
			//检查当前提交人是否是申请部门的负责人，如果不是，则提交给部门负责人（第二个节点），如果是，则提交给财务审核（第三个节点）
			CostApply detail = costApplyMapper.getById(detailId);
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
			
		auditForConfirm(detailId, status, operId);
		
	}

	@Override
	public List<CostApply> getByConditions(Map<String, Object> params)
			throws Exception {
		return costApplyMapper.getByConditions(params);
	}


}
