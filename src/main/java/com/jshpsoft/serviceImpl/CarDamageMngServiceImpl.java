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
import com.jshpsoft.dao.CarAttachmentStockMapper;
import com.jshpsoft.dao.CarDamageStockInOutDetailMapper;
import com.jshpsoft.dao.CarDamageStockInOutMapper;
import com.jshpsoft.dao.CarDamageStockMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.CarDamageStockInOut;
import com.jshpsoft.domain.CarDamageStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarDamageMngService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("carDamageMngService")
public class CarDamageMngServiceImpl implements CarDamageMngService {
	
	@Autowired
	private CarDamageStockMapper carDamageStockMapper;
	
	@Autowired
	private CarDamageStockInOutMapper carDamageStockInOutMapper;
	
	@Autowired
	private CarDamageStockInOutDetailMapper carDamageStockInOutDetailMapper;
	
	@Autowired
	private WaybillMapper waybillMapper;
	@Autowired
	private CarAttachmentStockMapper carAttachmentStockMapper;

	@Override
	@SystemServiceLog(description="查询折损车列表信息1")
	public Pager<CarDamageStock> getPageData(Map<String, Object> params) throws Exception {
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
		List<CarDamageStock> list = carDamageStockMapper.getPageList(params);
		int totalCount = carDamageStockMapper.getPageTotalCount(params);
		
		Pager<CarDamageStock> pager = new Pager<CarDamageStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="查询新建状态的运单编号")
	public List<Waybill> getWaybillNo(Map<String, Object> params) throws Exception {
		return waybillMapper.getWaybillNo(params);
	}
	
	@Override
	@SystemServiceLog(description="新增折损车信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(CarDamageStock bean, String oper) throws Exception {
		
		if( null == bean ){
			throw new RuntimeException("折损车信息为空");
		}
		
		//验证该折损车是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vin", bean.getVin());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarDamageStock> carDamage = carDamageStockMapper.getByConditions(params);
		if(null !=carDamage && carDamage.size()>0){
			throw new RuntimeException("该折损车已存在，请检查");
		}
		
		//插入折损车库存表
		bean.setStatus(Constants.CarStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		carDamageStockMapper.save(bean);
	} 

	@Override
	@SystemServiceLog(description="根据id获取折损车明细")
	public CarDamageStock getById(Integer id) throws Exception {
		return carDamageStockMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新折损车信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(CarDamageStock bean, String oper) throws Exception {
		
		if( null == bean ){
			throw new RuntimeException("折损车信息为空");
		}
		
		//验证该折损车是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vin", bean.getVin());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarDamageStock> carDamage = carDamageStockMapper.getByConditions(params);
		if(null !=carDamage && carDamage.size()>0 && (int)carDamage.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该折损车已存在，请检查");
		}
		
		//更新折损车库存数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		carDamageStockMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除折损车信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		//更新折损车库存删除标志
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		carDamageStockMapper.delete(params);
	}

	@Override
	@SystemServiceLog(description="获取折损车出入库信息")
	public List<CarDamageStockInOut> getCarDamageInOutListData(Map<String, Object> params) throws Exception {
		List<CarDamageStockInOut> list = carDamageStockInOutMapper.getByConditions(params);
		if(null !=list && list.size()>0){
			for(int i=0;i<list.size();i++){
				CarDamageStockInOut bean = list.get(i);
				
				params.put("parentId", bean.getId());
				List<CarDamageStockInOutDetail> detailList = carDamageStockInOutDetailMapper.getByConditions(params);
				bean.setDetailList(detailList);
			}
		}
		
		return list;
	}
	
	@Override
	@SystemServiceLog(description="提交折损车信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer waybillId, String oper) throws Exception {
		
		//查询折损车
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("waybillId", waybillId);
		params.put("status", Constants.CarStatus.NEW);//新建
		params.put("delFlag", Constants.DelFlag.N);
		List<CarDamageStock> list = carDamageStockMapper.getByConditions(params);
		
		if(null !=list && list.size()>0){
			
			Date time = new Date();
			
			//插入表carDamageStockInOut
			CarDamageStockInOut iOut = new CarDamageStockInOut();
			iOut.setType(Constants.CarType.IN);//入库
			iOut.setStockId(list.get(0).getStockId());
			iOut.setBusinessId(waybillId);
			iOut.setCount(list.size());
			iOut.setStatus(Constants.CarInOutStatus.UNREVIEW);//1待审核
			iOut.setInsertTime(time);
			iOut.setInsertUser(oper);
			iOut.setUpdateTime(time);
			iOut.setUpdateUser(oper);
			iOut.setDelFlag(Constants.DelFlag.N);
			carDamageStockInOutMapper.save(iOut);
			
			//插入表carDamageStockInOutDetail
			for(int i=0; i<list.size(); i++){
				CarDamageStock bean = list.get(i);
				
				CarDamageStockInOutDetail detail = new CarDamageStockInOutDetail();
				detail.setParentId(iOut.getId());//carDamageStockInOut的id
				detail.setBusinessId(waybillId);
				detail.setStockId(bean.getStockId());
				detail.setWaybillId(waybillId);
				detail.setBrand(bean.getBrand());
				detail.setVin(bean.getVin());
				detail.setModel(bean.getModel());
				detail.setColor(bean.getColor());
				detail.setEngineNo(bean.getEngineNo());
				detail.setPosition(bean.getPosition());
				detail.setKeyPosition(bean.getKeyPosition());
				detail.setMark(bean.getMark());
				detail.setInsertTime(time);
				detail.setInsertUser(oper);
				detail.setUpdateTime(time);
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				carDamageStockInOutDetailMapper.save(detail);
			}
			
		}
	}
	
	@Override
	@SystemServiceLog(description="折损车审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void verifySuccess(Integer waybillId, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("waybillId", waybillId);
		params.put("status", Constants.CarStatus.HASIN);//1已入库
		
		//更新carDamageStock状态为1已入库
		carDamageStockMapper.updateByWaybillId(params);
		
		params.put("businessId", waybillId);
		params.put("status", Constants.CarInOutStatus.FINISH);//2已完成
		//更新carDamageStockInOut状态为2已完成
		carDamageStockInOutMapper.updateByBusinessId(params);
	}

	@Override
	@SystemServiceLog(description="折损车审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void verifyFail(Integer waybillId, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("businessId", waybillId);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		
		//删除carDamageStockInOut中数据--更新删除标志
		carDamageStockInOutMapper.updateByBusinessId(params);
		
		//删除carDamageStockInOutDetail中数据--更新删除标志
		carDamageStockInOutDetailMapper.updateByBusinessId(params);
	}

	@Override
	@SystemServiceLog(description="折损车出库审核通过")
	public void checkOK(int id, String userId) throws Exception {
		List<CarDamageStockInOutDetail> detailList = carDamageStockInOutDetailMapper.getByParent(id);
		if(null != detailList && detailList.size() > 0)
		{
			Map<String,Object> params = new HashMap<String, Object>();
			for(int i = 0;i<detailList.size();i++)
			{
				params.put("id", detailList.get(i).getBusinessId());
				params.put("updateTime", new Date());
				params.put("updateUser", userId);
				params.put("delFlag", Constants.DelFlag.Y);
				//因为库存没有数量，就是一台车，出库成功直接删除
				carDamageStockMapper.delete(params);
				//折损配件 根据折损库存的id查到折损库存对应的waybillId，然后根据waybillId 查询折损配件 
				CarDamageStock carDamageStock =  carDamageStockMapper.getById(detailList.get(i).getBusinessId());
				Map<String,Object> params2 = new HashMap<String, Object>();
				params2.put("updateTime", new Date());
				params2.put("updateUser", userId);
				params2.put("type", Constants.CarOutStockBillType.ZSC);
				params2.put("waybillId", carDamageStock.getWaybillId());
				carAttachmentStockMapper.updateByWaybillId(params2);
			}
		}
		
	}

	@Override
	@SystemServiceLog(description="折损车出库审核不通过")
	public void checkNo(int id, String userId) throws Exception {
		//直接改变主表的状态为新建
		CarDamageStockInOut bean = new CarDamageStockInOut();
		bean.setStatus(Constants.CarInOutStatus.NEW);
		bean.setId(id);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(userId);
		carDamageStockInOutMapper.update(bean);
		
	}

	@Override
	@SystemServiceLog(description="根据折损车出入库主表id查询折损车库存数据")
	public Pager<CarDamageStock> getPageDataByCarDamInOutId(
			Map<String, Object> params) throws Exception 
	{
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
		List<CarDamageStock> list = carDamageStockMapper.getCarDamPageListByCarDamInOutId(params);
		int totalCount = carDamageStockMapper.getCountByCarDamInOutId(params);
		
		Pager<CarDamageStock> pager = new Pager<CarDamageStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="折损出入库明细查看")
	public Pager<CarDamageStockInOutDetail> getDetailByParentId(
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
		List<CarDamageStockInOutDetail> list = carDamageStockInOutDetailMapper.getDetailByParentId(params);
		int totalCount = carDamageStockInOutDetailMapper.getDetailPageTotalCount(params);
		Pager<CarDamageStockInOutDetail> pager = new Pager<CarDamageStockInOutDetail>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}
	
}
