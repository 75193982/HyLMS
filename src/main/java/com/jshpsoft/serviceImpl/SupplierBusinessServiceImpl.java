package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.SupplierBusinessMapper;
import com.jshpsoft.dao.SupplierBusinessPriceMapper;
import com.jshpsoft.domain.SupplierBusiness;
import com.jshpsoft.domain.SupplierBusinessPrice;
import com.jshpsoft.service.SupplierBusinessService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("supplierBusinessService")
public class SupplierBusinessServiceImpl implements SupplierBusinessService {

	@Autowired
	private SupplierBusinessMapper supplierBusinessMapper;
	
	@Autowired
	private SupplierBusinessPriceMapper supplierBusinessPriceMapper;
	
	@Override
	@SystemServiceLog(description="查询汽车品牌信息")
	public List<SupplierBusiness> getByConditions(Map<String, Object> params) throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return supplierBusinessMapper.getByConditions(params);
	}

	@Override
	public Pager<SupplierBusiness> getPageData(Map<String, Object> params)
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
		List<SupplierBusiness> list = supplierBusinessMapper.getPageList(params);
		int totalCount = supplierBusinessMapper.getPageTotalCount(params);
		
		Pager<SupplierBusiness> pager = new Pager<SupplierBusiness>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存、修改品牌设置信息")
	public void save(SupplierBusiness bean, String oper) throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		if(null == bean.getId())
		{
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			params.put("supplierId",bean.getSupplierId());
			params.put("brandName",bean.getBrandName());
			List<SupplierBusiness> list = supplierBusinessMapper.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				throw new RuntimeException("此供应商品牌已有！");
			}
			bean.setInsertUser(oper);
			bean.setInsertTime(new Date());
			bean.setDelFlag(Constants.DelFlag.N);
			supplierBusinessMapper.insert(bean);
		}
		else
		{
			SupplierBusiness s = supplierBusinessMapper.getById(bean.getId());
			if(!bean.getBrandName().equals(s.getBrandName()))
			{
				Map<String,Object> params = new HashMap<String, Object>();
				params.put("delFlag", Constants.DelFlag.N);
				params.put("supplierId",bean.getSupplierId());
				params.put("brandName",bean.getBrandName());
				List<SupplierBusiness> list = supplierBusinessMapper.getByConditions(params);
				if(null != list && list.size() > 0)
				{
					throw new RuntimeException("此供应商品牌已有！");
				}
			}
			bean.setUpdateUser(oper);
			bean.setUpdateTime(new Date());
			supplierBusinessMapper.update(bean);
		}
	}

	@Override
	@SystemServiceLog(description="删除品牌设置信息")
	public void delete(Integer id, String oper) throws Exception {
		SupplierBusiness bean = new SupplierBusiness();
		bean.setUpdateUser(oper);
		bean.setUpdateTime(new Date());
		bean.setDelFlag(Constants.DelFlag.Y);
		bean.setId(id);
		supplierBusinessMapper.update(bean);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("delFlag", Constants.DelFlag.N);
		params.put("businessId", id);
		List<SupplierBusinessPrice> spList = supplierBusinessPriceMapper.getByConditions(params);
		if(null != spList && spList.size() > 0)
		{
			SupplierBusinessPrice s = new SupplierBusinessPrice();
			s.setUpdateUser(oper);
			s.setUpdateTime(new Date());
			s.setDelFlag(Constants.DelFlag.Y);
			s.setBusinessId(id);
			supplierBusinessPriceMapper.updateByBusinessId(s);//根据业务id删除
		}
		
		
	}

	@Override
	public SupplierBusiness getById(Integer id) throws Exception {
		return supplierBusinessMapper.getById(id);
	}

}
