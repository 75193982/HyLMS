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
import com.jshpsoft.dao.FeedbackMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.Feedback;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.FeedbackService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("feedbackService")
public class FeedbackServiceImpl implements FeedbackService {
	
	@Autowired
	private FeedbackMapper feedbackMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Override
	@SystemServiceLog(description="查询意见反馈列表信息")
	public Pager<Feedback> getPageData(Map<String, Object> params) throws Exception {
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
		List<Feedback> list = feedbackMapper.getPageList(params);
		if( null != list && list.size() > 0 ){
			for(int i=0; i<list.size(); i++){
				String insertUser = list.get(i).getInsertUser();
				if( StringUtils.isNotEmpty(insertUser) ){
					User user = userMapper.getById(Integer.parseInt(insertUser));
					if( null != user ){
						list.get(i).setInsertUserName(user.getName());
					}
					
				}
			}
		}
		int totalCount = feedbackMapper.getPageTotalCount(params);
		
		Pager<Feedback> pager = new Pager<Feedback>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="保存意见反馈信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(Feedback bean, String oper) throws Exception {
		
		if( null == bean || StringUtils.isEmpty(bean.getSuggest()) ){
			throw new RuntimeException("意见反馈信息不能为空");
		}
		
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		feedbackMapper.insert(bean);
		
	}

	@Override
	@SystemServiceLog(description="根据id获取意见反馈明细")
	public Feedback getById(Integer id) throws Exception {
		
		Feedback bean = feedbackMapper.getById(id);
		if( null != bean ){
			String insertUser = bean.getInsertUser();
			if( StringUtils.isNotEmpty(insertUser) ){
				User user = userMapper.getById(Integer.parseInt(insertUser));
				if( null != user ){
					bean.setInsertUserName(user.getName());
					
				}
				
			}
			
		}
		
		return bean;
	}

}
