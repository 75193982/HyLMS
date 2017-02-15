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
import com.jshpsoft.dao.CarShopMapper;
import com.jshpsoft.domain.CarShop;
import com.jshpsoft.service.CarShopService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("carShopService")
public class CarShopServiceImpl implements CarShopService {
	
	@Autowired
	private CarShopMapper carShopMapper;
	
	@Override
	@SystemServiceLog(description="查询4S店信息")
	public List<CarShop> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return carShopMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询4S店列表信息")
	public Pager<CarShop> getPageData(Map<String, Object> params) throws Exception {
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
		List<CarShop> list = carShopMapper.getPageList(params);
		int totalCount = carShopMapper.getPageTotalCount(params);
		
		Pager<CarShop> pager = new Pager<CarShop>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增4S店信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(CarShop bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("4S店信息为空");
		}
		
		//验证该4S店名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", bean.getName());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarShop> carShop = carShopMapper.getByConditions(params);
		if(null !=carShop && carShop.size()>0){
			throw new RuntimeException("该4S店名称已存在，请检查");
		}
		
		//插入4S店表
		bean.getProvince().trim();
		bean.getCity().trim();
		bean.getAddress().trim();
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		carShopMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取4S店明细")
	public CarShop getById(Integer id) throws Exception {
		return carShopMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新4S店信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(CarShop bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("4S店信息为空");
		}
		
		//验证该4S店名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", bean.getName());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarShop> carShop = carShopMapper.getByConditions(params);
		if(null !=carShop && carShop.size()>0 && (int)carShop.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该4S店名称已存在，请检查");
		}
		
		//更新4S店数据
		bean.getProvince().trim();
		bean.getCity().trim();
		bean.getAddress().trim();
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		carShopMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除4S店信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		carShopMapper.updateById(params);
	}

	
}
