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
import com.jshpsoft.dao.TrackTyreInOutDetailMapper;
import com.jshpsoft.dao.TrackTyreInOutMapper;
import com.jshpsoft.dao.TrackTyreStockMapper;
import com.jshpsoft.domain.TrackTyreInOut;
import com.jshpsoft.domain.TrackTyreInOutDetail;
import com.jshpsoft.domain.TrackTyreStock;
import com.jshpsoft.service.TrackTyreInOutMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("trackTyreInOutMngService")
public class TrackTyreInOutMngServiceImpl implements TrackTyreInOutMngService {
	
	@Autowired
	private TrackTyreStockMapper trackTyreStockMapper;
	
	@Autowired
	private TrackTyreInOutMapper trackTyreInOutMapper;
	
	@Autowired
	private TrackTyreInOutDetailMapper trackTyreInOutDetailMapper;
	
	@Autowired
	private CommonService commonService;

	@Override
	@SystemServiceLog(description="获取轮胎出入库单信息")
	public List<TrackTyreInOut> getByConditions(Map<String, Object> params)
			throws Exception {
		return trackTyreInOutMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="获取轮胎出入库单信息")
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
	@SystemServiceLog(description="新增轮胎出库单信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TrackTyreInOut bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("轮胎出库信息为空");
		}
		
		String billNo = this.createBillNo();
		
		//插入数据到轮胎出入库表
		bean.setBuyBillNo(bean.getIds());//轮胎库存id
		bean.setBillNo(billNo);
		bean.setType(Constants.TrackTyreInOutType.OUT);//出库
		bean.setStatus(Constants.TrackTyreInOutStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		trackTyreInOutMapper.insert(bean);
		
		//保存明细
		if(null != bean.getIds() && !"".equals(bean.getIds()))
		{
			String[] ids = bean.getIds().split(",");//轮胎库存id
			if(ids.length > 0)
			{
				for(int i = 0;i<ids.length;i++)
				{
					TrackTyreStock trackTyreStock = trackTyreStockMapper.getById(Integer.valueOf(ids[i]));
					if(null != trackTyreStock)
					{
						TrackTyreInOutDetail d = new TrackTyreInOutDetail();
						d.setParentId(bean.getId());
						d.setTyreNo(trackTyreStock.getTyreNo());
						d.setType(trackTyreStock.getType());
						d.setBrand(trackTyreStock.getBrand());
						d.setSize(trackTyreStock.getSize());
						d.setPrice(trackTyreStock.getPrice());
						d.setInsertTime(new Date());
						d.setInsertUser(oper);
						d.setDelFlag(Constants.DelFlag.N);
						trackTyreInOutDetailMapper.insert(d);
					}
				}
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="根据id获取轮胎出库单信息")
	public TrackTyreInOut getById(Integer id) throws Exception {
		TrackTyreInOut inOut = trackTyreInOutMapper.getById(id);
		if(null == inOut)
		{
			throw new RuntimeException("查询的实体为空");
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
	@SystemServiceLog(description="更新轮胎出库单信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TrackTyreInOut bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("轮胎出库单信息为空");
		}
		
		//更新轮胎出入库表
		bean.setBuyBillNo(bean.getIds());//轮胎库存id
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		trackTyreInOutMapper.update(bean);
		
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		params.put("parentId", bean.getId());
		trackTyreInOutDetailMapper.updateByParentId(params);//先删除
		//保存明细
				if(null != bean.getIds() && !"".equals(bean.getIds()))
				{
					String[] ids = bean.getIds().split(",");//轮胎库存id
					if(ids.length > 0)
					{
						for(int i = 0;i<ids.length;i++)
						{
							TrackTyreStock trackTyreStock = trackTyreStockMapper.getById(Integer.valueOf(ids[i]));
							if(null != trackTyreStock)
							{
								if(null != trackTyreStock)
								{
									TrackTyreInOutDetail d = new TrackTyreInOutDetail();
									d.setParentId(bean.getId());
									d.setTyreNo(trackTyreStock.getTyreNo());
									d.setType(trackTyreStock.getType());
									d.setBrand(trackTyreStock.getBrand());
									d.setSize(trackTyreStock.getSize());
									d.setPrice(trackTyreStock.getPrice());
									d.setInsertTime(new Date());
									d.setInsertUser(oper);
									d.setDelFlag(Constants.DelFlag.N);
									trackTyreInOutDetailMapper.insert(d);
								}
							}
						}
					}
				}
	}

	@Override
	@SystemServiceLog(description="删除轮胎出入库单信息")
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
	@SystemServiceLog(description="提交轮胎出库单")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status", Constants.TrackTyreInOutStatus.UNREVIEW);//1待复核
		//更新出入库表状态：1待复核
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
	@SystemServiceLog(description="轮胎出库单审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Integer id, String status, String oper) throws Exception {
		
		//更新出库单状态
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status", status);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		trackTyreInOutMapper.updateById(params);
		
		//更新轮胎库存表
		TrackTyreInOut bean = trackTyreInOutMapper.getById(id);
		if(null != bean)
		{
			if(null != bean.getBuyBillNo() && !"".equals(bean.getBuyBillNo()))
			{
				String[] s = bean.getBuyBillNo().split(",");
				if(s.length > 0)
				{
					for(int i = 0;i<s.length;i++)
					{
						Map<String,Object> tts = new HashMap<String, Object>();
						tts.put("id", Integer.valueOf(s[i]));
						tts.put("status",Constants.TrackTyreStatus.CANCEL);//已出库
						tts.put("updateTime",new Date());
						tts.put("updateUser",oper);
						trackTyreStockMapper.updateById(tts);
					}
				}
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="轮胎出库单审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Integer id, String status, String oper) throws Exception {
		
		auditForConfirm(id, status, oper);
	}
	
	@Override
	@SystemServiceLog(description="轮胎出库单审核更新")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditForConfirm(Integer id, String status, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status", status);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		trackTyreInOutMapper.updateById(params);
	}

	@SystemServiceLog(description="创建轮胎出库单据号")
	public String createBillNo() throws Exception {
		String billNoSuffix = "";
		String currYearMonthDay = "CK" + CommonUtil.getCurrYearMonthDay();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("currYearMonthDay", currYearMonthDay);
		params.put("orderBybillNo", "Y");
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
