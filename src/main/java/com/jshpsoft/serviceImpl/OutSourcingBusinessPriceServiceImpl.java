package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.OutSourcingBusinessMapper;
import com.jshpsoft.dao.OutSourcingBusinessPriceMapper;
import com.jshpsoft.domain.OutSourcingBusiness;
import com.jshpsoft.domain.OutSourcingBusinessPrice;
import com.jshpsoft.service.OutSourcingBusinessPriceService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月3日 上午8:50:34
 */
@Service("outSourcingBusinessPriceService")
public class OutSourcingBusinessPriceServiceImpl implements
		OutSourcingBusinessPriceService {
	
	@Autowired
	private OutSourcingBusinessPriceMapper outSourcingBusinessPriceMapper;
	
	@Autowired
	private OutSourcingBusinessMapper outSourcingBusinessMapper;

	@Override
	@SystemServiceLog(description="新增、修改承运商价格信息")
	public void save(OutSourcingBusinessPrice bean, String oper)
			throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		
		Map<String,Object> par = new HashMap<String, Object>();
		par.put("delFlag", Constants.DelFlag.N);
		par.put("outSourcingId", bean.getOutSourcingId());
		par.put("brandName", bean.getBrandName());
		par.put("supplierId", bean.getSupplierId());
		List<OutSourcingBusiness> olist = outSourcingBusinessMapper.getByConditions(par);//承运商的 供应商品牌设置
		OutSourcingBusiness sb = new OutSourcingBusiness();
		if(null != olist && olist.size() > 0)
		{
			 sb = olist.get(0);
		}
		else
		{
			throw new RuntimeException("请先设置该承运商下的供应商、品牌结算模式！");
		}
			
		bean.setBusinessId(sb.getId());
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("outSourcingId", bean.getOutSourcingId());
		params.put("libName", bean.getLibName());
		params.put("businessId", bean.getBusinessId());
		params.put("startAddress", bean.getStartAddress());
		params.put("endProvince", bean.getEndProvince());
		params.put("endAddress", bean.getEndAddress());
		if(null != bean.getCarType() && !"".equals(bean.getCarType()))//车型不为空，即是车型模式 6+1
		{
			params.put("carTypeCheck", bean.getCarType());
		}
		List<OutSourcingBusinessPrice> list = outSourcingBusinessPriceMapper.getByConditions(params);
		
		
		Integer id = bean.getId();
		if(id != null)
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
     		outSourcingBusinessPriceMapper.update(bean);
		}
		else
		{
			if(null != list && list.size() > 0)
			{
				throw new RuntimeException("数据已经存在！");
			}
			bean.setInsertUser(oper);
			bean.setInsertTime(new Date());
			bean.setDelFlag(Constants.DelFlag.N);
			outSourcingBusinessPriceMapper.insert(bean);
		}
	}

	@Override
	@SystemServiceLog(description="删除承运商价格信息")
	public void delete(int id, String oper) throws Exception {
		OutSourcingBusinessPrice bean = new OutSourcingBusinessPrice();
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.Y);
		bean.setId(id);
		outSourcingBusinessPriceMapper.update(bean);

	}

	@Override
	public Pager<OutSourcingBusinessPrice> getPageData(
			Map<String, Object> params) throws Exception {
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
		List<OutSourcingBusinessPrice> list = outSourcingBusinessPriceMapper.getPageList(params);
		int totalCount = outSourcingBusinessPriceMapper.getPageTotalCount(params);
		
		Pager<OutSourcingBusinessPrice> pager = new Pager<OutSourcingBusinessPrice>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	public OutSourcingBusinessPrice getById(Integer id) throws Exception {
		OutSourcingBusinessPrice obp = outSourcingBusinessPriceMapper.getById(id);
		OutSourcingBusiness ob = outSourcingBusinessMapper.getById(obp.getBusinessId());
		obp.setSupplierId(ob.getSupplierId());  
		obp.setBrandName(ob.getBrandName());
		return obp;
	}

	@Override
	public List<OutSourcingBusinessPrice> getLib(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return outSourcingBusinessPriceMapper.getLibNameByOs(params);
	}

}
