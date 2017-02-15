package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CostTypeMapper;
import com.jshpsoft.domain.CostType;
import com.jshpsoft.service.CostTypeService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月7日 上午9:06:23
 */
@Service("costTypeService")
public class CostTypeServiceImpl implements CostTypeService {
	
	@Autowired
	private CostTypeMapper costTypeMapper;

	@Override
	public Pager<CostType> getPageData(Map<String, Object> params)
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
		
		List<CostType> list = costTypeMapper.getPageList(params);
		int totalCount = costTypeMapper.getPageTotalCount(params);
		
		Pager<CostType> pager = new Pager<CostType>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存、修改保存费用类型")
	public void save(CostType bean, String operId) throws Exception {
		Integer id = bean.getId();
		if( null == id ){
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			costTypeMapper.insert(bean);
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			costTypeMapper.update(bean);
		}
	}

	@Override
	public CostType getById(Integer id) throws Exception {
		
		return costTypeMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除费用类型")
	public void delete(Integer id, String operId) throws Exception {
		CostType bean = costTypeMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		costTypeMapper.update(bean);
	}

	@Override
	public List<CostType> getByConditions(Map<String, Object> params)
			throws Exception {
		return costTypeMapper.getByConditions(params);
	}
	
	

}
