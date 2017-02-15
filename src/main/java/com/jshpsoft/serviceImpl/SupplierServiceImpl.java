package com.jshpsoft.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.BalancePriceMapper;
import com.jshpsoft.dao.SupplierMapper;
import com.jshpsoft.domain.BalancePriceSetting;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.service.SupplierService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("supplierService")
public class SupplierServiceImpl implements SupplierService {
	
	@Autowired
	private SupplierMapper supplierMapper;
	
	@Autowired
	private BalancePriceMapper balancePriceMapper;
	
	@Override
	@SystemServiceLog(description="查询供应商信息")
	public List<Supplier> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return supplierMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询供应商列表信息")
	public Pager<Supplier> getPageData(Map<String, Object> params) throws Exception {
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
		List<Supplier> list = supplierMapper.getPageList(params);
		int totalCount = supplierMapper.getPageTotalCount(params);
		
		Pager<Supplier> pager = new Pager<Supplier>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增供应商信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(Supplier bean, String oper) throws Exception {
		
		//验证该供应商名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", bean.getName());
		params.put("delFlag", Constants.DelFlag.N);
		List<Supplier> supplier = supplierMapper.getByConditions(params);
		if(null !=supplier && supplier.size()>0){
			throw new RuntimeException("该供应商名称已存在，请检查");
		}
		
		//插入供应商表
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		supplierMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取供应商明细")
	public Supplier getById(Integer id) throws Exception {
		return supplierMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新供应商信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(Supplier bean, String oper) throws Exception {
		
		//验证该供应商名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", bean.getName());
		params.put("delFlag", Constants.DelFlag.N);
		List<Supplier> supplier = supplierMapper.getByConditions(params);
		if(null !=supplier && supplier.size()>0 && (int)supplier.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该供应商名称已存在，请检查");
		}
		
		//更新供应商数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		supplierMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除供应商信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		supplierMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="获取供应商的库")
	public List<Supplier> getSupplierStockList(Integer supplierId)
			throws Exception {
		List<Supplier> result = new ArrayList<Supplier>();
		Supplier bean = supplierMapper.getById(supplierId);
		
		if( null != bean ){
			String[] stocks = bean.getStocks().split("\\|");
			for(int i=0; i<stocks.length; i++){
				Supplier supplier=new Supplier();
				supplier.setStocks(stocks[i]);
				result.add(supplier);
			}		
		}
		
		return result;
	}

	@Override
	public void saveBalanceSetting(Supplier bean, String oper) throws Exception {
		Integer supplierId = bean.getId();
		Supplier supplier = supplierMapper.getById(supplierId);
		if( null == supplier ){
			throw new RuntimeException("供应商信息不存在");
		}
		
		//保存结算方式
		supplier.setBalanceType(bean.getBalanceType());
		supplier.setUpdateTime(new Date());
		supplier.setUpdateUser(oper);
		supplierMapper.update(supplier);
		
		//重新插入结算信息
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("supplierId", supplierId);
		params.put("delFlag", Constants.DelFlag.N);
		List<BalancePriceSetting> priceList = balancePriceMapper.getByConditions(params);
		if( null != priceList && priceList.size() > 0 ){
			for(int i=0; i<priceList.size(); i++){
				BalancePriceSetting bps = priceList.get(i);
				bps.setDelFlag(Constants.DelFlag.Y);
				bps.setUpdateTime(new Date());
				bps.setUpdateUser(oper);
				balancePriceMapper.update(bps);
				
			}
		}
		List<BalancePriceSetting> detail = bean.getDetail();
		if( null == detail || detail.size() == 0 ){
			throw new RuntimeException("结算价格信息不能为空");
		}
		for(int i=0; i<detail.size(); i++){
			BalancePriceSetting bps = detail.get(i);
			bps.setSupplierId(supplierId);
			bps.setDelFlag(Constants.DelFlag.N);
			bps.setInsertTime(new Date());
			bps.setUpdateTime(new Date());
			bps.setInsertUser(oper);
			bps.setUpdateUser(oper);
			balancePriceMapper.insert(bps);
			
		}
		
	}

	@Override
	public List<BalancePriceSetting> getBalanceSettingInfo(Integer supplierId) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("supplierId", supplierId);
		params.put("delFlag", Constants.DelFlag.N);
		return balancePriceMapper.getByConditions(params);
		
	}

	
	
}
