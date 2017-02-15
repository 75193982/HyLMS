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
import com.jshpsoft.dao.StockPositionMapper;
import com.jshpsoft.domain.StockPosition;
import com.jshpsoft.service.StockPositionService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("stockPositionService")
public class StockPositionServiceImpl implements StockPositionService {
	
	@Autowired
	private StockPositionMapper stockPositionMapper;
	
	@Override
	@SystemServiceLog(description="查询仓库储位信息")
	public List<StockPosition> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return stockPositionMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询仓库储位列表信息")
	public Pager<StockPosition> getPageData(Map<String, Object> params) throws Exception {
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
		List<StockPosition> list = stockPositionMapper.getPageList(params);
		int totalCount = stockPositionMapper.getPageTotalCount(params);
		
		Pager<StockPosition> pager = new Pager<StockPosition>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增仓库储位信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(StockPosition bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("仓库储位信息为空");
		}
		
		//验证该仓库储位名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("stockId", bean.getStockId());
		params.put("carShopId", bean.getCarShopId());
		params.put("position", bean.getPosition());
		params.put("delFlag", Constants.DelFlag.N);
		List<StockPosition> stockPosition = stockPositionMapper.getByConditions(params);
		if(null !=stockPosition && stockPosition.size()>0){
			throw new RuntimeException("该仓库储位已存在，请检查");
		}
		
		//插入仓库储位表
		bean.setStatus("N");
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		stockPositionMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取仓库储位信息")
	public StockPosition getById(Integer id) throws Exception {
		return stockPositionMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新仓库储位信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(StockPosition bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("仓库储位信息为空");
		}
		
		//验证该仓库储位名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("stockId", bean.getStockId());
		params.put("carShopId", bean.getCarShopId());
		params.put("position", bean.getPosition());
		params.put("delFlag", Constants.DelFlag.N);
		List<StockPosition> stockPosition = stockPositionMapper.getByConditions(params);
		if(null !=stockPosition && stockPosition.size()>0 && (int)stockPosition.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该仓库储位已存在，请检查");
		}
		
		//更新仓库储位数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		stockPositionMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除仓库储位信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		stockPositionMapper.updateById(params);
	}

	
}
