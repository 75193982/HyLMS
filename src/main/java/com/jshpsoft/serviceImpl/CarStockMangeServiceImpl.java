package com.jshpsoft.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarOutStockBillMapper;
import com.jshpsoft.dao.CarShopMapper;
import com.jshpsoft.dao.CarStockInOutDetailMapper;
import com.jshpsoft.dao.CarStockInOutMapper;
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.ScheduleBillDetailMapper;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.StockMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.CarStockInOut;
import com.jshpsoft.domain.CarStockInOutDetail;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleBillDetail;
import com.jshpsoft.domain.Stock;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarStockMangeService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("carStockMangeService")
public class CarStockMangeServiceImpl implements CarStockMangeService {
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private CarStockMapper carStockMapper;
	
	@Autowired
	private CarStockInOutMapper carStockInOutMapper;
	
	@Autowired
	private CarStockInOutDetailMapper carStockInOutDetailMapper;
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private ScheduleBillDetailMapper scheduleBillDetailMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private CarOutStockBillMapper carOutStockBillMapper;
	
	@Autowired
	private StockMapper stockMapper;
	
	@Autowired
	private CarShopMapper carShopMapper;

	@Override
	@SystemServiceLog(description="查询新建状态的运单编号")
	public List<Waybill> getWaybillNo(Map<String, Object> params) throws Exception {
		return waybillMapper.getAllList(params);
	}

	@Override
	@SystemServiceLog(description="商品车入库")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void carStockIn(CarStock bean, String stockId, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("商品车信息为空");
		}
		
		//验证该商品车是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vin", bean.getVin());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarStock> car = carStockMapper.getByConditions(params);
		if(null !=car && car.size()>0){
			throw new RuntimeException("该商品车已存在，请检查");
		}
				
		Date time=new Date();
		//插入表carStock
		bean.setVin(CommonUtil.getPYIndexStr(bean.getBrand(), true)+"-"+bean.getVin());//首字母大写+前台数据
		bean.setStockId(Integer.parseInt(stockId));
		bean.setStatus(Constants.CarStatus.NEW);//新建
		bean.setInsertTime(time);
		bean.setInsertUser(oper);
		bean.setUpdateTime(time);
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		carStockMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="库存管理：获取商品车信息")
	public List<CarStock> getCarListData(Map<String, Object> params) throws Exception {
		return carStockMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="库存管理：获取商品车信息")
	public Pager<CarStock> getPageData(Map<String, Object> params) throws Exception {
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
		
		List<CarStock> list = carStockMapper.getPageList(params);
		int totalCount = carStockMapper.getPageTotalCount(params);
		if(null != list && list.size() > 0)
		{
			for(int i = 0;i<list.size();i++)
			{
				if(null != list.get(i))
				{
					if(null != list.get(i).getStockId())
					{
						Stock s = stockMapper.getById(list.get(i).getStockId());
						if(null != s)
						{
							String stockName = s.getName();
							list.get(i).setStockName(stockName);
						}
					}
				}
				
			}
		}
		
		Pager<CarStock> pager = new Pager<CarStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="调度管理：获取商品车信息")
	public Pager<CarStock> getCarList(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		//获取状态为：1,2,3的调度单明细的car_stock_ids：不显示
		String carIdNot="";
		Map<String, Object> paramsSch = new HashMap<String, Object>();
		paramsSch.put("delFlag", Constants.DelFlag.N);
		paramsSch.put("statusIn", Constants.ScheduleBillStatus.UNSURE+","+Constants.ScheduleBillStatus.UNSURE_DRIVER);
		paramsSch.put("type", Constants.ScheduleBillDetailType.SPC+","+Constants.ScheduleBillDetailType.ESC);
		List<ScheduleBillDetail> schDetail = scheduleBillDetailMapper.getByConditions(paramsSch);
		if(null != schDetail && schDetail.size()>0){
			for(int i=0;i<schDetail.size();i++){
				if(null != schDetail.get(i).getCarStockIds() && !"".equals(schDetail.get(i).getCarStockIds()))
				{
					carIdNot+=schDetail.get(i).getCarStockIds()+",";
				}
			}
			carIdNot = carIdNot.substring(0,carIdNot.length()-1);
			params.put("carIdNot", carIdNot);
		}
		
		params.put("delFlag", Constants.DelFlag.N);
		
		List<CarStock> list = carStockMapper.getPageList(params);
		int totalCount = carStockMapper.getPageTotalCount(params);
		
		
		if(null != list && list.size()>0){
			//获取状态为：0的调度单的单号
			paramsSch.put("statusIn", Constants.ScheduleBillStatus.NEW);
			List<ScheduleBillDetail> schDetail2 = scheduleBillDetailMapper.getByConditions(paramsSch);
			if(null != schDetail2 && schDetail2.size()>0){
				
				for(int i=0;i<list.size();i++){
					CarStock carStock = list.get(i);
					
					for(int j=0;j<schDetail2.size();j++){
						ScheduleBillDetail detail = schDetail2.get(j);
						if(detail.getCarStockIds().contains(String.valueOf(carStock.getId()))){
							carStock.setScheduleBillNo(detail.getScheduleBillNo());
							break;
						}
					}
				}//for(int i=0;i<list.size();i++){
				
			}
		}
		
		Pager<CarStock> pager = new Pager<CarStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="根据id获取商品车信息")
	public CarStock getById(Integer id) throws Exception {
		return carStockMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新商品车信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(CarStock bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("商品车信息为空");
		}
		
		//验证该商品车是否已经存在
		/*Map<String, Object> params = new HashMap<String, Object>();
		params.put("vin", bean.getVin());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarStock> car = carStockMapper.getByConditions(params);
		
		if(null !=car && car.size()>0 && (int)car.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该商品车已存在，请检查");
		}*/
		
		CarStock carStock = carStockMapper.getById(bean.getId());
		if(null ==carStock){
			throw new RuntimeException("该id的商品车信息不存在");
		}else{
			//更新表carStock
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			carStockMapper.update(bean);
		}
	
	}

	@Override
	@SystemServiceLog(description="删除商品车信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		
		//更新表carStock的删除标志
		params.put("id", id);
		carStockMapper.updateById(params);		
	}

	@Override
	@SystemServiceLog(description="获取商品车出入库信息")
	public Pager<CarStockInOut> getCarInOutListData(Map<String, Object> params) throws Exception {
		
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
		List<CarStockInOut> list = new ArrayList<CarStockInOut>();
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
						
						list = carStockInOutMapper.getPageList(params);
						if(null != list && list.size() > 0)
						{
							for(int i = 0;i<list.size();i++)
							{
								//String type = list.get(i).getType();
								if("0".equals(type))//入库
								{
									int businessId = list.get(i).getBusinessId();
									String businessNo = waybillMapper.getById(businessId).getWaybillNo();
									list.get(i).setBusinessNo(businessNo);
								}
								if("1".equals(type))//出库
								{
									int businessId = list.get(i).getBusinessId();
									String businessNo = scheduleBillMapper.getById(businessId).getScheduleBillNo();
									list.get(i).setBusinessNo(businessNo);
								}
								
							}
						}
						totalCount = carStockInOutMapper.getPageTotalCount(params);
						
					}
					/*else
					{
						params.put("businessId", 0);//随便写个    不会出现的id
					}*/
				}
				if("1".equals(type))//出库
				{
					
					if(null != scheduleBillMapper.getByBillNo(businessNo2))
					{
						params.put("businessId", scheduleBillMapper.getByBillNo(businessNo2).getId());
						
						 list = carStockInOutMapper.getPageList(params);
						if(null != list && list.size() > 0)
						{
							for(int i = 0;i<list.size();i++)
							{
								//String type = list.get(i).getType();
								if("0".equals(type))//入库
								{
									int businessId = list.get(i).getBusinessId();
									String businessNo = waybillMapper.getById(businessId).getWaybillNo();
									list.get(i).setBusinessNo(businessNo);
								}
								if("1".equals(type))//出库
								{
									int businessId = list.get(i).getBusinessId();
									String businessNo = scheduleBillMapper.getById(businessId).getScheduleBillNo();
									list.get(i).setBusinessNo(businessNo);
								}
								
							}
						}
						totalCount = carStockInOutMapper.getPageTotalCount(params);
					}
				}
			}
			else
			{
				list = carStockInOutMapper.getPageList(params);
				if(null != list && list.size() > 0)
				{
					for(int i = 0;i<list.size();i++)
					{
						//String type = list.get(i).getType();
						if("0".equals(type))//入库
						{
							int businessId = list.get(i).getBusinessId();
							String businessNo = waybillMapper.getById(businessId).getWaybillNo();
							list.get(i).setBusinessNo(businessNo);
						}
						if("1".equals(type))//出库
						{
							int businessId = list.get(i).getBusinessId();
							String businessNo = scheduleBillMapper.getById(businessId).getScheduleBillNo();
							list.get(i).setBusinessNo(businessNo);
						}
						
					}
				}
				totalCount = carStockInOutMapper.getPageTotalCount(params);
			}
		}
		
		Pager<CarStockInOut> pager = new Pager<CarStockInOut>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
		
	}

	@Override
	@SystemServiceLog(description="商品车出入库明细查看")
	public Pager<CarStockInOutDetail> getCarInOutListDetail(
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
		List<CarStockInOutDetail> list = carStockInOutDetailMapper.getDetailByParentId(params);
		int totalCount = carStockInOutDetailMapper.getPageTotalCount(params);
		Pager<CarStockInOutDetail> pager = new Pager<CarStockInOutDetail>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		return pager;
	}

	
	
	@Override
	@SystemServiceLog(description="取消绑定的商品车")
	public int cancelBindCarStock(int id) throws Exception {
		
		return carStockMapper.cancelBindCarStock(id);
	}

//	@Override
//	@SystemServiceLog(description="提交商品车入库信息")
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
//	public void submit(Integer waybillId, String oper) throws Exception {
//		
//		//查询商品车
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("waybillId", waybillId);
//		params.put("status", Constants.CarStatus.NEW);//新建
//		params.put("delFlag", Constants.DelFlag.N);
//		List<CarStock> list = carStockMapper.getByConditions(params);
//		
//		if(null !=list && list.size()>0){
//			
//			Date time = new Date();
//			
//			//插入表carStockInOut
//			CarStockInOut carStockInOut = new CarStockInOut();
//			carStockInOut.setType(Constants.CarType.IN);//入库
//			carStockInOut.setStockId(list.get(0).getStockId());
//			carStockInOut.setBusinessId(waybillId);
//			carStockInOut.setCount(list.size());
//			carStockInOut.setStatus(Constants.CarInOutStatus.UNREVIEW);//1待审核
//			carStockInOut.setInsertTime(time);
//			carStockInOut.setInsertUser(oper);
//			carStockInOut.setUpdateTime(time);
//			carStockInOut.setUpdateUser(oper);
//			carStockInOut.setDelFlag(Constants.DelFlag.N);
//			carStockInOutMapper.insert(carStockInOut);
//			
//			//插入表carStockInOutDetail
//			for(int i=0; i<list.size(); i++){
//				CarStock bean = list.get(i);
//				
//				CarStockInOutDetail detail = new CarStockInOutDetail();
//				detail.setParentId(carStockInOut.getId());//carStockInOut的id
//				detail.setBusinessId(waybillId);
//				detail.setStockId(bean.getStockId());
//				detail.setType(Constants.WaibillType.SPC);//0商品车
//				detail.setWaybillId(waybillId);
//				detail.setBrand(bean.getBrand());
//				detail.setVin(bean.getVin());
//				detail.setModel(bean.getModel());
//				detail.setColor(bean.getColor());
//				detail.setEngineNo(bean.getEngineNo());
//				detail.setPosition(bean.getPosition());
//				detail.setKeyPosition(bean.getKeyPosition());
//				detail.setMark(bean.getMark());
//				detail.setInsertTime(time);
//				detail.setInsertUser(oper);
//				detail.setUpdateTime(time);
//				detail.setUpdateUser(oper);
//				detail.setDelFlag(Constants.DelFlag.N);
//				carStockInOutDetailMapper.insert(detail);
//			}
//			
//		}
//		
//	}

	@Override
	@SystemServiceLog(description="商品车入库审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void verifySuccess(Integer waybillId, String oper) throws Exception {
		
		//更新商品车库存表状态为1已入库
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("waybillId", waybillId);
		params.put("status", Constants.CarStatus.HASIN);//1已入库
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		carStockMapper.updateByWaybillId(params);
				
		//查询商品车
		params = new HashMap<String, Object>();
		params.put("waybillId", waybillId);
		params.put("delFlag", Constants.DelFlag.N);
		List<CarStock> list = carStockMapper.getByConditions(params);
		if(null !=list && list.size()>0){
			Date time = new Date();
			//插入表carStockInOut
			CarStockInOut carStockInOut = new CarStockInOut();
			carStockInOut.setType(Constants.CarType.IN);//入库
			carStockInOut.setStockId(list.get(0).getStockId());
			carStockInOut.setBusinessId(waybillId);
			carStockInOut.setCount(list.size());
			carStockInOut.setStatus(Constants.CarInOutStatus.FINISH);//已完成
			carStockInOut.setInsertTime(time);
			carStockInOut.setInsertUser(oper);
			carStockInOut.setUpdateTime(time);
			carStockInOut.setUpdateUser(oper);
			carStockInOut.setDelFlag(Constants.DelFlag.N);
			carStockInOutMapper.insert(carStockInOut);
			
			//插入表carStockInOutDetail
			for(int i=0; i<list.size(); i++){
				CarStock bean = list.get(i);
				
				CarStockInOutDetail detail = new CarStockInOutDetail();
				detail.setParentId(carStockInOut.getId());//carStockInOut的id
				detail.setBusinessId(waybillId);
				detail.setStockId(bean.getStockId());
				detail.setType(Constants.WaybillType.SPC);//0商品车
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
				carStockInOutDetailMapper.insert(detail);
			}
			
		}
			
	}

//	@Override
//	@SystemServiceLog(description="商品车入库审核不通过")
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
//	public void verifyFail(Integer waybillId, String oper) throws Exception {
//		
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("businessId", waybillId);
//		params.put("updateTime", new Date());
//		params.put("updateUser", oper);
//		params.put("delFlag", Constants.DelFlag.Y);
//		
//		//删除carStockInOut中数据--更新删除标志
//		carStockInOutMapper.updateByBusinessId(params);
//		
//		//删除carStockInOutDetail中数据--更新删除标志
//		carStockInOutDetailMapper.updateByBusinessId(params);
//	}

//	@Override
//	@SystemServiceLog(description="提交商品车出库信息")
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
//	public void carOutSubmit(String scheduleBillNo, String oper)
//			throws Exception {
//		//逻辑：插入记录到商品车出入库表、出入库明细表
//		
//		ScheduleBill bean = scheduleBillMapper.getByBillNo(scheduleBillNo);
//		List<ScheduleBillDetail> detail = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
//		User user = userMapper.getById(Integer.parseInt(oper));
//		
//		Date time = new Date();
//		//插入表carStockInOut
//		CarStockInOut carStockInOut = new CarStockInOut();
//		carStockInOut.setType(Constants.CarType.OUT);//出库
//		carStockInOut.setStockId(Integer.parseInt(user.getStockId()));
//		carStockInOut.setBusinessId(bean.getId());//调度id
//		carStockInOut.setCount(detail.size());
//		carStockInOut.setStatus(Constants.CarInOutStatus.UNREVIEW);//1待审核
//		carStockInOut.setInsertTime(time);
//		carStockInOut.setInsertUser(oper);
//		carStockInOut.setUpdateTime(time);
//		carStockInOut.setUpdateUser(oper);
//		carStockInOut.setDelFlag(Constants.DelFlag.N);
//		carStockInOutMapper.insert(carStockInOut);
//		
//		int parentId = carStockInOut.getId();
//		if(null != detail && detail.size()>0){
//			for(int i=0; i<detail.size(); i++){
//				
//				String carStockIds = detail.get(i).getCarStockIds();
//				
//				if(carStockIds.equals("") || null ==carStockIds ){
//					throw new RuntimeException("该调度单不存在商品车，不可提交");
//				}else{
//					//插入表carStockInOutDetail
//					Map<String, Object> ioDeParams = new HashMap<String, Object>();
//					ioDeParams.put("parentId", parentId);
//					ioDeParams.put("businessId", detail.get(i).getId());//调度详细id
//					ioDeParams.put("stockId", user.getStockId());
//					ioDeParams.put("type", Constants.CarType.OUT);//出库
//					ioDeParams.put("insertTime", time);
//					ioDeParams.put("insertUser", oper);
//					ioDeParams.put("updateTime", time);
//					ioDeParams.put("updateUser", oper);
//					ioDeParams.put("delFlag", Constants.DelFlag.N);
//					ioDeParams.put("carStockIds", carStockIds);
//
//					carStockInOutDetailMapper.insertByParams(ioDeParams);
//				}
//
//			}
//			
//		}
//		
//	}

	@Override
	@SystemServiceLog(description="商品车出库审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void carOutVerifySuccess(String scheduleBillNo, String oper)
			throws Exception {
		
		//逻辑：插入记录到商品车出入库表、出入库明细表
		ScheduleBill bean = scheduleBillMapper.getByBillNo(scheduleBillNo);
		List<ScheduleBillDetail> detail = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
		User user = userMapper.getById(Integer.parseInt(oper));
		
		Date time = new Date();
		//插入表carStockInOut
		CarStockInOut carStockInOut = new CarStockInOut();
		carStockInOut.setType(Constants.CarType.OUT);//出库
		carStockInOut.setStockId(Integer.parseInt(user.getStockId()));
		carStockInOut.setBusinessId(bean.getId());//调度id
		carStockInOut.setCount(detail.size());
		carStockInOut.setStatus(Constants.CarInOutStatus.FINISH);//已完成
		carStockInOut.setInsertTime(time);
		carStockInOut.setInsertUser(oper);
		carStockInOut.setUpdateTime(time);
		carStockInOut.setUpdateUser(oper);
		carStockInOut.setDelFlag(Constants.DelFlag.N);
		carStockInOutMapper.insert(carStockInOut);
		
		int parentId = carStockInOut.getId();
		if(null != detail && detail.size()>0){
			for(int i=0; i<detail.size(); i++){
				
				String carStockIds = detail.get(i).getCarStockIds();
				
				if(carStockIds.equals("") || null ==carStockIds ){
					throw new RuntimeException("该调度单不存在商品车，不可提交");
				}else{
					//插入表carStockInOutDetail
					Map<String, Object> ioDeParams = new HashMap<String, Object>();
					ioDeParams.put("parentId", parentId);
					ioDeParams.put("businessId", detail.get(i).getId());//调度详细id
					ioDeParams.put("stockId", user.getStockId());
					ioDeParams.put("type", Constants.CarType.OUT);//出库
					ioDeParams.put("insertTime", time);
					ioDeParams.put("insertUser", oper);
					ioDeParams.put("updateTime", time);
					ioDeParams.put("updateUser", oper);
					ioDeParams.put("delFlag", Constants.DelFlag.N);
					ioDeParams.put("carStockIds", carStockIds);

					carStockInOutDetailMapper.insertByParams(ioDeParams);
				}

			}
			
		}
				
		//逻辑：更新商品车出入库表状态、商品车库存状态(已出库)、插入数据到商品车出库单表
		Map<String, Object> params = new HashMap<String, Object>();
		if(null != detail && detail.size()>0){
			for(int i=0; i<detail.size(); i++){
				
				String carStockIds = detail.get(i).getCarStockIds();
				//判断该商品车的状态：必须是1已入库N未出库
				String[] idArr = carStockIds.split(",");
				if(idArr.length>0) {
					for(int j=0; j<idArr.length; j++){
						CarStock carStock = carStockMapper.getById(Integer.parseInt(idArr[j]));
						if(!carStock.getStatus().equals(Constants.CarStatus.HASIN) || carStock.getDelFlag().equals(Constants.DelFlag.Y)){
							throw new RuntimeException("商品车"+carStock.getVin()+"未入库或已出库，请检查");
						}
					}
				}
				
				params.put("id", carStockIds);
				params.put("status", Constants.CarStatus.HASOUT);//已出库
				params.put("updateTime", new Date());
				params.put("updateUser", oper);
				//更新表carStock
				carStockMapper.updateById(params);
				
				//String carShopId = detail.get(i).getCarShopId().toString();
				String type;
				if(detail.get(i).getCarShopId()!=null){
					type = Constants.CarOutStockBillType.SPC;//商品车
				}else{
					type = Constants.CarOutStockBillType.ESC;//二手车
				}
				
				//插入表carOutStockBill
				Map<String, Object> outParams = new HashMap<String, Object>();
				outParams.put("stockId", user.getStockId());
				outParams.put("scheduleBillId", bean.getId());
				outParams.put("scheduleBillDetailId", detail.get(i).getId());
				outParams.put("type", type);
				outParams.put("insertTime", new Date());
				outParams.put("insertUser", oper);
				outParams.put("carStockIds", carStockIds);

				carOutStockBillMapper.insertByParams(outParams);
			}
		}	
		
	}

//	@Override
//	@SystemServiceLog(description="商品车出库审核不通过")
//	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
//	public void carOutVerifyFail(String scheduleBillNo, String oper)
//			throws Exception {
//		//逻辑：删除商品车出入库表、出入库明细表(更新删除标记)
//		
//		ScheduleBill bean = scheduleBillMapper.getByBillNo(scheduleBillNo);
//		List<ScheduleBillDetail> detail = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
//		
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("businessId", bean.getId());
//		params.put("updateTime", new Date());
//		params.put("updateUser", oper);
//		params.put("delFlag", Constants.DelFlag.Y);
//		
//		//删除carStockInOut中数据--更新删除标志
//		carStockInOutMapper.updateByBusinessId(params);
//		
//		if(null != detail && detail.size()>0){
//			for(int i=0; i<detail.size(); i++){
//				
//				//删除carStockInOutDetail中数据--更新删除标志
//				params.put("businessId", detail.get(i).getId());
//				carStockInOutDetailMapper.updateByBusinessId(params);
//			}
//		}
//		
//	}

	@Override
	public List<CarStock> getCarListForScheduleBillNo(String scheduleBillNo)
			throws Exception {
		List<CarStock> list = new ArrayList<CarStock>();
		List<ScheduleBillDetail> detail = scheduleBillDetailMapper.getByBillNo(scheduleBillNo);
		if(null != detail && detail.size()>0){
			for(int i=0; i<detail.size(); i++){
				String carStockIds = detail.get(i).getCarStockIds();
				String[] idArr = carStockIds.split(",");
				if(idArr.length>0) {
					for(int j=0; j<idArr.length; j++){
						CarStock carStock = carStockMapper.getById(Integer.parseInt(idArr[j]));
						CarShop carShop = carShopMapper.getById(detail.get(i).getCarShopId());
						if( null != carShop ){
							carStock.setCarShopName( carShop.getName() );
						}else{
							carStock.setCarShopName( "" );
						}
						list.add(carStock);
						
					}
				}
				
			}
		}	
		
		return list;
	}

	
}
