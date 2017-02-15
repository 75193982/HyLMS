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
import com.jshpsoft.dao.TransportPriceMapper;
import com.jshpsoft.domain.TransportPriceSetting;
import com.jshpsoft.service.TransportPriceMngService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("transportPriceMngService")
public class TransportPriceMngServiceImpl implements TransportPriceMngService {
	
	@Autowired
	private TransportPriceMapper transportPriceMapper;
	
	@Override
	@SystemServiceLog(description="查询驳板价格信息")
	public List<TransportPriceSetting> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return transportPriceMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询驳板价格列表信息")
	public Pager<TransportPriceSetting> getPageData(Map<String, Object> params) throws Exception {
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
		List<TransportPriceSetting> list = transportPriceMapper.getPageList(params);
		int totalCount = transportPriceMapper.getPageTotalCount(params);
		
		Pager<TransportPriceSetting> pager = new Pager<TransportPriceSetting>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增驳板价格信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(TransportPriceSetting bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("驳板价格信息为空");
		}
		
		//验证该驳板价格名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("supplierId", bean.getSupplierId());
		params.put("stock", bean.getStock());
		params.put("brandName", bean.getBrandName());
		params.put("delFlag", Constants.DelFlag.N);
		List<TransportPriceSetting> carBrand = transportPriceMapper.getByConditions(params);
		if(null !=carBrand && carBrand.size()>0){
			throw new RuntimeException("该供应商、库、品牌的驳板价格已存在，请检查");
		}
		
		//插入驳板价格表
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		transportPriceMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取驳板价格明细")
	public TransportPriceSetting getById(Integer id) throws Exception {
		return transportPriceMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新驳板价格信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(TransportPriceSetting bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("驳板价格信息为空");
		}
		
		//验证该驳板价格名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("supplierId", bean.getSupplierId());
		params.put("stock", bean.getStock());
		params.put("brandName", bean.getBrandName());
		params.put("delFlag", Constants.DelFlag.N);
		List<TransportPriceSetting> carBrand = transportPriceMapper.getByConditions(params);
		if(null !=carBrand && carBrand.size()>0 && (int)carBrand.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该供应商、库、品牌的驳板价格已存在，请检查");
		}
		
		//更新驳板价格数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		transportPriceMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除驳板价格信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		transportPriceMapper.updateById(params);
	}

}
