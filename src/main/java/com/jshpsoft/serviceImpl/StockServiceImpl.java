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
import com.jshpsoft.dao.StockMapper;
import com.jshpsoft.domain.Stock;
import com.jshpsoft.service.StockService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("stockService")
public class StockServiceImpl implements StockService {
	
	@Autowired
	private StockMapper stockMapper;
	
	@Override
	@SystemServiceLog(description="查询仓库信息")
	public List<Stock> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return stockMapper.getByConditions(params);
	}
	
	@Override
	@SystemServiceLog(description="查询仓库列表信息")
	public Pager<Stock> getPageData(Map<String, Object> params) throws Exception {
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
		List<Stock> list = stockMapper.getPageList(params);
		int totalCount = stockMapper.getPageTotalCount(params);
		
		Pager<Stock> pager = new Pager<Stock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增仓库信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(Stock bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("仓库信息为空");
		}
		
		//验证该仓库名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", bean.getName());
		params.put("delFlag", Constants.DelFlag.N);
		List<Stock> stock = stockMapper.getByConditions(params);
		if(null !=stock && stock.size()>0){
			throw new RuntimeException("该仓库名称已存在，请检查");
		}
		
		//插入仓库表
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		stockMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取仓库信息")
	public Stock getById(Integer id) throws Exception {
		return stockMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新仓库信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(Stock bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("仓库信息为空");
		}
		
		//验证该仓库名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", bean.getName());
		params.put("delFlag", Constants.DelFlag.N);
		List<Stock> stock = stockMapper.getByConditions(params);
		if(null !=stock && stock.size()>0 && (int)stock.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该仓库名称已存在，请检查");
		}
		
		//更新仓库数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		stockMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除仓库信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		stockMapper.updateById(params);
	}

	
}
