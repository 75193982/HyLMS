package com.jshpsoft.serviceImpl;

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
import com.jshpsoft.dao.TrackTyreBuyApplyMapper;
import com.jshpsoft.dao.TrackTyreInOutDetailMapper;
import com.jshpsoft.dao.TrackTyreInOutMapper;
import com.jshpsoft.dao.TrackTyreStockMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.TrackTyreBuyApply;
import com.jshpsoft.domain.TrackTyreInOut;
import com.jshpsoft.domain.TrackTyreInOutDetail;
import com.jshpsoft.domain.TrackTyreStock;
import com.jshpsoft.service.TrackTyreRuService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月12日 上午9:10:09
 */
@Service("TrackTyreRuService")
public class TrackTyreRuServiceImpl implements TrackTyreRuService{
	
	@Autowired
	private TrackTyreStockMapper trackTyreStockMapper;
	
	@Autowired
	private TrackTyreInOutMapper trackTyreInOutMapper;
	
	@Autowired
	private TrackTyreInOutDetailMapper trackTyreInOutDetailMapper;
	
	@Autowired
	private TrackTyreBuyApplyMapper trackTyreBuyApplyMapper;
	
	@Autowired
	private CashInOutMapper cashInOutMapper;
	
	@Autowired
	private CommonService commonService;

	@Override
	@SystemServiceLog(description="获取轮胎入库单信息")
	public List<TrackTyreInOut> getByConditions(Map<String, Object> params)
			throws Exception {
		return trackTyreInOutMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="获取轮胎入库信息")
	public Pager<TrackTyreInOut> getPageData(Map<String, Object> params)
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
		List<TrackTyreInOut> list = trackTyreInOutMapper.getPageList(params);
		int totalCount = trackTyreInOutMapper.getPageTotalCount(params);
		
		Pager<TrackTyreInOut> pager = new Pager<TrackTyreInOut>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增轮胎入库登记")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TrackTyreInOut bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("轮胎入库登记为空");
		}
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("delFlag", Constants.DelFlag.N);
		params.put("buyBillNo", bean.getBuyBillNo());
		List<TrackTyreInOut> list = trackTyreInOutMapper.getByConditions(params);
		if(null != list && list.size() > 0)
		{
			throw new RuntimeException("采购单号不能重复保存！");
		}
		
		String billNo = this.createBillNo();
		//插入数据到轮胎出入库表
		bean.setBillNo(billNo);
		bean.setType(Constants.TrackTyreInOutType.IN);//入库
		bean.setStatus(Constants.TrackTyreInOutStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		trackTyreInOutMapper.insert(bean);
		
		//插入明细
		List<TrackTyreInOutDetail> dlist = bean.getDetailList();
		if(null != dlist && dlist.size() > 0)
		{
			for(int i = 0;i<dlist.size();i++)
			{
				TrackTyreInOutDetail td = dlist.get(i);
				td.setParentId(bean.getId());
				td.setInsertTime(new Date());
				td.setInsertUser(oper);
				td.setDelFlag(Constants.DelFlag.N);
				trackTyreInOutDetailMapper.insert(td);
			}
		}
	}

	@Override
	@SystemServiceLog(description="根据id获取轮胎入库登记")
	public TrackTyreInOut getById(Integer id) throws Exception {
		TrackTyreInOut inOut = trackTyreInOutMapper.getById(id);
		if(null == inOut)
		{
			throw new RuntimeException("实体为空");
		}
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("billNo", inOut.getBuyBillNo());
		List<TrackTyreBuyApply> appList = trackTyreBuyApplyMapper.getByConditions(params);
		if(null != appList && appList.size() > 0)
		{
			TrackTyreBuyApply tba = appList.get(0);
			inOut.setTypeEdit(tba.getType());
			inOut.setBrandEdit(tba.getBrand());
			inOut.setSizeEdit(tba.getSize());
			inOut.setSumEdit(tba.getSum());
			inOut.setPriceEdit(tba.getPrice());
		}
		//明细
		Map<String,Object> par = new HashMap<String, Object>();
		par.put("delFlag", Constants.DelFlag.N);
		par.put("parentId", id);
		List<TrackTyreInOutDetail> dlist = trackTyreInOutDetailMapper.getByConditions(par);
		inOut.setDetailList(dlist);
		return inOut;
	}

	@Override
	@SystemServiceLog(description="根据id获取轮胎出入库单及明细信息")
	public TrackTyreInOut getDetailById(Integer id) throws Exception {
		TrackTyreInOut inOut = trackTyreInOutMapper.getById(id);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentId", id);
		params.put("delFlag", Constants.DelFlag.N);
		List<TrackTyreInOutDetail> detail = trackTyreInOutDetailMapper.getByConditions(params);
		inOut.setDetailList(detail);
		
		return inOut;
	}
	
	@Override
	@SystemServiceLog(description="更新轮胎入库登记")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TrackTyreInOut bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("轮胎入库登记为空");
		}
		
		TrackTyreInOut c= trackTyreInOutMapper.getById(bean.getId());
		if(!bean.getBuyBillNo().equals(c.getBuyBillNo()))
		{
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			params.put("buyBillNo", bean.getBuyBillNo());
			List<TrackTyreInOut> list = trackTyreInOutMapper.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				throw new RuntimeException("采购单号不能重复保存！");
			}
		}
		
		//更新轮胎出入库表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		trackTyreInOutMapper.update(bean);
		
		//先删除明细
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		params.put("parentId", bean.getId());
		trackTyreInOutDetailMapper.updateByParentId(params);
		
		//插入明细
		List<TrackTyreInOutDetail> dlist = bean.getDetailList();
		if(null != dlist && dlist.size() > 0)
		{
			for(int i = 0;i<dlist.size();i++)
			{
				TrackTyreInOutDetail td = dlist.get(i);
				td.setParentId(bean.getId());
				td.setInsertTime(new Date());
				td.setInsertUser(oper);
				td.setDelFlag(Constants.DelFlag.N);
				trackTyreInOutDetailMapper.insert(td);
			}
		}
	}

	@Override
	@SystemServiceLog(description="删除轮胎入库信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		trackTyreInOutMapper.updateById(params);
		
		//删除明细
		Map<String, Object> par = new HashMap<String, Object>();
		par.put("updateTime", new Date());
		par.put("updateUser", oper);
		par.put("delFlag", Constants.DelFlag.Y);
		par.put("parentId", id);
		trackTyreInOutDetailMapper.updateByParentId(par);
	}

	@Override
	@SystemServiceLog(description="提交轮胎入库登记")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status", Constants.TrackTyreInOutStatus.UNREVIEW);//1待复核
		//更新入库表状态：1待复核
		trackTyreInOutMapper.updateById(params);
		
		
		TrackTyreInOut bean = trackTyreInOutMapper.getById(id);
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.LTCRKSQD, 
				id, 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName( Constants.ProcessType.LTCRKSQD, bean.getBillNo() )
				);
		
	}

	@Override
	@SystemServiceLog(description="轮胎入库登记审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Integer id, String status, String oper) throws Exception {
		TrackTyreInOut bean = trackTyreInOutMapper.getById(id);
		if(null == bean)
		{
			throw new RuntimeException("没有查找到实体");
		}
		//更新入库登记状态
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status", status);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		trackTyreInOutMapper.updateById(params);
		
		int departmentId = 0;
		//更新轮胎采购状态
		Map<String, Object> par = new HashMap<String, Object>();
		par.put("billNo", bean.getBuyBillNo());
		List<TrackTyreBuyApply> list = trackTyreBuyApplyMapper.getByConditions(par);
		if(null != list && list.size() > 0)
		{
			TrackTyreBuyApply tba = list.get(0);
			tba.setUpdateTime(new Date());
			tba.setUpdateUser(oper);
			tba.setStatus(Constants.TrackTyreBuyApplyStatus.DENGJI);
			trackTyreBuyApplyMapper.update(tba);
			departmentId = tba.getDepartmentId();
		}
		
		//插入现金收支表
		par.clear();
		par.put("delFlag", Constants.DelFlag.N);
		par.put("parentId", id);
		List<TrackTyreInOutDetail> tdList = trackTyreInOutDetailMapper.getByConditions(par);
		double money = 0;
		if(null != tdList && tdList.size() > 0)
		{
			for(int i =0;i<tdList.size();i++)
			{
				money += tdList.get(i).getPrice();
			}
		}
		CashInOut cash = new CashInOut();
		cash.setDepartmentId(departmentId);
		cash.setBusinessType(Constants.CashInOutBusinessType.TrackTyreIn);
		cash.setType( Constants.CashInOutType.OUT );
		cash.setMoney( CommonUtil.formatDouble(money) );
		cash.setDetailId(bean.getId());
		cash.setMark("轮胎入库登记【入库单号-"+bean.getBillNo()+"】");
		cash.setDelFlag(Constants.DelFlag.N);
		cash.setInsertTime(new Date());
		cash.setInsertUser(oper);
		cash.setUpdateTime(new Date());
		cash.setUpdateUser(oper);
		cash.setStatus(Constants.CashInOutStatus.SUBMIT);
		cash.setSystemFlag(Constants.SystemFlag.Y);
		cashInOutMapper.insert(cash);
		
		//插入轮胎库存表
		TrackTyreStock st = new TrackTyreStock();
		if(null != tdList && tdList.size() > 0)
		{
			for(int i =0;i<tdList.size();i++)
			{
				TrackTyreInOutDetail d = tdList.get(i);
				if(null != d)
				{
					st.setBillNo(bean.getBillNo());//入库单号
					st.setTyreNo(d.getTyreNo());
					st.setType(d.getType());
					st.setBrand(d.getBrand());
					st.setSize(d.getSize());
					st.setPrice(d.getPrice());
					st.setStatus(Constants.TrackTyreStatus.HASIN);//已入库
					st.setInsertTime(new Date());
					st.setInsertUser(oper);
					st.setDelFlag(Constants.DelFlag.N);
					trackTyreStockMapper.insert(st);
				}
			}
		}
		
		
		
		
	}

	@Override
	@SystemServiceLog(description="轮胎入库登记审核更新")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditForConfirm(Integer id, String status, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status", status);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		trackTyreInOutMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="轮胎入库登记审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Integer id, String status, String oper) throws Exception {
		
		auditForConfirm(id, status, oper);
	}
	
	
	@SystemServiceLog(description="创建轮胎入库单据号")
	public String createBillNo() throws Exception {
		String billNoSuffix = "";
		String currYearMonthDay = "DJ" + CommonUtil.getCurrYearMonthDay();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("currYearMonthDay", currYearMonthDay);
		//params.put("orderBybillNo", "Y");
		List<TrackTyreInOut> list = trackTyreInOutMapper.getByConditions(params);
		if( null != list && list.size() > 0 ){
			String oldBillNo = list.get(0).getBillNo();
			billNoSuffix = getNextNo( String.valueOf(oldBillNo).substring(10) );
		}else{
			billNoSuffix = "00001";
		}
		
		return currYearMonthDay + billNoSuffix;
	}
	
	public String getNextNo(String no){
		
		String result = String.format("%0" + no.length() + "d", Integer.parseInt(no) + 1);
        return result;
	}


}
