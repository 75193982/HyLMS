package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarDamageCostApplyMapper;
import com.jshpsoft.dao.CarDamageFeedbackMapper;
import com.jshpsoft.dao.CarShopMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.CarDamageFeedback;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.CarDamageFeedbackMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("carDamageFeedbackMngService")
public class CarDamageFeedbackMngServiceImpl implements CarDamageFeedbackMngService {
	
	@Autowired
	private CarDamageFeedbackMapper carDamageFeedbackMapper;
	
	@Autowired
	private CarShopMapper carShopMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CarDamageCostApplyMapper carDamageCostApplyMapper;
	
	@Override
	@SystemServiceLog(description="获取列表信息")
	public Pager<CarDamageFeedback> getPageData(Map<String, Object> params)
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
		List<CarDamageFeedback> list = carDamageFeedbackMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				CarDamageFeedback detail = list.get(i);
				//4s店名称
				CarShop carShop = carShopMapper.getById(detail.getCarShopId());
				if( null != carShop ){
					list.get(i).setCarShopName(carShop.getName());
				}
				//插入人
				if( null != detail.getInsertUser() ){
					User user = userMapper.getById( Integer.parseInt(detail.getInsertUser()) );
					if( null != user ){
						list.get(i).setInsertUserName(user.getName());
					}
					
				}
				
			}
		}
		int totalCount = carDamageFeedbackMapper.getPageTotalCount(params);
		
		Pager<CarDamageFeedback> pager = new Pager<CarDamageFeedback>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(CarDamageFeedback bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("信息为空");
		}
		
		//插入数据到收支表
		bean.setStatus(Constants.CarDamageFeedbackStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		carDamageFeedbackMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取收支信息")
	public CarDamageFeedback getById(Integer id) throws Exception {
		CarDamageFeedback bean = carDamageFeedbackMapper.getById(id);
		//4s店名称
		CarShop carShop = carShopMapper.getById(bean.getCarShopId());
		if( null != carShop ){
			bean.setCarShopName(carShop.getName());
		}
		//插入人
		if( null != bean.getInsertUser() ){
			User user = userMapper.getById( Integer.parseInt(bean.getInsertUser()) );
			if( null != user ){
				bean.setInsertUserName(user.getName());
			}
			
		}
		
		return bean;
	}
	
	@Override
	@SystemServiceLog(description="更新收支信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(CarDamageFeedback bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("收支信息为空");
		}
		
		//更新表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		carDamageFeedbackMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除收支信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		CarDamageFeedback bean = carDamageFeedbackMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("折损反馈信息不存在！");
		}
		
		bean.setUpdateTime( new Date() );
		bean.setDelFlag( Constants.DelFlag.Y );
		bean.setUpdateUser(oper);
		carDamageFeedbackMapper.update(bean);
		
	}

	@Override
	public void submit(Integer detailId, String oper) throws Exception {
		CarDamageFeedback bean = carDamageFeedbackMapper.getById(detailId);
		if( null == bean ){
			throw new RuntimeException("折损反馈信息不存在！");
		}
		bean.setUpdateTime( new Date() );
		bean.setUpdateUser(oper);
		bean.setStatus(Constants.CarDamageFeedbackStatus.CONFIRM);
		carDamageFeedbackMapper.update(bean);
		
		//添加到流程中
		String name = "";
		if( null != bean.getTransportTime() ){
			name = CommonUtil.format( bean.getTransportTime(), Constants.DATE_TIME_FORMAT_SHORT ); 
			
		}
		//流程自动缩短，根据插入人是否是流程节点中的人
		commonService.addToProcessForZSFYSQ( 
				Constants.ProcessType.ZSFKSQD, 
				detailId, 
				Integer.parseInt(oper), 
				CommonUtil.getProcessName(Constants.ProcessType.ZSFKSQD, name)
				);
		
	}

	@Override
	public void auditForConfirm(int detailId, int status, int oper)
			throws Exception {
		CarDamageFeedback bean = carDamageFeedbackMapper.getById(detailId);
		if( null == bean ){
			throw new RuntimeException("折损反馈信息不存在！");
		}
		bean.setUpdateTime( new Date() );
		bean.setUpdateUser(oper+"");
		bean.setStatus( status+"");
		carDamageFeedbackMapper.update(bean);
		
	}

}
