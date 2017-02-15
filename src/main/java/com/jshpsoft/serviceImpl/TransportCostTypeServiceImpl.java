package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.TransportCostTypeMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.TransportCostType;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.TransportCostTypeService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * 驾驶员报销费用类型serviceimpl
 * @author  army.liu 
 */
@Service("transportCostTypeService")
public class TransportCostTypeServiceImpl implements TransportCostTypeService {
	
	@Autowired
	private TransportCostTypeMapper transportCostTypeMapper;
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public Pager<TransportCostType> getPageData(Map<String, Object> params)
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
		
		List<TransportCostType> list = transportCostTypeMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				String insertUser = list.get(i).getInsertUser();
				if( StringUtils.isNotEmpty(insertUser) ){
					User user = userMapper.getById( Integer.parseInt(insertUser) );
					if( null != user ){
						list.get(i).setInsertUserName(user.getName());
					}
					
				}
			}
		}
		int totalCount = transportCostTypeMapper.getPageTotalCount(params);
		
		Pager<TransportCostType> pager = new Pager<TransportCostType>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存、修改保存驾驶员报销费用类型")
	public void save(TransportCostType bean, String operId) throws Exception {
		Integer id = bean.getId();
		if( null == id ){
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			transportCostTypeMapper.insert(bean);
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			transportCostTypeMapper.update(bean);
		}
	}

	@Override
	public TransportCostType getById(Integer id) throws Exception {
		
		return transportCostTypeMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除驾驶员报销费用类型")
	public void delete(Integer id, String operId) throws Exception {
		TransportCostType bean = transportCostTypeMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		transportCostTypeMapper.update(bean);
	}

	@Override
	public List<TransportCostType> getByConditions(Map<String, Object> params)
			throws Exception {
		return transportCostTypeMapper.getByConditions(params);
	}

}
