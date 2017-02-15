package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.ScheduleBillMapper;
import com.jshpsoft.dao.ScheduleTrackChangeApplyMapper;
import com.jshpsoft.domain.ScheduleBill;
import com.jshpsoft.domain.ScheduleTrackChangeApply;
import com.jshpsoft.service.TrackChangeMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("trackChangeMngService")
public class TrackChangeMngServiceImpl implements TrackChangeMngService {
	
	@Autowired
	private ScheduleTrackChangeApplyMapper scheduleTrackChangeApplyMapper;
	
	@Autowired
	private ScheduleBillMapper scheduleBillMapper;
	
	@Autowired
	private CommonService commonService;

	@Override
	@SystemServiceLog(description="获取换车申请信息")
	public Pager<ScheduleTrackChangeApply> getPageData(Map<String, Object> params) throws Exception {
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
		List<ScheduleTrackChangeApply> list = scheduleTrackChangeApplyMapper.getPageList(params);
		int totalCount = scheduleTrackChangeApplyMapper.getPageTotalCount(params);
		
		Pager<ScheduleTrackChangeApply> pager = new Pager<ScheduleTrackChangeApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="获取调度单数据")
	public List<ScheduleBill> getSchBillNo(Map<String, Object> params)
			throws Exception {
		return scheduleBillMapper.getSchBillNo(params);
	}

	@Override
	@SystemServiceLog(description="保存换车申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(ScheduleTrackChangeApply bean, String oper)
			throws Exception {
		
		bean.setStatus(Constants.TrackChangeStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		scheduleTrackChangeApplyMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id查询换车申请明细")
	public ScheduleTrackChangeApply getById(Integer id) throws Exception {
		return  scheduleTrackChangeApplyMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="提交换车申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		
		ScheduleTrackChangeApply bean = scheduleTrackChangeApplyMapper.getById(id);
		bean.setStatus(Constants.TrackChangeStatus.UNREVIEW);//待审核
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		scheduleTrackChangeApplyMapper.update(bean);
		
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.HCSQD, 
				id, 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName(Constants.ProcessType.HCSQD, "")
				);
	}

	@Override
	@SystemServiceLog(description="更新换车申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(ScheduleTrackChangeApply bean, String oper)
			throws Exception {
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		scheduleTrackChangeApplyMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除换车申请")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		
		ScheduleTrackChangeApply bean = scheduleTrackChangeApplyMapper.getById(id);
		
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.Y);//删除标记
		scheduleTrackChangeApplyMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="换车申请审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Map<String, Object> params, String oper)
			throws Exception {
		ScheduleTrackChangeApply bean = scheduleTrackChangeApplyMapper.getById(Integer.parseInt(String.valueOf(params.get("id"))));
		
		//更新换车申请表
		if( null != params.get("newCarNumber") ){
			String newCarNumber = params.get("newCarNumber").toString();
			if( StringUtils.isNotEmpty( newCarNumber ) ){
				bean.setNewCarNumber(newCarNumber);
			}
		}
		if( null != params.get("newDriverId") ){
			String newDriver = params.get("newDriverId").toString();
			if( StringUtils.isNotEmpty( newDriver ) ){
				bean.setNewDriverId(Integer.valueOf(newDriver));
			}
		}
		bean.setStatus( String.valueOf(params.get("status")) );//审核通过
		scheduleTrackChangeApplyMapper.update(bean);
		
//		if( !( null == bean.getNewDriverId() && null == bean.getNewCarNumber() ) ){
//			//更新调度单中的驾驶员、车牌号
//			Map<String, Object> paramsNew = new HashMap<String, Object>();
//			paramsNew.put("scheduleBillNo", bean.getScheduleBillNo());
//			paramsNew.put("driverId", bean.getNewDriverId() );
//			paramsNew.put("carNumber", bean.getNewCarNumber() );
//			scheduleBillMapper.updateByBillNo(paramsNew);
//			
//		}
		
	}

	@Override
	@SystemServiceLog(description="换车申请审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Map<String, Object> params, String oper)
			throws Exception {
		ScheduleTrackChangeApply bean = scheduleTrackChangeApplyMapper.getById(Integer.parseInt(String.valueOf(params.get("id"))));
		bean.setStatus( String.valueOf(params.get("status")) );//审核不通过
		scheduleTrackChangeApplyMapper.update(bean);
	}

	@Override
	public void auditForConfirm(Map<String, Object> params, String oper) throws Exception {
		ScheduleTrackChangeApply bean = scheduleTrackChangeApplyMapper.getById( Integer.parseInt(String.valueOf(params.get("id"))) );
		bean.setStatus( String.valueOf(params.get("status")) );
		bean.setUpdateTime( new Date() );
		bean.setUpdateUser( oper );
		if( null != params.get("newCarNumber") ){
			String newCarNumber = params.get("newCarNumber").toString();
			if( StringUtils.isNotEmpty( newCarNumber ) ){
				bean.setNewCarNumber(newCarNumber);
			}
		}
		if( null != params.get("newDriverId") ){
			String newDriver = params.get("newDriverId").toString();
			if( StringUtils.isNotEmpty( newDriver ) ){
				bean.setNewDriverId(Integer.valueOf(newDriver));
			}
		}
		scheduleTrackChangeApplyMapper.update(bean);
		
	}
	
}
