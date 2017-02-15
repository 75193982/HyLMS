package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.DutyMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.Duty;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.DutyService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service
public class DutyServiceImpl implements DutyService {

	@Autowired
	private DutyMapper dutyMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Override
	@SystemServiceLog(description="查询岗位列表信息")
	public Pager<Duty> getPageData(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		
		List<Duty> list = dutyMapper.getPageList(params);
		if( null != list && list.size()> 0 ){
			for(int i=0; i<list.size(); i++){
				Duty bean = list.get(i);
				//提交人
				String insertUserId = bean.getInsertUser();
				if( StringUtils.isNotEmpty(insertUserId) ){
					User user = userMapper.getById( Integer.parseInt(insertUserId));
					if( null != user ){
						list.get(i).setInsertUserName( user.getName() );
					}
					
				}
				
			}
		}
		int totalCount = dutyMapper.getPageTotalCount(params);
		
		Pager<Duty> pager = new Pager<Duty>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存岗位信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(Duty bean, String operId) throws Exception {
		
		Integer id = bean.getId();
		if( null == id ){
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			dutyMapper.insert(bean);
			
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			dutyMapper.update(bean);
			
		}
		
	}

	@Override
	@SystemServiceLog(description="查询岗位详细信息")
	public Duty getById(Integer id) throws Exception {
		return dutyMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除项目信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void delete(Integer id, String operId) throws Exception {
		Duty bean = dutyMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		dutyMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="查询所有岗位")
	public List<Duty> getByConditions(Map<String, Object> params) throws Exception {
		
		return dutyMapper.getByConditions(params);
	}

}
