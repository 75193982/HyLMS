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
import com.jshpsoft.dao.TrackMaintenanceApplyMapper;
import com.jshpsoft.dao.TrackMapper;
import com.jshpsoft.domain.TrackMaintenanceApply;
import com.jshpsoft.service.TrackMaintMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("trackMaintMngService")
public class TrackMaintMngServiceImpl implements TrackMaintMngService {
	
	@Autowired
	private TrackMaintenanceApplyMapper trackMaintenanceApplyMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private TrackMapper trackMapper;
	
	@Override
	@SystemServiceLog(description="获取维修保养记录信息")
	public Pager<TrackMaintenanceApply> getPageData(Map<String, Object> params)
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
		List<TrackMaintenanceApply> list = trackMaintenanceApplyMapper.getPageList(params);
		int totalCount = trackMaintenanceApplyMapper.getPageTotalCount(params);
		
		Pager<TrackMaintenanceApply> pager = new Pager<TrackMaintenanceApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增维修保养信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TrackMaintenanceApply bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("维修保养信息为空");
		}
		
		//插入数据到维修保养申请表
		bean.setStatus(Constants.TrackMaintStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		trackMaintenanceApplyMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取维修保养信息")
	public TrackMaintenanceApply getById(Integer id) throws Exception {
		return trackMaintenanceApplyMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新维修保养信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TrackMaintenanceApply bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("维修保养信息为空");
		}
		
		//更新维修保养申请表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		trackMaintenanceApplyMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除维修保养信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		trackMaintenanceApplyMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="提交维修保养信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", Constants.TrackMaintStatus.UNREVIEW);//1待复核
		trackMaintenanceApplyMapper.updateById(params);
		
		TrackMaintenanceApply bean = trackMaintenanceApplyMapper.getById(id);
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.WXBYSQD, 
				id, 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName(Constants.ProcessType.WXBYSQD, bean.getCarNumber())
				);
	}

	@Override
	@SystemServiceLog(description="维修保养信息审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Integer id, String status, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", status);
		//params.put("status", Constants.TrackMaintStatus.FINISH);//2已完成
		trackMaintenanceApplyMapper.updateById(params);
		
		//将运输车辆的 距上次保养公里数 清零
		Map<String, Object> paramsUp = new HashMap<String, Object>();
		String carNumber = trackMaintenanceApplyMapper.getById(id).getCarNumber();
		paramsUp.put("no", carNumber);
		paramsUp.put("clearFlag", "Y");
		trackMapper.updateByNo(paramsUp);
	}

	@Override
	@SystemServiceLog(description="维修保养信息审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Integer id, String status, String oper) throws Exception {
		
		auditForConfirm(id, status, oper);
		
	}
	
	@Override
	@SystemServiceLog(description="维修保养信息审核更新")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditForConfirm(Integer id, String status, String oper) throws Exception {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", status);
		trackMaintenanceApplyMapper.updateById(params);
	}

	@Override
	public List<TrackMaintenanceApply> getTrackMaintenanceApply(
			Map<String, Object> params) throws Exception {
		
		return trackMaintenanceApplyMapper.getTrackMaintenanceApply(params);
	}
	
}
