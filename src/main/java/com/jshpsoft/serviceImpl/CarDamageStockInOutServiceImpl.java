package com.jshpsoft.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarAttachmentStockMapper;
import com.jshpsoft.dao.CarDamageStockInOutDetailMapper;
import com.jshpsoft.dao.CarDamageStockInOutMapper;
import com.jshpsoft.dao.CarDamageStockMapper;
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.CarDamageStockInOut;
import com.jshpsoft.domain.CarDamageStockInOutDetail;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarAttachmentStockService;
import com.jshpsoft.service.CarDamageMngService;
import com.jshpsoft.service.CarDamageStockInOutService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年10月8日 下午2:33:25
 */
@Service("carDamageStockInOutService")
public class CarDamageStockInOutServiceImpl implements CarDamageStockInOutService {

	@Resource
	WaybillMapper waybillMapper;
	@Resource
	CarDamageStockInOutMapper carDamageStockInOutMapper;
	@Resource
	CarDamageStockInOutDetailMapper carDamageStockInOutDetailMapper;
	@Resource
	CarDamageStockMapper carDamageStockMapper;
	@Resource
	private CarDamageMngService carDamageMngService;
	@Resource
	private  CarAttachmentStockService carAttachmentStockService;
	@Resource
	CarAttachmentStockMapper carAttachmentStockMapper;
	@Resource
	UserMapper userMapper;
	@Resource
	CashInOutMapper cashInOutMapper;
	@Resource
	CommonService commonService;
	
	//折损车入库管理数据
	public Pager<Waybill> getRuPageData(Map<String, Object> params)
			throws Exception 
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
		List<Waybill> list = waybillMapper.getPageList(params);
		int totalCount = waybillMapper.getPageTotalCount(params);
		Pager<Waybill> pager = new Pager<Waybill>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="折损车入库单管理--保存")
	public void saveRu(Waybill waybill, String stockId, int userId)
			throws Exception {
		if(null != waybill )
		{
			waybill.setStockId(Integer.parseInt(stockId));
			waybill.setType(Constants.WaybillType.ZSC);
			waybill.setWaybillNo(CommonUtil.getWaybillNo_ZS());
			waybill.setStatus(Constants.WaibillStatus.NEW.getValue());
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat(Constants.DATE_TIME_FORMAT);
			waybill.setInsertTime(simpleDateFormat.format(new Date()));
			waybill.setInsertUser(String.valueOf(userId));
			waybill.setDelFlag(Constants.DelFlag.N);
			waybillMapper.insertWaybill(waybill);
		}
	}
	
	@Override
	@SystemServiceLog(description="折损车入库单管理--删除")
	public void deleteWaybill(int id) throws Exception {
		waybillMapper.deleteWaybill(id);
	}
	
	@Override
	@SystemServiceLog(description="折损车入库单管理--提交")
	public int submitWaybill(Map<String, Object> params) throws Exception {
		params.put("status", Constants.WaibillStatus.NEW.getValue());
		int count = carDamageStockMapper.selectCountByWayId(params);
		if( count <=0 )
			return -1 ;
		
		params.put("status", Constants.WaibillStatus.UNREVIEW.getValue());
		int waybill = waybillMapper.submitWaybill(params);
		if(waybill > 0 ){			
			int waybillId = (int) params.get("id");
			String oper =params.get("operId").toString();
			carDamageMngService.submit(waybillId, oper);
//			Map<String, Object> params2 = new HashMap<String, Object>();
//			params2.put("waybillId", waybillId);
//			params2.put("insertUser", oper);
//			carAttachmentStockService.submit(params2);
			return waybill ;
		}
		return 0;
	}
	
	@Override
	@SystemServiceLog(description="绑定折损车")
	public void bindCarDamStock(Map<String, Object> params) throws Exception {
		String waybillId = params.get("waybillId").toString();
		Map<String, Object> par = new HashMap<String, Object>();
		par.put("waybillId", waybillId);
		par.put("status", Constants.CarStatus.NEW);
		List<String> list = new ArrayList<String>();
		List<CarDamageStock> Carlist = carDamageStockMapper.getByConditions(par);
		if(null != Carlist && Carlist.size() > 0)
		{
			Map<String, Object> para = new HashMap<String, Object>();
			for(int i = 0;i<Carlist.size();i++)
			{
				list.add(Carlist.get(i).getId().toString());
			}
			para.put("list", list);
			para.put("waybillId", "");
			carDamageStockMapper.bindCarDamStock(para);//先置空
		}
		carDamageStockMapper.bindCarDamStock(params);
	}
	
	@Override
	public List<CarDamageStock> checkRuWaybillId(Map<String, Object> params) throws Exception {
		//params.put("status", Constants.CarStatus.NEW);
		List<CarDamageStock> list = carDamageStockMapper.getByConditions(params);
		return list;
	}
	
	@Override
	@SystemServiceLog(description="绑定折损配件")
	public void bindDamAttachment(Map<String, Object> params) throws Exception {
		String waybillId = params.get("waybillId").toString();
		Map<String, Object> par = new HashMap<String, Object>();
		par.put("waybillId", waybillId);
		par.put("status", Constants.CarStatus.NEW);
		List<String> list = new ArrayList<String>();
		List<CarAttachmentStock> Attlist = carAttachmentStockMapper.getByConditions(par);
		if(null != Attlist && Attlist.size() > 0)
		{
			Map<String, Object> para = new HashMap<String, Object>();
			for(int i = 0;i<Attlist.size();i++)
			{
				list.add(Attlist.get(i).getId().toString());
			}
			para.put("list", list);
			para.put("waybillId", "");
			carAttachmentStockMapper.bindDamAttachment(para);//先置空
		}
		carAttachmentStockMapper.bindDamAttachment(params);
	}

	
	@Override
	@SystemServiceLog(description="入库单详细信息,绑定的折损车和配件")
	public Waybill checkWaybill(int id) throws Exception {
		Waybill waybill = waybillMapper.queryWaybill(id);
		
		if(null != waybill){
			List<CarDamageStock> list = carDamageStockMapper.queryCarDamStock(id);
			waybill.setCarDamageStockList(list);
			 List<CarAttachmentStock> list2 = carAttachmentStockMapper.queryCarAttachment(id);
			waybill.setCarAttachmentStockList(list2);
		}
		
		return waybill;
	}

	
	
	
	
	
	//折损车出库登记数据
	@Override
	public Pager<CarDamageStockInOutDetail> getPageData(Map<String, Object> params)
			throws Exception 
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
		List<CarDamageStockInOutDetail> list = carDamageStockInOutDetailMapper.getPageList(params);
		int totalCount = carDamageStockInOutDetailMapper.getPageTotalCount(params);
		Pager<CarDamageStockInOutDetail> pager = new Pager<CarDamageStockInOutDetail>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}


	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@SystemServiceLog(description="插入折损车出库")
	public void save(CarDamageStockInOut bean,String stockId,String userId) throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		
		List<CarDamageStockInOutDetail> list = bean.getDetailList();
		if(null == list || list.size() < 0)
		{
			throw new RuntimeException("折损车出库明细集合为空");
		}
		/*String businessId = "";
		for(int i = 0; i < list.size(); i++)
		{
			businessId += list.get(i).getWaybillId()+",";
		}*/
		bean.setType(Constants.CarType.OUT);
		bean.setStockId(Integer.valueOf(stockId));
		//bean.setBusinessId(businessId.substring(0, businessId.length()-1));
		bean.setMark(bean.getMark());
		bean.setStatus(String.valueOf(Constants.CarAttchmentStockInOutStatus.NEW));
		bean.setInsertTime(new Date());
		bean.setInsertUser(userId);
		bean.setDelFlag(Constants.DelFlag.N);
		carDamageStockInOutMapper.save(bean);//折损车出入库
		
		for(int i = 0; i < list.size(); i++)
		{
			CarDamageStockInOutDetail detail = new CarDamageStockInOutDetail();
			detail.setParentId(bean.getId());
			detail.setStockId(Integer.parseInt(stockId));
			detail.setBusinessId(list.get(i).getId());//折损库存车id 
			//detail.setWaybillId(list.get(i).getWaybillId());
			detail.setBrand(list.get(i).getBrand());
			detail.setVin(list.get(i).getVin());
			detail.setModel(list.get(i).getModel());
			detail.setColor(list.get(i).getColor());
			detail.setEngineNo(list.get(i).getEngineNo());
			detail.setPosition(list.get(i).getPosition());
			detail.setInsertTime(new Date());
			detail.setInsertUser(userId);
			detail.setDelFlag(Constants.DelFlag.N);
			detail.setAmount(list.get(i).getAmount());
			carDamageStockInOutDetailMapper.save(detail);//出入库明细
		}
		
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@SystemServiceLog(description="修改折损车出库")
	public void update(CarDamageStockInOut bean,String userId) throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		//修改折损车出库状态
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(userId);
		carDamageStockInOutMapper.update(bean);
		List<CarDamageStockInOutDetail> list = bean.getDetailList();
		if(null == list || list.size() < 0)
		{
			throw new RuntimeException("折损车出库明细集合为空");
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("updateTime", new Date());
		params.put("updateUser", userId);
		params.put("delFlag", Constants.DelFlag.Y);
		params.put("parentId", bean.getId());
		carDamageStockInOutDetailMapper.delete(params);//先删除
		for(int i = 0; i < list.size(); i++)
		{
			CarDamageStockInOutDetail detail = new CarDamageStockInOutDetail();
			detail.setStockId(list.get(i).getStockId());
			detail.setParentId(bean.getId());
			detail.setBusinessId(list.get(i).getId());//折损车入库明细id 
			detail.setWaybillId(list.get(i).getWaybillId());
			detail.setBrand(list.get(i).getBrand());
			detail.setVin(list.get(i).getVin());
			detail.setModel(list.get(i).getModel());
			detail.setColor(list.get(i).getColor());
			detail.setEngineNo(list.get(i).getEngineNo());
			detail.setPosition(list.get(i).getPosition());
			detail.setInsertTime(new Date());
			detail.setInsertUser(userId);
			detail.setUpdateTime(new Date());
			detail.setUpdateUser(userId);
			detail.setDelFlag(Constants.DelFlag.N);
			detail.setAmount(list.get(i).getAmount());
			carDamageStockInOutDetailMapper.save(detail);//出入库明细
		}
		
	}

	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	@SystemServiceLog(description="删除折损车出库")
	public void delete(int id,String userId) throws Exception {
		
		/*Map<String, Object> params = new HashMap<String, Object>();
		params.put("updateTime", new Date());
		params.put("updateUser", userId);
		params.put("delFlag", Constants.DelFlag.Y);
		CarDamageStockInOut carDamageStockInOut = carDamageStockInOutMapper.getById(id);
		carDamageStockMapper.delete(params);*/
		
		Map<String, Object> params2 = new HashMap<String, Object>();
		params2.put("updateTime", new Date());
		params2.put("updateUser", userId);
		params2.put("delFlag", Constants.DelFlag.Y);
		params2.put("id", id);
		carDamageStockInOutMapper.delete(params2);
		
		Map<String, Object> params3 = new HashMap<String, Object>();
		params3.put("updateTime", new Date());
		params3.put("updateUser", userId);
		params3.put("delFlag", Constants.DelFlag.Y);
		params3.put("parentId", id);
		carDamageStockInOutDetailMapper.delete(params3);
	}


	@Override
	public List<CarDamageStockInOut> getListData() throws Exception {
		return carDamageStockInOutMapper.getListData();
	}


	@Override
	public CarDamageStockInOut getById(int id) throws Exception {
		CarDamageStockInOut carDamageStockInOut = new CarDamageStockInOut();
		carDamageStockInOut = carDamageStockInOutMapper.getById(id);
		List<CarDamageStockInOutDetail> carDamageStockInOutDetail = carDamageStockInOutDetailMapper.getByParent(id);
		List<CarDamageStockInOutDetail>detailList = new ArrayList<CarDamageStockInOutDetail>();
		detailList.addAll(carDamageStockInOutDetail);
		carDamageStockInOut.setDetailList(detailList);
		return carDamageStockInOut;
	}

	//折损车出库管理数据
	@Override
	public Pager<CarDamageStockInOut> getCarDamOutData(
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
		List<CarDamageStockInOut> list = carDamageStockInOutMapper.getPageList(params);
		int totalCount = carDamageStockInOutMapper.getPageTotalCount(params);
		Pager<CarDamageStockInOut> pager = new Pager<CarDamageStockInOut>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}


	@Override
	public List<CarDamageStock> getCarDamRuList(
			Map<String, Object> params) throws Exception {
		
		return carDamageStockMapper.getCarDamRuList(params);
	}


	
	@Override
	public List<CarDamageStockInOutDetail> getByParentId(int id)
			throws Exception {
		
		return carDamageStockInOutDetailMapper.getByParent(id);
	}


	@Override
	public void submit(int id, String userId) throws Exception {
		CarDamageStockInOut carDamageStockInOut = new CarDamageStockInOut();
		carDamageStockInOut.setId(id);
		carDamageStockInOut.setStatus(Constants.CarAttchmentStockInOutStatus.UNREVIEW);//待审核
		carDamageStockInOut.setUpdateTime(new Date());
		carDamageStockInOut.setUpdateUser(userId);
		carDamageStockInOutMapper.update(carDamageStockInOut);
		
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.ZSCRKSQD, 
				id, 
				Integer.parseInt(userId), 
				CommonUtil.getProcessName(Constants.ProcessType.ZSCRKSQD, CommonUtil.format(new Date(), Constants.DATE_TIME_FORMAT_SHORT) )
				);
	}


	@Override
	@Transactional
	public void auditSuccess(int detailId, int status, int userId)throws Exception {
		CarDamageStockInOut carDamageStockInOut = new CarDamageStockInOut();
		carDamageStockInOut.setId(detailId);
		carDamageStockInOut.setStatus(status+"");
		carDamageStockInOut.setUpdateTime(new Date());
		carDamageStockInOut.setUpdateUser(userId+"");
		carDamageStockInOutMapper.update(carDamageStockInOut);
		
		//出库动作
		//更新carStock状态为2已出库
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentId", detailId);
		params.put("delFlag", Constants.DelFlag.N);
		List<CarDamageStockInOutDetail> list = carDamageStockInOutDetailMapper.getByConditions(params);
		double amount = 0.0;
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				CarDamageStock bean = new CarDamageStock();
				bean.setId(list.get(i).getBusinessId());
				bean.setStatus(Constants.CarStatus.HASOUT);
				bean.setOutAmount(list.get(i).getAmount());
				carDamageStockMapper.update(bean);
				
				if( null != list.get(i).getAmount() ){
					amount += list.get(i).getAmount().doubleValue();
				}
				
			}
			
		}
		
		CarDamageStockInOut detail = carDamageStockInOutMapper.getById(detailId);
		//收支管理生成1条记录
		double money = CommonUtil.formatDouble(amount);
		CashInOut cash = new CashInOut();
		//设置收支相关部门id
		User user = userMapper.getById( Integer.parseInt(detail.getInsertUser()) );
		int departmentId = 0;
		if( null != user && null != user.getDepartmentId() ){
			departmentId = user.getDepartmentId();
		}
		cash.setDepartmentId(departmentId);
		cash.setBusinessType(Constants.CashInOutBusinessType.CarDamageStockOut);
		cash.setType(Constants.CashInOutType.IN);
		cash.setDetailId(detailId);
		cash.setMark("折损出入库-出库");
		cash.setMoney( money );
		cash.setDelFlag(Constants.DelFlag.N);
		cash.setInsertTime(new Date());
		cash.setInsertUser(userId+"");
		cash.setUpdateTime(new Date());
		cash.setUpdateUser(userId+"");
		cash.setStatus(Constants.CashInOutStatus.SUBMIT);
		cash.setSystemFlag(Constants.SystemFlag.Y);
		cashInOutMapper.insert(cash);
			
	}

	@Override
	@Transactional
	public void auditFail(int detailId, int status, int userId)throws Exception {
		auditForConfirm(detailId, status, userId);
		
	}

	@Override
	public void auditForConfirm(int detailId, int status, int userId) throws Exception {
		CarDamageStockInOut carDamageStockInOut = new CarDamageStockInOut();
		carDamageStockInOut.setId(detailId);
		carDamageStockInOut.setStatus(status+"");
		carDamageStockInOut.setUpdateTime(new Date());
		carDamageStockInOut.setUpdateUser(userId+"");
		carDamageStockInOutMapper.update(carDamageStockInOut);
		
	}
	
}
