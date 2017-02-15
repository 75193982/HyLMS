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
import com.jshpsoft.dao.BalancePriceMapper;
import com.jshpsoft.domain.BalancePriceSetting;
import com.jshpsoft.service.BalancePriceMngService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("balancePriceMngService")
public class BalancePriceMngServiceImpl implements BalancePriceMngService {
	
	@Autowired
	private BalancePriceMapper  balancePriceMapper;
	
	@Override
	@SystemServiceLog(description="查询结算价格信息")
	public List<BalancePriceSetting> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return balancePriceMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询结算价格列表信息")
	public Pager<BalancePriceSetting> getPageData(Map<String, Object> params) throws Exception {
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
		List<BalancePriceSetting> list = balancePriceMapper.getPageList(params);
		int totalCount = balancePriceMapper.getPageTotalCount(params);
		
		Pager<BalancePriceSetting> pager = new Pager<BalancePriceSetting>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增结算价格信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(BalancePriceSetting bean, String oper) throws Exception {

		if( null == bean ){
			throw new RuntimeException("结算价格信息为空");
		}
		
		//验证是否已经存在supplierId-供应商id、brand-品牌、carType-车型
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("supplierId", bean.getSupplierId());
		params.put("brand", bean.getBrand());
		params.put("carType", bean.getCarType());
		params.put("delFlag", Constants.DelFlag.N);
		List<BalancePriceSetting> carBrand = balancePriceMapper.getByConditions(params);
		if(null !=carBrand && carBrand.size()>0){
			throw new RuntimeException("该供应商、品牌、车型的结算价格已存在，请检查");
		}
		
		//插入结算价格表
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		balancePriceMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取结算价格明细")
	public BalancePriceSetting getById(Integer id) throws Exception {
		return balancePriceMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新结算价格信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(BalancePriceSetting bean, String oper) throws Exception {

		if( null == bean ){
			throw new RuntimeException("结算价格信息为空");
		}
		
		//验证是否已经存在supplierId-供应商id、brand-品牌、carType-车型
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("supplierId", bean.getSupplierId());
		params.put("brand", bean.getBrand());
		params.put("carType", bean.getCarType());
		params.put("delFlag", Constants.DelFlag.N);
		List<BalancePriceSetting> carBrand = balancePriceMapper.getByConditions(params);
		if(null !=carBrand && carBrand.size()>0 && (int)carBrand.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该供应商、品牌、车型的结算价格已存在，请检查");
		}
		
		//更新结算价格数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		balancePriceMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除结算价格信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		balancePriceMapper.updateById(params);
	}

}
