package com.jshpsoft.service;

import java.util.Map;

import com.jshpsoft.domain.Feedback;
import com.jshpsoft.util.Pager;

/**
 * 
 * @Description: 意见反馈service
 * @author army.liu
 * @date 2016年11月5日 上午8:41:27
 *
 */
public interface FeedbackService {

	/**
	 * @Description: 获取分页数据
	 * @author army.liu 
	 * @param @param params
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return Pager<Feedback>    返回类型
	 * @throws
	 * @see
	 */
	public Pager<Feedback> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * @Description: 保存
	 * @author army.liu 
	 * @param @param bean
	 * @param @param oper
	 * @param @throws Exception    设定文件
	 * @return void    返回类型
	 * @throws
	 * @see
	 */
	public void save(Feedback bean, String oper) throws Exception;
	
	/**
	 * @Description: 根据主键获取详细
	 * @author army.liu 
	 * @param @param id
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return Feedback    返回类型
	 * @throws
	 * @see
	 */
	public Feedback getById(Integer id) throws Exception;
	
}
