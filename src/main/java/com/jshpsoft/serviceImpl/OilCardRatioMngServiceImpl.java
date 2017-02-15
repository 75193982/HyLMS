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
import com.jshpsoft.dao.OilCardRatioMapper;
import com.jshpsoft.domain.OilCardRatioSetting;
import com.jshpsoft.service.OilCardRatioMngService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("oilCardRatioMngService")
public class OilCardRatioMngServiceImpl implements OilCardRatioMngService {
	
	@Autowired
	private OilCardRatioMapper  oilCardRatioMapper;
	
	@Override
	@SystemServiceLog(description="查询油卡结算比率信息")
	public List<OilCardRatioSetting> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return oilCardRatioMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询油卡结算比率列表信息")
	public Pager<OilCardRatioSetting> getPageData(Map<String, Object> params) throws Exception {
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
		List<OilCardRatioSetting> list = oilCardRatioMapper.getPageList(params);
		int totalCount = oilCardRatioMapper.getPageTotalCount(params);
		
		Pager<OilCardRatioSetting> pager = new Pager<OilCardRatioSetting>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增油卡结算比率信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(OilCardRatioSetting bean, String oper) throws Exception {

		if( null == bean ){
			throw new RuntimeException("油卡结算比率为空");
		}
		
		//验证该油卡结算比率是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mainId", bean.getMainId());
		params.put("delFlag", Constants.DelFlag.N);
		List<OilCardRatioSetting> carRatio = oilCardRatioMapper.getByConditions(params);
		if(null !=carRatio && carRatio.size()>0){
			throw new RuntimeException("该油卡结算比率已存在，请检查");
		}
		
		//插入油卡结算比率表
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		oilCardRatioMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取油卡结算比率明细")
	public OilCardRatioSetting getById(Integer id) throws Exception {
		return oilCardRatioMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新油卡结算比率信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(OilCardRatioSetting bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("油卡结算比率为空");
		}
		
		//验证该油卡结算比率是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mainId", bean.getMainId());
		params.put("delFlag", Constants.DelFlag.N);
		List<OilCardRatioSetting> carRatio = oilCardRatioMapper.getByConditions(params);
		if(null !=carRatio && carRatio.size()>0 && (int)carRatio.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该油卡结算比率已存在，请检查");
		}
		
		//更新油卡结算比率数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		oilCardRatioMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除油卡结算比率信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		oilCardRatioMapper.updateById(params);
	}

}
