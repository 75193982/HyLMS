package com.jshpsoft.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarAttachmentStockInOutDetailMapper;
import com.jshpsoft.dao.CarAttachmentStockInOutMapper;
import com.jshpsoft.dao.CarAttachmentStockMapper;
import com.jshpsoft.dao.ScheduleBillDetailMapper;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarAttachmentStockInOut;
import com.jshpsoft.domain.CarAttachmentStockInOutAndUser;
import com.jshpsoft.domain.CarAttachmentStockInOutDetail;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleBillDetail;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarAttachmentStockService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年9月26日 下午1:26:26
 */
@Service("carAttachmentMngService")
public class CarAttachmentStockServiceImpl implements CarAttachmentStockService {

	@Resource
	private CarAttachmentStockMapper carAttachmentMngMapper;
	
	@Resource
	private CarAttachmentStockInOutMapper carAttachmentStockInOutMapper;
	
	@Resource
	private CarAttachmentStockInOutDetailMapper carAttachmentStockInOutDetailMapper;
	
	@Resource
	private WaybillMapper waybillMapper;
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private ScheduleBillDetailMapper scheduleBillDetailMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Override
	public List<CarAttachmentStock> getByConditions(Map<String, Object> params)
			throws Exception {
		return carAttachmentMngMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="插入配件库存")
	public void save(CarAttachmentStock bean,String stockId,String userName) throws Exception {
		if( null == bean ){
			throw new RuntimeException("实体为空");
		}
		bean.setStockId(Integer.valueOf(stockId));
		if(bean.getWaybillId()==null||bean.getWaybillId()==-1){
			bean.setType("");
		}else{
			Waybill waybill =  waybillMapper.getById(bean.getWaybillId());
			bean.setType(waybill.getType());	
		}		
		bean.setStatus(String.valueOf(Constants.CarAttchmentStockStatus.NEW));
		bean.setInsertTime(new Date());
		bean.setInsertUser(userName);
		bean.setDelFlag(Constants.DelFlag.N);
		carAttachmentMngMapper.save(bean);
	}

	@Override
	public List<CarAttachmentStock> queryCarAttachmentStock(
			Map<String, Object> params) throws Exception {
		
		return carAttachmentMngMapper.queryCarAttachmentStock(params);
	}

	@Override
	@SystemServiceLog(description="运单绑定配件")
	public int bindCarAttachment(Map<String, Object> params) throws Exception {
		
		return carAttachmentMngMapper.bindCarAttachment(params);
	}

	
	
	
	@Override
	@Transactional
	@SystemServiceLog(description="运单绑定配件")
	public int batchBindCarAttachment(Map<String, Object> params)
			throws Exception {
		//先取消所有
		carAttachmentMngMapper.batchCancelBindCarAttachment((int) params.get("waybillId"));
			Waybill waybill = waybillMapper.getById(Integer.valueOf(params.get("waybillId").toString()));
			if(null == waybill)
			{
				throw new RuntimeException("没有查询到该运单");
			}
			params.put("type", waybill.getType());
			return carAttachmentMngMapper.bindCarAttachment(params);
	}

	@Override
	@SystemServiceLog(description="查询配件")
	public CarAttachmentStock getById(int id) throws Exception {
		return carAttachmentMngMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="修改配件库存")
	public void update(CarAttachmentStock bean) throws Exception {
		Waybill waybill =  waybillMapper.getById(bean.getWaybillId());
		if( null != waybill ){
			bean.setType(waybill.getType());
			
		}
		carAttachmentMngMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除配件库存")
	public void delete(Map<String, Object> params) throws Exception {
		carAttachmentMngMapper.delete(params);
	}

	@Override
	@SystemServiceLog(description="查询配件库存")
	public Pager<CarAttachmentStock> getPageData(Map<String, Object> params)
			throws Exception {
		String pageSize;
		try {
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		} catch (Exception e) {
			throw new RuntimeException("参数缺失或不正确");
		}
		List<CarAttachmentStock> list = carAttachmentMngMapper.getPageList(params);
		/*if(null != list && list.size() > 0)
		{
			for(int i = 0;i<list.size();i++)
			{
				if(null != list.get(i).getWaybillId())
				{
					Map<String, Object> par = new HashMap<String, Object>();
					par.put("businessId", list.get(i).getWaybillId());
					List<CarAttachmentStockInOutDetail> listDetail = carAttachmentStockInOutDetailMapper.getByConditions(par);
					
				}
			}
		}*/
		int totalCount = carAttachmentMngMapper.getPageTotalCount(params);
		Pager<CarAttachmentStock> pager = new Pager<CarAttachmentStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

	@Override
	@SystemServiceLog(description="取消绑定的配件")
	public int cancelBindCarAttachment(int id) throws Exception {
		
		return carAttachmentMngMapper.cancelBindCarAttachment(id);
	}

	@Override
	@SystemServiceLog(description="配件出入库查询")
	public Pager<CarAttachmentStockInOutAndUser> getInOutPageData(
			Map<String, Object> params) throws Exception 
	{
		String pageSize;
		try {
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		} catch (Exception e) {
			throw new RuntimeException("参数缺失或不正确");
		}
		String type = "";
		String businessNo2 = "";//查询过来的条件
		List<CarAttachmentStockInOutAndUser> list = new ArrayList<CarAttachmentStockInOutAndUser>();
		int totalCount = 0;
		if(null != params.get("type") && !"".equals(params.get("type")))
		{
			type = params.get("type").toString();
			if(null != params.get("businessId") && !"".equals(params.get("businessId")))
			{
				businessNo2 = params.get("businessId").toString();
				if("0".equals(type))//入库
				{
					if(null != waybillMapper.queryWaybillByWaybillNo(businessNo2))
					{
						params.put("businessId", waybillMapper.queryWaybillByWaybillNo(businessNo2).getId());
						
						list = carAttachmentStockInOutMapper.getPageList(params);
						if(null != list && list.size() > 0)
						{
							for(int i = 0;i<list.size();i++)
							{
								//String type = list.get(i).getType();
								if("0".equals(type))//入库
								{
									int businessId = list.get(i).getBusinessId();
									if(null != waybillMapper.getById(businessId) && !"".equals(waybillMapper.getById(businessId)))
									{
										String businessNo = waybillMapper.getById(businessId).getWaybillNo();
										list.get(i).setBusinessNo(businessNo);
									}
								}
								if("1".equals(type))//出库
								{
									int businessId = list.get(i).getBusinessId();
									if(null != scheduleBillMapper.getById(businessId) && !"".equals(scheduleBillMapper.getById(businessId)))
									{
										String businessNo = scheduleBillMapper.getById(businessId).getScheduleBillNo();
										list.get(i).setBusinessNo(businessNo);
									}
								}
								
							}
						}
						totalCount = carAttachmentStockInOutMapper.getPageTotalCount(params);
						
					}
				}
				if("1".equals(type))//出库
				{
					
					if(null != scheduleBillMapper.getByBillNo(businessNo2))
					{
						params.put("businessId", scheduleBillMapper.getByBillNo(businessNo2).getId());
						
						 list = carAttachmentStockInOutMapper.getPageList(params);
						if(null != list && list.size() > 0)
						{
							for(int i = 0;i<list.size();i++)
							{
								//String type = list.get(i).getType();
								if("0".equals(type))//入库
								{
									int businessId = list.get(i).getBusinessId();
									if(null != waybillMapper.getById(businessId) && !"".equals(waybillMapper.getById(businessId)))
									{
										String businessNo = waybillMapper.getById(businessId).getWaybillNo();
										list.get(i).setBusinessNo(businessNo);
									}
								}
								if("1".equals(type))//出库
								{
									int businessId = list.get(i).getBusinessId();
									if(null != scheduleBillMapper.getById(businessId) && !"".equals(scheduleBillMapper.getById(businessId)))
									{
										String businessNo = scheduleBillMapper.getById(businessId).getScheduleBillNo();
										list.get(i).setBusinessNo(businessNo);
									}
								}
								
							}
						}
						totalCount = carAttachmentStockInOutMapper.getPageTotalCount(params);
					}
				}
			}
			else
			{
				list = carAttachmentStockInOutMapper.getPageList(params);
				if(null != list && list.size() > 0)
				{
					for(int i = 0;i<list.size();i++)
					{
						//String type = list.get(i).getType();
						if("0".equals(type))//入库
						{
							int businessId = list.get(i).getBusinessId();
							if(null != waybillMapper.getById(businessId) && !"".equals(waybillMapper.getById(businessId)))
							{
								String businessNo = waybillMapper.getById(businessId).getWaybillNo();
								list.get(i).setBusinessNo(businessNo);
							}
							
						}
						if("1".equals(type))//出库
						{
							int businessId = list.get(i).getBusinessId();
							if(null != scheduleBillMapper.getById(businessId) && !"".equals(scheduleBillMapper.getById(businessId)))
							{
								String businessNo = scheduleBillMapper.getById(businessId).getScheduleBillNo();
								list.get(i).setBusinessNo(businessNo);
							}
							
						}
						
					}
				}
				totalCount = carAttachmentStockInOutMapper.getPageTotalCount(params);
			}
		}
		
		Pager<CarAttachmentStockInOutAndUser> pager = new Pager<CarAttachmentStockInOutAndUser>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

	@Override
	@SystemServiceLog(description="配件出入库明细查看")
	public Pager<CarAttachmentStockInOutDetail> getDetailByParentId(Map<String, Object> params)
			throws Exception {
		
		String pageSize;
		try {
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		} catch (Exception e) {
			throw new RuntimeException("参数缺失或不正确");
		}
		List<CarAttachmentStockInOutDetail> list = carAttachmentStockInOutDetailMapper.getDetailByParentId(params);
		int totalCount = carAttachmentStockInOutDetailMapper.getPageTotalCount(params);
		Pager<CarAttachmentStockInOutDetail> pager = new Pager<CarAttachmentStockInOutDetail>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}
	
//	@Override
//	@SystemServiceLog(description="提交配件库存，插入配件入库数据")
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
//	public void submit(Map<String, Object> params) throws Exception {
//		params.put("status", Constants.CarAttchmentStockStatus.NEW);
//		List<CarAttachmentStock> list = carAttachmentMngMapper.getByConditions(params);
//		if(null != list && list .size() > 0)
//		{
//			int sumCount = 0;
//			for(int i = 0; i < list.size();i++)
//			{
//				sumCount += list.get(i).getCount();
//			}
//			Waybill waybill = waybillMapper.getById(Integer.parseInt(params.get("waybillId").toString()));
//			CarAttachmentStockInOut carAttachmentStockInOut = new CarAttachmentStockInOut();
//			carAttachmentStockInOut.setType(waybill.getType());//商品车 二手车
//			carAttachmentStockInOut.setStockId(waybill.getStockId());
//			carAttachmentStockInOut.setBusinessId(Integer.valueOf(params.get("waybillId").toString()));
//			carAttachmentStockInOut.setCount(sumCount);
//			//carAttachmentStockInOut.setMark("");
//			carAttachmentStockInOut.setStatus(String.valueOf(Constants.CarAttchmentStockInOutStatus.UNREVIEW));
//			carAttachmentStockInOut.setInsertTime(new Date());
//			carAttachmentStockInOut.setInsertUser(params.get("insertUser").toString());
//			carAttachmentStockInOut.setDelFlag(Constants.DelFlag.N);
//			carAttachmentStockInOutMapper.save(carAttachmentStockInOut);
//			for(int i = 0; i < list.size();i++)
//			{
//				list.get(i).setType(waybill.getType());//如果直接新建配件，后运单绑定时，该type字段为空，需要处理
//				carAttachmentMngMapper.update(list.get(i));
//				
//				CarAttachmentStockInOutDetail carAttachmentStockInOutDetail = new CarAttachmentStockInOutDetail();
//				carAttachmentStockInOutDetail.setParentId(carAttachmentStockInOut.getId());
//				carAttachmentStockInOutDetail.setBusinessId(Integer.valueOf(params.get("waybillId").toString()));
//				carAttachmentStockInOutDetail.setStockId(list.get(i).getStockId());
//				carAttachmentStockInOutDetail.setType(Constants.CarAttchmentType.RU);//入库
//				carAttachmentStockInOutDetail.setWaybillId(list.get(i).getWaybillId());
//				carAttachmentStockInOutDetail.setAttachmentName(list.get(i).getAttachmentName());
//				carAttachmentStockInOutDetail.setCount(list.get(i).getCount());
//				carAttachmentStockInOutDetail.setPosition(list.get(i).getPosition());
//				carAttachmentStockInOutDetail.setMark(list.get(i).getMark());
//				carAttachmentStockInOutDetail.setInsertTime(list.get(i).getInsertTime());
//				carAttachmentStockInOutDetail.setInsertUser(list.get(i).getInsertUser());
//				carAttachmentStockInOutDetail.setDelFlag(list.get(i).getDelFlag());//明细保存这些为了和库存数据一致
//				carAttachmentStockInOutDetailMapper.save(carAttachmentStockInOutDetail);
//				
//			}
//			
//		}
//	}

	@Override
	@SystemServiceLog(description="审核通过配件，改变状态")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void checked(Map<String, Object> params) throws Exception {
		Map<String, Object> params3 = new HashMap<String, Object>();
		params3.put("status", Constants.CarAttchmentStockStatus.HASIN);//已入库
		params3.put("updateTime", new Date());
		params3.put("updateUser", params.get("insertUser"));
		params3.put("waybillId", params.get("waybillId"));
		carAttachmentMngMapper.updateByWaybillId(params3);
		
		Map<String, Object> params2 = new HashMap<String, Object>();
		params2.put("waybillId", params.get("waybillId"));
		List<CarAttachmentStock> list = carAttachmentMngMapper.getByConditions(params2);
		if(null != list && list .size() > 0)
		{
			int sumCount = 0;
			for(int i = 0; i < list.size();i++)
			{
				sumCount += list.get(i).getCount();
			}
			Waybill waybill = waybillMapper.getById(Integer.parseInt(params.get("waybillId").toString()));
			CarAttachmentStockInOut carAttachmentStockInOut = new CarAttachmentStockInOut();
			carAttachmentStockInOut.setType(waybill.getType());//商品车 二手车
			carAttachmentStockInOut.setStockId(waybill.getStockId());
			carAttachmentStockInOut.setBusinessId(Integer.valueOf(params.get("waybillId").toString()));
			carAttachmentStockInOut.setCount(sumCount);
			//carAttachmentStockInOut.setMark("");
			carAttachmentStockInOut.setStatus(String.valueOf(Constants.CarAttchmentStockInOutStatus.FINISH));
			carAttachmentStockInOut.setInsertTime(new Date());
			carAttachmentStockInOut.setInsertUser(params.get("insertUser").toString());
			carAttachmentStockInOut.setDelFlag(Constants.DelFlag.N);
			carAttachmentStockInOutMapper.save(carAttachmentStockInOut);
			for(int i = 0; i < list.size();i++)
			{
				list.get(i).setType(waybill.getType());//如果直接新建配件，后运单绑定时，该type字段为空，需要处理
				carAttachmentMngMapper.update(list.get(i));
				
				CarAttachmentStockInOutDetail carAttachmentStockInOutDetail = new CarAttachmentStockInOutDetail();
				carAttachmentStockInOutDetail.setParentId(carAttachmentStockInOut.getId());
				carAttachmentStockInOutDetail.setBusinessId(Integer.valueOf(params.get("waybillId").toString()));
				carAttachmentStockInOutDetail.setStockId(list.get(i).getStockId());
				carAttachmentStockInOutDetail.setType(Constants.CarAttchmentType.RU);//入库
				carAttachmentStockInOutDetail.setWaybillId(list.get(i).getWaybillId());
				carAttachmentStockInOutDetail.setAttachmentName(list.get(i).getAttachmentName());
				carAttachmentStockInOutDetail.setCount(list.get(i).getCount());
				carAttachmentStockInOutDetail.setPosition(list.get(i).getPosition());
				carAttachmentStockInOutDetail.setMark(list.get(i).getMark());
				carAttachmentStockInOutDetail.setInsertTime(list.get(i).getInsertTime());
				carAttachmentStockInOutDetail.setInsertUser(list.get(i).getInsertUser());
				carAttachmentStockInOutDetail.setDelFlag(list.get(i).getDelFlag());//明细保存这些为了和库存数据一致
				carAttachmentStockInOutDetailMapper.save(carAttachmentStockInOutDetail);
				
			}
			
		}
		
	}

//	@Override
//	@SystemServiceLog(description="审核不通过配件，删除入库")
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
//	public void unChecked(Map<String, Object> params) throws Exception {
//		Map<String, Object> params2 = new HashMap<String, Object>();
//		params2.put("updateTime", new Date());
//		params2.put("updateUser", params.get("insertUser"));
//		params2.put("delFlag", Constants.DelFlag.Y);
//		params2.put("businessId", params.get("waybillId"));
//		carAttachmentStockInOutMapper.deleteByBusinessId(params2);
//		carAttachmentStockInOutDetailMapper.deleteByBusinessId(params2);
//	}

	@Override
	@SystemServiceLog(description="查询所有的运单号")
	public List<Waybill> getWaybillList(Map<String, Object> params) throws Exception {
		return waybillMapper.getAllList(params);
	}

//	@Override
//	@SystemServiceLog(description="提交配件库存(出库)，插入配件出库数据")
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
//	public void submitSchedule(Map<String, Object> params) throws Exception {
//		//查询调度单  scheduleBillNo--调度单号，userId
//		List<ScheduleBillDetail> detailList = scheduleBillDetailMapper.getByBillNo(params.get("scheduleBillNo").toString());
//		int sumCount=0;
//		if(null != detailList && detailList.size() > 0)
//		{
//			for(int i = 0;i< detailList.size();i++)
//			{
//				if(detailList.get(i).getAttachmentIds().trim() != null && !detailList.get(i).getAttachmentIds().trim().equals("") && detailList.get(i).getAttachmentCounts().trim() != null && !detailList.get(i).getAttachmentCounts().trim().equals(""))
//				{
//					String attachmentCounts = detailList.get(i).getAttachmentCounts();
//					String[] countArr = attachmentCounts.split(",");
//					if(countArr.length > 0)
//					{
//						//获取所有的数量
//						for(int j=0; j<countArr.length; j++){
//							sumCount += Integer.parseInt(countArr[j]);
//						}
//					}
//				}
//			}
//			//插入配件出入库表carAttachmentStockInOut
//			CarAttachmentStockInOut carAttInOut = new CarAttachmentStockInOut();
//			carAttInOut.setType(Constants.CarAttchmentType.CHU);//出库
//			carAttInOut.setStockId(Integer.parseInt(userMapper.getById(Integer.parseInt(params.get("userId").toString())).getStockId()));
//			carAttInOut.setBusinessId(Integer.parseInt(scheduleBillMapper.getByBillNo(params.get("scheduleBillNo").toString()).getId().toString()));//调度id
//			carAttInOut.setCount(sumCount);
//			carAttInOut.setStatus(Constants.CarAttchmentStockInOutStatus.UNREVIEW);//1  待复核
//			carAttInOut.setInsertTime(new Date());
//			carAttInOut.setInsertUser(params.get("userId").toString());
//			carAttInOut.setDelFlag(Constants.DelFlag.N);
//			carAttachmentStockInOutMapper.save(carAttInOut);
//			
//			for(int i = 0;i< detailList.size();i++)
//			{
//				if(detailList.get(i).getAttachmentIds().trim() != null && !detailList.get(i).getAttachmentIds().trim().equals("") && detailList.get(i).getAttachmentCounts().trim() != null && !detailList.get(i).getAttachmentCounts().trim().equals(""))
//				{
//					String attachmentIds = detailList.get(i).getAttachmentIds();
//					String[] idArr = attachmentIds.split(",");
//					
//					String attachmentCounts = detailList.get(i).getAttachmentCounts();
//					String[] countArr = attachmentCounts.split(",");
//					if(idArr.length>0 && countArr.length > 0)
//					{
//						for(int j = 0;j<idArr.length;j++)
//						{
//							//查询配件库存
//							CarAttachmentStock carAtt = carAttachmentMngMapper.getById(Integer.parseInt(idArr[j]));
//							//插入表配件出入库明细表carAttachmentStockInOutDetail
//							CarAttachmentStockInOutDetail carAttInOutDetail = new CarAttachmentStockInOutDetail();
//							carAttInOutDetail.setParentId(carAttInOut.getId());
//							carAttInOutDetail.setBusinessId(detailList.get(i).getId());//调度详细id;
//							carAttInOutDetail.setStockId(Integer.parseInt(userMapper.getById(Integer.parseInt(params.get("userId").toString())).getStockId()));
//							carAttInOutDetail.setType(carAtt.getType());//配件库存存取出是入库  实际是出库  （为了和配件库存数据一致）
//							carAttInOutDetail.setWaybillId(carAtt.getWaybillId());
//							carAttInOutDetail.setAttachmentName(carAtt.getAttachmentName());
//							carAttInOutDetail.setCount(Integer.parseInt(countArr[j]));
//							carAttInOutDetail.setPosition(carAtt.getPosition());
//							carAttInOutDetail.setInsertTime(new Date());
//							carAttInOutDetail.setInsertUser(params.get("userId").toString());
//							carAttInOutDetail.setDelFlag(Constants.DelFlag.N);
//							carAttachmentStockInOutDetailMapper.save(carAttInOutDetail);
//						}
//					}
//				}
//			}
//		}
//		
//	}

	@Override
	@SystemServiceLog(description="审核通过配件，改变库存数量,改变主表状态")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void checkedSchedule(Map<String, Object> params) throws Exception {
		//查询调度单  scheduleBillNo--调度单号，userId
		ScheduleBill scheduleBill = scheduleBillMapper.getByBillNo(params.get("scheduleBillNo").toString());
		String scheduleBillNo = scheduleBill.getScheduleBillNo();
		List<ScheduleBillDetail> detailList = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
		String oper = params.get("userId").toString();
		User user = userMapper.getById(Integer.parseInt(oper));
		
		int sumCount=0;
		if(null != detailList && detailList.size() > 0)
		{
			for(int i = 0;i< detailList.size();i++)
			{
				if(detailList.get(i).getAttachmentIds().trim() != null && !detailList.get(i).getAttachmentIds().trim().equals("") && detailList.get(i).getAttachmentCounts().trim() != null && !detailList.get(i).getAttachmentCounts().trim().equals(""))
				{
					String attachmentCounts = detailList.get(i).getAttachmentCounts();
					String[] countArr = attachmentCounts.split(",");
					if(countArr.length > 0)
					{
						//获取所有的数量
						for(int j=0; j<countArr.length; j++){
							sumCount += Integer.parseInt(countArr[j]);
						}
					}
				}
			}
			//插入配件出入库表carAttachmentStockInOut
			CarAttachmentStockInOut carAttInOut = new CarAttachmentStockInOut();
			carAttInOut.setType(Constants.CarAttchmentType.CHU);//出库
			carAttInOut.setStockId(Integer.parseInt(user.getStockId()));
			carAttInOut.setBusinessId( scheduleBill.getId() );//调度id
			carAttInOut.setCount(sumCount);
			carAttInOut.setStatus(Constants.CarAttchmentStockInOutStatus.FINISH);//已完成
			carAttInOut.setInsertTime(new Date());
			carAttInOut.setInsertUser( oper );
			carAttInOut.setDelFlag(Constants.DelFlag.N);
			carAttachmentStockInOutMapper.save(carAttInOut);
			
			for(int i = 0;i< detailList.size();i++)
			{
				if(detailList.get(i).getAttachmentIds().trim() != null && !detailList.get(i).getAttachmentIds().trim().equals("") && detailList.get(i).getAttachmentCounts().trim() != null && !detailList.get(i).getAttachmentCounts().trim().equals(""))
				{
					String attachmentIds = detailList.get(i).getAttachmentIds();
					String[] idArr = attachmentIds.split(",");
					
					String attachmentCounts = detailList.get(i).getAttachmentCounts();
					String[] countArr = attachmentCounts.split(",");
					if(idArr.length>0 && countArr.length > 0)
					{
						for(int j = 0;j<idArr.length;j++)
						{
							//查询配件库存
							CarAttachmentStock carAtt = carAttachmentMngMapper.getById(Integer.parseInt(idArr[j]));
							//插入表配件出入库明细表carAttachmentStockInOutDetail
							CarAttachmentStockInOutDetail carAttInOutDetail = new CarAttachmentStockInOutDetail();
							carAttInOutDetail.setParentId(carAttInOut.getId());
							carAttInOutDetail.setBusinessId(detailList.get(i).getId());//调度详细id;
							carAttInOutDetail.setStockId(Integer.parseInt(userMapper.getById(Integer.parseInt(params.get("userId").toString())).getStockId()));
							carAttInOutDetail.setType(carAtt.getType());//配件库存存取出是入库  实际是出库  （为了和配件库存数据一致）
							carAttInOutDetail.setWaybillId(carAtt.getWaybillId());
							carAttInOutDetail.setAttachmentName(carAtt.getAttachmentName());
							carAttInOutDetail.setCount(Integer.parseInt(countArr[j]));
							carAttInOutDetail.setPosition(carAtt.getPosition());
							carAttInOutDetail.setInsertTime(new Date());
							carAttInOutDetail.setInsertUser(oper);
							carAttInOutDetail.setDelFlag(Constants.DelFlag.N);
							carAttachmentStockInOutDetailMapper.save(carAttInOutDetail);
						}
					}
				}
			}
		}
				
				
		String userId = params.get("userId").toString();
		//改变主表状态
		if(null != detailList && detailList.size() > 0)
		{
			for(int i = 0;i<detailList.size();i++)
			{
				if(detailList.get(i).getAttachmentIds().trim() != null && !detailList.get(i).getAttachmentIds().trim().equals("") && detailList.get(i).getAttachmentCounts().trim() != null && !detailList.get(i).getAttachmentCounts().trim().equals(""))
				{
					String attachmentIds = detailList.get(i).getAttachmentIds();
					String[] idArr = attachmentIds.split(",");
					
					String attachmentCounts = detailList.get(i).getAttachmentCounts();
					String[] countArr = attachmentCounts.split(",");
					if(idArr.length>0 && countArr.length > 0)
					{
						for(int j = 0;j<idArr.length;j++)
						{
							//查询配件库存
							CarAttachmentStock carAtt = carAttachmentMngMapper.getById(Integer.parseInt(idArr[j]));
							if(null != carAtt.getCount())
							{
								int count = carAtt.getCount();
								if(Integer.parseInt(countArr[j]) < count)
								{
									//减去
									int cha = count-Integer.parseInt(countArr[j]);
									CarAttachmentStock carAttStock = new CarAttachmentStock();
									carAttStock.setCount(cha);
									carAttStock.setId(Integer.parseInt(idArr[j]));
									carAttachmentMngMapper.update(carAttStock);
								}
								if(Integer.parseInt(countArr[j]) > count)
								{
									throw new RuntimeException("配件出库数量大于库存数量");
								}
								if(Integer.parseInt(countArr[j]) == count)
								{
									//删除库存数据
									Map<String, Object> params2 = new HashMap<String, Object>();
									params2.put("updateTime", new Date());
									params2.put("updateUser", userId);
									params2.put("count", count-Integer.parseInt(countArr[j]));
									params2.put("delFlag", Constants.DelFlag.Y);
									params2.put("id", idArr[j]);
									carAttachmentMngMapper.delete(params2);
								}
							}
						}
					}
				}
			}
		}
	}

//	@Override
//	@SystemServiceLog(description="审核不通过配件，删除出库单数据")
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
//	public void unCheckedSchedule(Map<String, Object> params) throws Exception {
//		String userId = params.get("userId").toString();
//		String scheduleBillNo = params.get("scheduleBillNo").toString();
//		ScheduleBill scheduleBill= scheduleBillMapper.getByBillNo(scheduleBillNo);
//		List<ScheduleBillDetail> detailList = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
//		
//		Map<String, Object> params2 = new HashMap<String, Object>();
//		params2.put("updateTime", new Date());
//		params2.put("updateUser", userId);
//		params2.put("delFlag", Constants.DelFlag.Y);
//		params2.put("businessId", scheduleBill.getId());
//		carAttachmentStockInOutMapper.deleteByBusinessId(params2);
//		
//		if(null != detailList && detailList.size() > 0)
//		{
//			for(int i = 0;i<detailList.size();i++)
//			{
//				params2.put("updateTime", new Date());
//				params2.put("updateUser", userId);
//				params2.put("delFlag", Constants.DelFlag.Y);
//				params2.put("businessId", detailList.get(i).getId());
//				carAttachmentStockInOutDetailMapper.deleteByBusinessId(params2);
//			}
//		}
//		
//	}

	@Override
	@SystemServiceLog(description="配件名称或者运单编号模糊查询")
	public Pager<CarAttachmentStock> getPageByNameOrNo(
			Map<String, Object> params) throws Exception {
		String pageSize;
		try {
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		} catch (Exception e) {
			throw new RuntimeException("参数缺失或不正确");
		}
		List<CarAttachmentStock> list = carAttachmentMngMapper.getListByNameOrNo(params);
		int totalCount = carAttachmentMngMapper.getListByNameOrNoTotal(params);
		Pager<CarAttachmentStock> pager = new Pager<CarAttachmentStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

	@Override
	public Pager<CarAttachmentStock> getPageDataDam(Map<String, Object> params)
			throws Exception {
		String pageSize;
		try {
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
		} catch (Exception e) {
			throw new RuntimeException("参数缺失或不正确");
		}
		//params.put("delFlag", Constants.DelFlag.N);
		List<CarAttachmentStock> list = carAttachmentMngMapper.getPageListDam(params);
		int totalCount = carAttachmentMngMapper.getPageTotalCountDam(params);
		Pager<CarAttachmentStock> pager = new Pager<CarAttachmentStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

	@Override
	public List<CarAttachmentStock> checkRuAttWaybillId(Map<String, Object> params)
			throws Exception {
		return carAttachmentMngMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="保存折损配件")
	public void saveZS(CarAttachmentStock bean, String stockId, String userName)
			throws Exception {
		if( null == bean ){
			throw new RuntimeException("实体为空");
		}
		bean.setStockId(Integer.valueOf(stockId));
		//Waybill waybill =  waybillMapper.getById(bean.getWaybillId());
		bean.setType("2");
		bean.setStatus(String.valueOf(Constants.CarAttchmentStockStatus.NEW));
		bean.setInsertTime(new Date());
		bean.setInsertUser(userName);
		bean.setDelFlag(Constants.DelFlag.N);
		carAttachmentMngMapper.save(bean);
	}

	@Override
	public void updateZS(CarAttachmentStock bean) throws Exception {
		carAttachmentMngMapper.update(bean);
	}



}
