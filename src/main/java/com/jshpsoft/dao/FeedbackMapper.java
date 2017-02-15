package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.Feedback;

/**
 * 
 * @Description: 意见反馈管理dao
 * @author army.liu
 * @date 2016年11月5日 上午8:39:16
 *
 */
public interface FeedbackMapper {

	public void insert(Feedback bean)  throws Exception;
	
	public Feedback getById(Integer id) throws Exception ;

	/**
	 * 获取分页数据
	 * @return
	 * @throws Exception
	 */
	public List<Feedback> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获取分页大小
	 * @return
	 * @throws Exception
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
}
