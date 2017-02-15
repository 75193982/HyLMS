package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.TrackTyreChangeApplyMapper;
import com.jshpsoft.dao.TrackTyreStockMapper;
import com.jshpsoft.domain.TrackTyreChangeApply;
import com.jshpsoft.service.TrackTyreChangeMngService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("trackTyreChangeMngService")
public class TrackTyreChangeMngServiceImpl implements TrackTyreChangeMngService {
	
	@Autowired
	private TrackTyreChangeApplyMapper trackTyreChangeApplyMapper;
	
	@Autowired
	private TrackTyreStockMapper trackTyreStockMapper;
	
	@Autowired
	private CommonService commonService;

	@Override
	@SystemServiceLog(description="获取轮胎更换信息")
	public List<TrackTyreChangeApply> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return trackTyreChangeApplyMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="获取轮胎更换信息")
	public Pager<TrackTyreChangeApply> getPageData(Map<String, Object> params)
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
		List<TrackTyreChangeApply> list = trackTyreChangeApplyMapper.getPageList(params);
		int totalCount = trackTyreChangeApplyMapper.getPageTotalCount(params);
		
		Pager<TrackTyreChangeApply> pager = new Pager<TrackTyreChangeApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增轮胎更换信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TrackTyreChangeApply bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("轮胎更换信息为空");
		}
		
		//插入轮胎更换表
		bean.setStatus(Constants.TrackTyreChangeStatus.NEW);//0新建
		bean.setApplyTime(new Date());
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		trackTyreChangeApplyMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取轮胎更换信息")
	public TrackTyreChangeApply getById(Integer id) throws Exception {
		return trackTyreChangeApplyMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新轮胎更换信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TrackTyreChangeApply bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("轮胎更换信息为空");
		}
		
		//更新轮胎更换表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		trackTyreChangeApplyMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="上传轮胎照片")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateTyrePic(Map<String, Object> params,HttpServletRequest req) throws Exception {
		
		//发票附件路径
		String oldTyrePic = String.valueOf( params.get("oldTyrePic") );
		if(!oldTyrePic.equals("")){
			String newOldTyrePic = commonService.reStoreFile( Constants.UploadType.TYRECHANGE, oldTyrePic , req);
			params.put("oldTyrePic", newOldTyrePic);
		}

		//保单路径
		String newTyrePic = String.valueOf( params.get("newTyrePic") );
		if(!newTyrePic.equals("")){
			String newNewTyrePic = commonService.reStoreFile( Constants.UploadType.TYRECHANGE, newTyrePic , req);
			params.put("newTyrePic", newNewTyrePic);
		}
		
		trackTyreChangeApplyMapper.updateById(params);
	}
	
	@Override
	@SystemServiceLog(description="删除轮胎更换信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		trackTyreChangeApplyMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="提交轮胎更换信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", Constants.TrackTyreChangeStatus.UNREVIEW);//待复核
		trackTyreChangeApplyMapper.updateById(params);
		
		TrackTyreChangeApply bean = trackTyreChangeApplyMapper.getById(id);
		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.LTGHSQD, 
				id, 
				Integer.parseInt( oper ), 
				CommonUtil.getProcessName(Constants.ProcessType.LTGHSQD, bean.getCarNumber())
				);
	}

	@Override
	@SystemServiceLog(description="轮胎更换信息审核通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditSuccess(Integer id, String status, String oper)
			throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", status);
		//更新轮胎更换表状态
		trackTyreChangeApplyMapper.updateById(params);
		
		//更新旧、新轮胎的各自状态
		TrackTyreChangeApply bean = trackTyreChangeApplyMapper.getById(id);
		
		Map<String, Object> paramsOld = new HashMap<String, Object>();
		paramsOld.put("tyreNo", bean.getOldTyreNo());//旧轮胎编号
		//paramsOld.put("carOld", "Y");//货运车号
		paramsOld.put("status", Constants.TrackTyreStatus.ZUOFEI);//作废
		trackTyreStockMapper.updateByTyreNo(paramsOld);
		
		Map<String, Object> paramsNew = new HashMap<String, Object>();
		paramsNew.put("tyreNo", bean.getNewTyreNo());//新轮胎编号
		paramsNew.put("carNumber", bean.getCarNumber());//货运车号
		paramsNew.put("status", Constants.TrackTyreStatus.USED);//使用中
		trackTyreStockMapper.updateByTyreNo(paramsNew);
	}

	@Override
	@SystemServiceLog(description="轮胎更换信息审核不通过")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditFail(Integer id, String status, String oper)
			throws Exception {
		auditForConfirm(id, status, oper);
	}

	@Override
	public void auditForConfirm(Integer id, String status, String oper)
			throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", status);
		trackTyreChangeApplyMapper.updateById(params);
	}
	
}
