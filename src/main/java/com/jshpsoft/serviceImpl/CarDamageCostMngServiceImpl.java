package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarDamageCostApplyDetailMapper;
import com.jshpsoft.dao.CarDamageCostApplyMapper;
import com.jshpsoft.dao.CarDamageStockInOutDetailMapper;
import com.jshpsoft.dao.CarDamageStockInOutMapper;
import com.jshpsoft.dao.CarDamageStockMapper;
import com.jshpsoft.dao.CarShopMapper;
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.TrackInsuranceMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.CarDamageCostApply;
import com.jshpsoft.domain.CarDamageCostApplyDetail;
import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.CarDamageStockInOut;
import com.jshpsoft.domain.CarDamageStockInOutDetail;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.domain.User;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarDamageCostMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("carDamageCostMngService")
public class CarDamageCostMngServiceImpl implements CarDamageCostMngService {
	
	@Autowired
	private CarDamageCostApplyMapper carDamageCostApplyMapper;
	
	@Autowired
	private CarDamageCostApplyDetailMapper carDamageCostApplyDetailMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CarDamageStockInOutMapper carDamageStockInOutMapper;
	
	@Autowired
	private CarDamageStockInOutDetailMapper carDamageStockInOutDetailMapper;
	
	@Autowired
	private CarStockMapper carStockMapper;
	
	@Autowired
	private CarDamageStockMapper carDamageStockMapper;
	
	@Autowired
	private CarShopMapper carShopMapper;
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private TrackInsuranceMapper trackInsuranceMapper;
	
	@Autowired
	private CashInOutMapper cashInOutMapper;
	
	@Autowired
	private UserMapper userMapper;

	@Override
	@SystemServiceLog(description="获取折损费用申请信息")
	public Pager<CarDamageCostApply> getPageData(Map<String, Object> params)
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
		List<CarDamageCostApply> list = carDamageCostApplyMapper.getPageList(params);
		int totalCount = carDamageCostApplyMapper.getPageTotalCount(params);
		
		Pager<CarDamageCostApply> pager = new Pager<CarDamageCostApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增折损费用申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(CarDamageCostApply bean, String oper, HttpServletRequest req) throws Exception {
		if( null == bean ){
			throw new RuntimeException("折损费用申请信息为空");
		}
		
		List<CarDamageCostApplyDetail> detailList = bean.getDetailList();
		if( null == detailList){
			throw new RuntimeException("折损费用申请明细为空");
		}
		
		//插入折损费用申请主表
		bean.setStatus(Constants.CarDamageCostApplyStatus.NEW);//新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		
		//附件处理
		String attachFilePath = bean.getAttachFilePath();
		if( StringUtils.isNotEmpty(attachFilePath) ){
			String newFilePath = commonService.reStoreFileForBatch( Constants.UploadType.CAR_DAMAGE, attachFilePath , req);
			bean.setAttachFilePath( newFilePath );
		}
		carDamageCostApplyMapper.insert(bean);
		
		//插入明细表
		double amount = 0.0;
		if(null != detailList && detailList.size()>0 ){
			for(int i=0;i<detailList.size();i++){
				CarDamageCostApplyDetail detail = detailList.get(i);
				if( null == detail.getAmount() ){
					throw new RuntimeException("折损车辆价格为空");
				}
				detail.setParentId(bean.getId());
				detail.setInsertTime(new Date());
				detail.setInsertUser(oper);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				detail.setParentId(bean.getId());
				carDamageCostApplyDetailMapper.insert(detail);
				amount += CommonUtil.formatDouble(detail.getAmount().doubleValue());
			}
		}
		
		CarDamageCostApply newBean = carDamageCostApplyMapper.getById(bean.getId());
		newBean.setAmount( new BigDecimal( CommonUtil.formatDouble(amount) )  );
		carDamageCostApplyMapper.update(newBean);
		
	}

	@Override
	@SystemServiceLog(description="根据id获取折损费用申请信息")
	public CarDamageCostApply getById(Integer id) throws Exception {
		CarDamageCostApply bean = carDamageCostApplyMapper.getById(id);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentId", bean.getId());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarDamageCostApplyDetail> detailList = carDamageCostApplyDetailMapper.getByConditions(params);
		bean.setDetailList(detailList);
		if( null != detailList && detailList.size() > 0 ){
			List<CarStock> carStockList = new ArrayList<CarStock>();
			for(int i=0; i<detailList.size(); i++){
				CarDamageCostApplyDetail detail = detailList.get(i);
				CarStock carStock = carStockMapper.getById(detail.getCarStockId());
				if( null != carStock ){
					Waybill waybill = waybillMapper.getById(carStock.getWaybillId());
					if( null != waybill ){
						CarShop carShop = carShopMapper.getById(waybill.getCarShopId());
						if( null != carShop ){
							carStock.setCarShopName( carShop.getName() );
						}else{
							carStock.setCarShopName( "" );
						}
						
					}
					
				}
				carStockList.add(carStock);
			}
			bean.setCarStockList(carStockList);
		}

		return bean;
	}

	
	@Override
	@SystemServiceLog(description="更新折损费用申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(CarDamageCostApply bean, String oper, HttpServletRequest req) throws Exception {
		if( null == bean ){
			throw new RuntimeException("折损费用申请信息为空");
		}
		
		List<CarDamageCostApplyDetail> detailList = bean.getDetailList();
		if( null == detailList){
			throw new RuntimeException("折损费用申请明细为空");
		}
		
		//更新申请主表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		
		//附件处理
		CarDamageCostApply old = carDamageCostApplyMapper.getById(bean.getId());
		String attachFilePath = bean.getAttachFilePath();
		if( StringUtils.isNotEmpty(attachFilePath) && !attachFilePath.equals( old.getAttachFilePath() )){
			String newFilePath = commonService.reStoreFileForBatch( Constants.UploadType.CAR_DAMAGE, attachFilePath , req);
			bean.setAttachFilePath( newFilePath );
		}
		
		//根据parentId删除原先的明细
		carDamageCostApplyDetailMapper.deleteByParentId(bean.getId());
		
		//插入明细表
		double amount = 0.0;
		if(null != detailList && detailList.size()>0 ){
			for(int i=0;i<detailList.size();i++){
				CarDamageCostApplyDetail detail = detailList.get(i);
				if( null == detail.getAmount() ){
					throw new RuntimeException("折损车辆价格为空");
				}
				detail.setParentId(bean.getId());
				detail.setInsertTime(new Date());
				detail.setInsertUser(oper);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(oper);
				detail.setDelFlag(Constants.DelFlag.N);
				carDamageCostApplyDetailMapper.insert(detail);
				amount += CommonUtil.formatDouble(detail.getAmount().doubleValue());
			}
		}
		
		bean.setAmount( new BigDecimal( CommonUtil.formatDouble(amount) )  );
		carDamageCostApplyMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除折损费用申请信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void delete(Integer id, String oper) throws Exception {
		
		//更新申请主表
		CarDamageCostApply old = carDamageCostApplyMapper.getById(id);
		old.setUpdateTime( new Date() );
		old.setUpdateUser( oper );
		old.setDelFlag(Constants.DelFlag.Y);
		carDamageCostApplyMapper.update(old);
		
		//更新明细表
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("parentId", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		carDamageCostApplyDetailMapper.updateByParentId(params);
		
	}

	@Override
	@SystemServiceLog(description="提交折损费用申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		
		//更新申请主表
		CarDamageCostApply old = carDamageCostApplyMapper.getById(id);
		old.setUpdateTime( new Date() );
		old.setUpdateUser( oper );
		old.setStatus( Constants.CarDamageCostApplyStatus.VERIFY );//待审核
		carDamageCostApplyMapper.update(old);
				
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.ZSFYSQD, 
				id, 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName(Constants.ProcessType.ZSFYSQD, CommonUtil.getCustomDateToString(old.getInsertTime(), Constants.DATE_TIME_FORMAT_SHORT)  )
				);
	}

	@Override
	@SystemServiceLog(description="折损费用申请审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Integer id, String status, String oper) throws Exception {
		
		CarDamageCostApply old = carDamageCostApplyMapper.getById(id);
		old.setUpdateTime( new Date() );
		old.setUpdateUser( oper );
		old.setStatus( status );
		carDamageCostApplyMapper.update(old);
		
		//如果是买断，则做一个折损入库动作
		if( Constants.CarDamageCostType.BUY.equals( old.getType() ) ){
			//生成入库记录
			CarDamageStockInOut inOut = new CarDamageStockInOut();
			inOut.setDelFlag(Constants.DelFlag.N);
			inOut.setInsertTime(new Date());
			inOut.setInsertUser(oper);
			inOut.setUpdateTime(new Date());
			inOut.setUpdateUser(oper);
			inOut.setType(Constants.CashInOutType.IN);
			inOut.setStatus(Constants.CarDamageStockInOutStatus.FINISH);
			carDamageStockInOutMapper.save(inOut);
			
			//生成入库详细记录
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("parentId", old.getId());
			params.put("delFlag", Constants.DelFlag.N);
			List<CarDamageCostApplyDetail> detailList = carDamageCostApplyDetailMapper.getByConditions(params);
			if(null != detailList && detailList.size()>0 ){
				for(int i=0;i<detailList.size();i++){
					CarDamageCostApplyDetail oldDetail = detailList.get(i);
					CarStock carStock = carStockMapper.getById(oldDetail.getCarStockId());
					
					if( null != carStock ){
						CarDamageStockInOutDetail inOutDetail = new CarDamageStockInOutDetail();
						BeanUtils.copyProperties(inOutDetail, carStock);
						inOutDetail.setMark(null);
						inOutDetail.setDelFlag(Constants.DelFlag.N);
						inOutDetail.setInsertTime(new Date());
						inOutDetail.setInsertUser(oper);
						inOutDetail.setUpdateTime(new Date());
						inOutDetail.setUpdateUser(oper);
						inOutDetail.setParentId(inOut.getId());
						inOutDetail.setWaybillId(null);
						inOutDetail.setAmount(oldDetail.getAmount());
						carDamageStockInOutDetailMapper.save(inOutDetail);
						
						//生成折损库存
						CarDamageStock stock = new CarDamageStock();
						BeanUtils.copyProperties(stock, inOutDetail);
						stock.setMark(null);
						stock.setDelFlag(Constants.DelFlag.N);
						stock.setInsertTime(new Date());
						stock.setInsertUser(oper);
						stock.setUpdateTime(new Date());
						stock.setUpdateUser(oper);
						stock.setWaybillId(null);
						stock.setStatus(Constants.CarStatus.HASIN);
						stock.setInAmount(inOutDetail.getAmount());
						carDamageStockMapper.save(stock);
						
					}
				}
			}
			
		}
		
		//自动生成出险管理功能:
		if( "Y".equals(old.getInsuranceFlag()) ){
			TrackInsurance insurance = new TrackInsurance();
			insurance.setInsertTime(new Date());
			insurance.setInsertUser(oper+"");
			insurance.setUpdateTime(new Date());
			insurance.setUpdateUser(oper+"");
			insurance.setDelFlag(Constants.DelFlag.N);
			insurance.setCarDamageCostApplyId(old.getId());
			insurance.setStatus(Constants.InsuranceStatus.NEW);//新建
			insurance.setAmount( old.getAmount() );
			insurance.setType(Constants.InsuranceType.EXPENSE);
			ScheduleBill sb = scheduleBillMapper.getByBillNo(old.getScheduleBillNo());
			insurance.setCarNumber(sb.getCarNumber());
			insurance.setDriverId(sb.getDriverId());
			trackInsuranceMapper.insert(insurance);
			
		}
		
		//插入现金收支表-支出
		CashInOut cash = new CashInOut();
		User user = userMapper.getById( Integer.parseInt(old.getInsertUser()) );
		int departmentId = 0;
		if( null != user && null != user.getDepartmentId() ){
			departmentId = user.getDepartmentId();
		}
		cash.setDepartmentId( departmentId );
		cash.setBusinessType(Constants.CashInOutBusinessType.CarDamageCostApply);
		cash.setType(Constants.CashInOutType.OUT);
		cash.setDetailId(old.getId());
		cash.setMark("折损费用申请【调度单号-"+old.getScheduleBillNo()+"】");
		cash.setMoney( old.getAmount() != null ? old.getAmount().doubleValue() : 0 );
		cash.setDelFlag(Constants.DelFlag.N);
		cash.setInsertTime(new Date());
		cash.setInsertUser(oper);
		cash.setUpdateTime(new Date());
		cash.setUpdateUser(oper);
		cash.setStatus(Constants.CashInOutStatus.SUBMIT);
		cash.setSystemFlag(Constants.SystemFlag.Y);
		cashInOutMapper.insert(cash);
				
	}

	@Override
	@SystemServiceLog(description="折损费用申请审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Integer id, String status, String oper) throws Exception {
		 auditForConfirm(id, status, oper);
		
	}

	@Override
	@SystemServiceLog(description="折损费用申请状态更新")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditForConfirm(Integer id, String status, String oper)
			throws Exception {
		CarDamageCostApply old = carDamageCostApplyMapper.getById(id);
		old.setUpdateTime( new Date() );
		old.setUpdateUser( oper );
		old.setStatus( status );
		carDamageCostApplyMapper.update(old);
		
	}

	@Override
	@SystemServiceLog(description="获取折损费用申请信息")
	public List<CarDamageCostApply> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return carDamageCostApplyMapper.getByConditions(params);
	}
	
}
