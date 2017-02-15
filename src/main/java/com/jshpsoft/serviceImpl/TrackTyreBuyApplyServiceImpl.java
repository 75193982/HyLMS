package com.jshpsoft.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.TrackTyreBuyApplyMapper;
import com.jshpsoft.domain.TrackTyreBuyApply;
import com.jshpsoft.service.TrackTyreBuyApplyService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月10日 下午1:10:52
 */
@Service("trackTyreBuyApplyService")
public class TrackTyreBuyApplyServiceImpl implements TrackTyreBuyApplyService {
	
	@Resource
	private TrackTyreBuyApplyMapper trackTyreBuyApplyMapper;
	
	@Resource
	private CommonService commonService;

	@Override
	public List<TrackTyreBuyApply> getByConditions(Map<String, Object> params)
			throws Exception {
		return trackTyreBuyApplyMapper.getByConditions(params);
	}

	@Override
	public Pager<TrackTyreBuyApply> getPageData(Map<String, Object> params)
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
		
		List<TrackTyreBuyApply> list = trackTyreBuyApplyMapper.getPageList(params);
		int totalCount = trackTyreBuyApplyMapper.getPageTotalCount(params);
		
		Pager<TrackTyreBuyApply> pager = new Pager<TrackTyreBuyApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存轮胎采购")
	public void save(TrackTyreBuyApply bean, String operId) throws Exception {
		Integer id = bean.getId();
		if( null == id ){
			String costApplyNo = "CG"+CommonUtil.getYearMonthDayNo();//  yyyyMMdd
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String a = sdf.format(new Date());
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("insertTime", a);
			List<TrackTyreBuyApply> list = trackTyreBuyApplyMapper.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				String no = list.get(0).getBillNo();//取第一条即是单号最大
				costApplyNo += getNextNo(no.substring(10));
			}
			else
			{
				costApplyNo +="00001";
			}
			
			bean.setBillNo(costApplyNo);
			bean.setStatus(Constants.TrackTyreBuyApplyStatus.NEW);
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			trackTyreBuyApplyMapper.insert(bean);
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			trackTyreBuyApplyMapper.update(bean);
		}

	}

	public String getNextNo(String no){
		String result = String.format("%0" + no.length() + "d", Integer.parseInt(no) + 1);
        return result;
	}
	
	@Override
	public TrackTyreBuyApply getById(Integer id) throws Exception {
		return trackTyreBuyApplyMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除轮胎采购")
	public void delete(Integer id, String operId) throws Exception {
		TrackTyreBuyApply bean = trackTyreBuyApplyMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		trackTyreBuyApplyMapper.update(bean);

	}

	@Override
	@SystemServiceLog(description="提交轮胎采购")
	@Transactional
	public void submit(Integer id, String operId) throws Exception {
		TrackTyreBuyApply bean = trackTyreBuyApplyMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(Constants.TrackTyreBuyApplyStatus.SUBMIT);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(String.valueOf(operId));
		trackTyreBuyApplyMapper.update(bean);

		//添加到流程中
		commonService.addToProcess( 
				Constants.ProcessType.LTCGSQD, 
				id, 
				Integer.parseInt( operId ), 
				CommonUtil.getProcessName(Constants.ProcessType.LTCGSQD, bean.getBillNo())
				);
	}

	@Override
	@Transactional
	public void auditSuccess(Integer detailId, int status, int operId)
			throws Exception {
		TrackTyreBuyApply bean = trackTyreBuyApplyMapper.getById(detailId);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(String.valueOf(status));
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(String.valueOf(operId));
		trackTyreBuyApplyMapper.update(bean);
		
		
		
		
	}

	@Override
	@Transactional
	public void auditForConfirm(Integer detailId, int status, int operId)
			throws Exception {
		TrackTyreBuyApply bean = trackTyreBuyApplyMapper.getById(detailId);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(String.valueOf(status));
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(String.valueOf(operId));
		trackTyreBuyApplyMapper.update(bean);

	}

	@Override
	@Transactional
	public void auditFail(Integer detailId, int status, int operId)
			throws Exception {
		auditForConfirm(detailId, status, operId);

	}

	@Override
	@SystemServiceLog(description="确认轮胎采购")
	public void sure(Integer id, String operId) throws Exception {
		TrackTyreBuyApply bean = trackTyreBuyApplyMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setStatus(Constants.TrackTyreBuyApplyStatus.FINISH);//已完成
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(String.valueOf(operId));
		trackTyreBuyApplyMapper.update(bean);
		
	}

}
