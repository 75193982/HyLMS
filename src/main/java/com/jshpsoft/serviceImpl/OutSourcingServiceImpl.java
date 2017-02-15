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
import com.jshpsoft.dao.OutSourcingMapper;
import com.jshpsoft.domain.OutSourcing;
import com.jshpsoft.service.OutSourcingService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("outSourcingService")
public class OutSourcingServiceImpl implements OutSourcingService {
	
	@Autowired
	private OutSourcingMapper outSourcingMapper;
	
	@Override
	@SystemServiceLog(description="查询外协单位信息")
	public List<OutSourcing> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return outSourcingMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询外协单位列表信息")
	public Pager<OutSourcing> getPageData(Map<String, Object> params) throws Exception {
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
		List<OutSourcing> list = outSourcingMapper.getPageList(params);
		int totalCount = outSourcingMapper.getPageTotalCount(params);
		
		Pager<OutSourcing> pager = new Pager<OutSourcing>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增外协单位信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(OutSourcing bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("外协单位信息为空");
		}
		
		//验证该外协单位名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", bean.getName());
		params.put("delFlag", Constants.DelFlag.N);
		List<OutSourcing> carShop = outSourcingMapper.getByConditions(params);
		if(null !=carShop && carShop.size()>0){
			throw new RuntimeException("该外协单位名称已存在，请检查");
		}
		
		//插入外协单位表
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		outSourcingMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取外协单位明细")
	public OutSourcing getById(Integer id) throws Exception {
		return outSourcingMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新外协单位信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(OutSourcing bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("外协单位信息为空");
		}
		
		//验证该外协单位名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", bean.getName());
		params.put("delFlag", Constants.DelFlag.N);
		List<OutSourcing> carShop = outSourcingMapper.getByConditions(params);
		if(null !=carShop && carShop.size()>0 && (int)carShop.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该外协单位名称已存在，请检查");
		}
		
		//更新外协单位数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		outSourcingMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除外协单位信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		outSourcingMapper.updateById(params);
	}

	
}
