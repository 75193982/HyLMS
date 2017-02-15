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
import com.jshpsoft.dao.OilPriceMapper;
import com.jshpsoft.domain.OilPrice;
import com.jshpsoft.service.OilPriceService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("oilPriceService")
public class OilPriceServiceImpl implements OilPriceService {
	
	@Autowired
	private OilPriceMapper oilPriceMapper;
	
	@Override
	@SystemServiceLog(description="查询油价信息")
	public List<OilPrice> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return oilPriceMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询油价列表信息")
	public Pager<OilPrice> getPageData(Map<String, Object> params) throws Exception {
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
		List<OilPrice> list = oilPriceMapper.getPageList(params);
		int totalCount = oilPriceMapper.getPageTotalCount(params);
		
		Pager<OilPrice> pager = new Pager<OilPrice>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增油价信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(OilPrice bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("油价信息为空");
		}
		
		//验证该油种是否已存在
		/*Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", bean.getType());
		params.put("delFlag", Constants.DelFlag.N);
		List<OilPrice> oilPrice = oilPriceMapper.getByConditions(params);
		if(null !=oilPrice && oilPrice.size()>0){
			throw new RuntimeException("该油种已存在，请检查");
		}*/
		
		//插入油价表
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		oilPriceMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取油价明细")
	public OilPrice getById(Integer id) throws Exception {
		return oilPriceMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新油价信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(OilPrice bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("油价信息为空");
		}
		
		//验证该油种是否已存在
		/*Map<String, Object> params = new HashMap<String, Object>();
		params.put("type", bean.getType());
		params.put("delFlag", Constants.DelFlag.N);
		List<OilPrice> oilPrice = oilPriceMapper.getByConditions(params);
		if(null !=oilPrice && oilPrice.size()>0 && (int)oilPrice.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该油种已存在，请检查");
		}*/
		
		//更新油价数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		oilPriceMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除油价信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		oilPriceMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="获取油价信息")
	public List<OilPrice> getOilPriceList() throws Exception {
		return oilPriceMapper.getOilPriceList();
	}

}
