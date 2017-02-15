package com.jshpsoft.serviceImpl;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.SupplierBusinessMapper;
import com.jshpsoft.dao.SupplierBusinessPriceMapper;
import com.jshpsoft.dao.SupplierMapper;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.SupplierBusiness;
import com.jshpsoft.domain.SupplierBusinessPrice;
import com.jshpsoft.service.SupplierBusinessPriceService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年11月24日 下午4:37:00
 */
@Service("supplierBusinessPriceService")
public class SupplierBusinessPriceServiceImpl implements
		SupplierBusinessPriceService {
	
	@Autowired
	private SupplierBusinessPriceMapper supplierBusinessPriceMapper;
	
	@Autowired
	private SupplierBusinessMapper supplierBusiness;
	
	@Autowired
	private SupplierMapper supplierMapper;

	@Override
	@SystemServiceLog(description="新增、修改价格信息")
	@Transactional
	public void save(SupplierBusinessPrice bean,String oper) throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		List<SupplierBusinessPrice> list = new ArrayList<SupplierBusinessPrice>();
		SupplierBusiness sb = supplierBusiness.getById(bean.getBusinessId());//供应商品牌设置
		if(null != sb)
		{
			if(null != sb.getBalanceType() && !"".equals(sb.getBalanceType()))//结算模式不为空，说明设置过
			{
				Map<String,Object> params = new HashMap<String, Object>();
				params.put("supplierId", bean.getSupplierId());
				params.put("libName", bean.getLibName());
				params.put("businessId", bean.getBusinessId());
				params.put("startAddress", bean.getStartAddress());
				params.put("endProvince", bean.getEndProvince());
				params.put("endAddress", bean.getEndAddress());
				if(null != bean.getCarType() && !"".equals(bean.getCarType()))//车型不为空，即是车型模式 6+1
				{
					params.put("carTypeCheck", bean.getCarType());
				}
				list = supplierBusinessPriceMapper.getByConditions(params);
			}
			else
			{
				throw new RuntimeException("请先设置品牌结算模式！");
			}
		}
		
		Integer id = bean.getId();
		if(id == null)
		{
			if(null != list && list.size() > 0)
			{
				throw new RuntimeException("数据已经存在！");
			}
			bean.setInsertUser(oper);
			bean.setInsertTime(new Date());
			bean.setDelFlag(Constants.DelFlag.N);
			supplierBusinessPriceMapper.insert(bean);
		}
		else
		{
			if(null != list && list.size() > 0)
			{
				if(list.size() == 1 )
				{
					if(!bean.getId().equals(list.get(0).getId()))
					{
						throw new RuntimeException("数据已经存在！");
					}
				}
				else
				{
					throw new RuntimeException("数据已经存在！");
				}
			}
			bean.setUpdateUser(oper);
     		bean.setUpdateTime(new Date());
			supplierBusinessPriceMapper.update(bean);
		}
		//反填供应商 库区 多个以"|" 分开
		Map<String,Object> p = new HashMap<String, Object>();
		p.put("delFlag", Constants.DelFlag.N);
		p.put("supplierId", bean.getSupplierId());
		List<SupplierBusinessPrice> sl = supplierBusinessPriceMapper.getLibNameBySup(p);
		String stocks = "";
		if(null != sl && sl.size() > 0)
		{
			for(int i = 0;i<sl.size();i++)
			{
				SupplierBusinessPrice s = sl.get(i);
				if(null != s)
				{
					if(null != s.getLibName() && !"".equals(s.getLibName()))
					{
						stocks += s.getLibName()+"|";
					}
				}
			}
			stocks = stocks.substring(0,stocks.length()-1);
			Supplier sp = new Supplier();
			sp.setStocks(stocks);
			sp.setId(bean.getSupplierId());
			supplierMapper.update(sp);
		}
	}

	@Override
	@SystemServiceLog(description="删除价格信息")
	public void delete(int id, String oper) throws Exception {
		SupplierBusinessPrice bean = new SupplierBusinessPrice();
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.Y);
		bean.setId(id);
		supplierBusinessPriceMapper.update(bean);
	}

	@Override
	public Pager<SupplierBusinessPrice> getPageData(Map<String, Object> params)
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
		List<SupplierBusinessPrice> list = supplierBusinessPriceMapper.getPageList(params);
		int totalCount = supplierBusinessPriceMapper.getPageTotalCount(params);
		
		Pager<SupplierBusinessPrice> pager = new Pager<SupplierBusinessPrice>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	public SupplierBusinessPrice getById(Integer id) throws Exception {
		return supplierBusinessPriceMapper.getById(id);
	}

}
