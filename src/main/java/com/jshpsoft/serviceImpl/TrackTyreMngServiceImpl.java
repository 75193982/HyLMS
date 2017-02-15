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
import com.jshpsoft.dao.TrackTyreStockMapper;
import com.jshpsoft.domain.TrackTyreStock;
import com.jshpsoft.service.TrackTyreMngService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("trackTyreMngService")
public class TrackTyreMngServiceImpl implements TrackTyreMngService {
	
	@Autowired
	private TrackTyreStockMapper trackTyreStockMapper;

	@Override
	@SystemServiceLog(description="获取轮胎信息")
	public List<TrackTyreStock> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return trackTyreStockMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="获取轮胎信息")
	public Pager<TrackTyreStock> getPageData(Map<String, Object> params)
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
		List<TrackTyreStock> list = trackTyreStockMapper.getPageList(params);
		int totalCount = trackTyreStockMapper.getPageTotalCount(params);
		
		Pager<TrackTyreStock> pager = new Pager<TrackTyreStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增轮胎信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TrackTyreStock bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("轮胎信息为空");
		}
		
		//验证该轮胎编号是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("tyreNo", bean.getTyreNo());
		params.put("delFlag", Constants.DelFlag.N);
		List<TrackTyreStock> trackTyre = trackTyreStockMapper.getByConditions(params);
		if(null !=trackTyre && trackTyre.size()>0){
			throw new RuntimeException(bean.getTyreNo()+"该轮胎编号已存在，请检查");
		}
		
		//插入轮胎库存表
		bean.setStatus(Constants.TrackTyreStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		trackTyreStockMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取轮胎信息")
	public TrackTyreStock getById(Integer id) throws Exception {
		return trackTyreStockMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新轮胎信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TrackTyreStock bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("轮胎信息为空");
		}
		
		//验证该轮胎编号是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("tyreNo", bean.getTyreNo());
		params.put("delFlag", Constants.DelFlag.N);
		List<TrackTyreStock> trackTyre = trackTyreStockMapper.getByConditions(params);
		if(null !=trackTyre && trackTyre.size()>0 && (int)trackTyre.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException(bean.getTyreNo()+"该轮胎编号已存在，请检查");
		}
		
		//更新轮胎库存表
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		trackTyreStockMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除轮胎信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		trackTyreStockMapper.updateById(params);
	}
	
}
