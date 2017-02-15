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
import com.jshpsoft.dao.TrackInsuranceMapper;
import com.jshpsoft.dao.TrackMapper;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.service.TrackService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("trackService")
public class TrackServiceImpl implements TrackService {
	
	@Autowired
	private TrackMapper trackMapper;
	
	@Autowired
	private TrackInsuranceMapper trackInsuranceMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Override
	@SystemServiceLog(description="查询运输车辆信息")
	public List<Track> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return trackMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询运输车辆列表信息")
	public Pager<Track> getPageData(Map<String, Object> params) throws Exception {
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
		List<Track> list = trackMapper.getPageList(params);
		//获取保险时间
		if(null != list && list.size()>0){
			for(int i=0;i<list.size();i++){
				Track track = list.get(i);
				Map<String, Object> paramsTrack = new HashMap<String, Object>();
				paramsTrack.put("type", Constants.InsuranceType.JOIN);
				paramsTrack.put("carNumber", track.getNo());
				paramsTrack.put("delFlag", Constants.DelFlag.N);
				paramsTrack.put("orderFlag", "Y");
				List<TrackInsurance> InsList = trackInsuranceMapper.getByConditions(paramsTrack);
				if(null != InsList && InsList.size()>0){
					track.setInsuranceStartTime(InsList.get(0).getStartTime());
					track.setInsuranceEndTime(InsList.get(0).getEndTime());
				}
				
			}
		}
		
		int totalCount = trackMapper.getPageTotalCount(params);
		
		Pager<Track> pager = new Pager<Track>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增运输车辆信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(Track bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("运输车辆信息为空");
		}
		
		//验证该运输车辆是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vin", bean.getVin());
		params.put("delFlag", Constants.DelFlag.N);
		List<Track> track = trackMapper.getByConditions(params);
		if(null !=track && track.size()>0){
			throw new RuntimeException("该运输车辆已存在，请检查");
		}
		
		//插入运输车辆表
		bean.setType("0");//类型 0
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		trackMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取运输车辆明细")
	public Track getById(Integer id) throws Exception {
		Track track = trackMapper.getById(id);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", Constants.InsuranceType.JOIN);
		params.put("carNumber", track.getNo());
		params.put("delFlag", Constants.DelFlag.N);
		params.put("orderFlag", "Y");
		List<TrackInsurance> InsList = trackInsuranceMapper.getByConditions(params);
		if(null != InsList && InsList.size()>0){
			track.setInsuranceStartTime(InsList.get(0).getStartTime());
			track.setInsuranceEndTime(InsList.get(0).getEndTime());
		}
		
		return track;
	}

	@Override
	@SystemServiceLog(description="更新运输车辆信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(Track bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("运输车辆信息为空");
		}
		
		//验证该运输车辆名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("vin", bean.getVin());
		params.put("delFlag", Constants.DelFlag.N);
		List<Track> track = trackMapper.getByConditions(params);
		if(null !=track && track.size()>0 && (int)track.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该运输车辆名称已存在，请检查");
		}
		
		//更新运输车辆数据
		bean.setType("0");//类型 0
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		trackMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除运输车辆信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		trackMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="上传")
	public void updateFilePath(Map<String, Object> params,
			HttpServletRequest request) throws Exception {
		
		if(null != params.get("drivingFilePath") && !"".equals(params.get("drivingFilePath")))
		{
			String drivingFilePath = String.valueOf( params.get("drivingFilePath") );
			String newFilePath = commonService.reStoreFile( Constants.UploadType.DRIVING, drivingFilePath , request);
			params.put("drivingFilePath", newFilePath);
		}
		
		if(null != params.get("toperatingFilePath") && !"".equals(params.get("toperatingFilePath")))
		{
			String toperatingFilePath = String.valueOf( params.get("toperatingFilePath") );
			String tnewFilePath = commonService.reStoreFile( Constants.UploadType.TOPERATING, toperatingFilePath , request);
			params.put("toperatingFilePath", tnewFilePath);
		}
		
		if(null != params.get("xoperatingFilePath") && !"".equals(params.get("xoperatingFilePath")))
		{
			String xoperatingFilePath = String.valueOf( params.get("xoperatingFilePath") );
			String xnewFilePath = commonService.reStoreFile( Constants.UploadType.XOPERATING, xoperatingFilePath , request);
			params.put("xoperatingFilePath", xnewFilePath);
		}
		
		trackMapper.updateById(params);
		
	}

	@Override
	public Track getByCarNumber(String carNumber) throws Exception {
		
		return trackMapper.getByCarNumber(carNumber);
	}

	@Override
	public List<TrackInsurance> getInsuranceList(String carNumber,String type)
			throws Exception {
		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("carNumber", carNumber);
		params.put("delFlag", Constants.DelFlag.N);
		params.put("type", type);
		params.put("descFlag", "desc");
		//params.put("nowDate", sdf.format(new Date()));//去掉查看所有险种
		List<TrackInsurance> list = trackInsuranceMapper.getByConditions(params);
		return list;
	}

	
}
