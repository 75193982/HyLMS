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
import com.jshpsoft.dao.WaybillLogMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.domain.WaybillLog;
import com.jshpsoft.service.WaybillFollowService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("waybillFollowService")
public class WaybillFollowServiceImpl implements WaybillFollowService {
	
	@Autowired
	private WaybillMapper waybillMapper;
	
	@Autowired
	private WaybillLogMapper waybillLogMapper;

	@Override
	@SystemServiceLog(description="查询待跟踪的运单信息")
	public Pager<Waybill> getPageData(Map<String, Object> params) throws Exception {
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
		List<Waybill> list = waybillMapper.getWaybillList(params);
		int totalCount = waybillMapper.getWaybillCount(params);
		
		Pager<Waybill> pager = new Pager<Waybill>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="根据运单id获取运单跟踪信息")
	public WaybillLog getByWaybillId(Integer waybillId) throws Exception {
		return waybillLogMapper.getByWaybillId(waybillId);
	}

	@Override
	@SystemServiceLog(description="更新运单跟踪信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(WaybillLog bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("运单跟踪信息为空");
		}
		
		WaybillLog oldBean = waybillLogMapper.getByWaybillId(bean.getWaybillId());
		if(null == oldBean){
			bean.setInsertTime(new Date());
			bean.setInsertUser(oper);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			bean.setDelFlag(Constants.DelFlag.N);
			waybillLogMapper.insert(bean);
		}else{
			bean.setId(oldBean.getId());
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			waybillLogMapper.update(bean);
		}
		
	}

	@Override
	@SystemServiceLog(description="更新运单跟踪信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void sure(Integer waybillId) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", waybillId);
		params.put("status", Constants.WaibillStatus.FINISHED.getValue());//已完成
		waybillMapper.submitWaybill(params);
		
	}
	
}
