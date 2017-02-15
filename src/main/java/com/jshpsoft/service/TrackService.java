package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.TrackInsurance;
import com.jshpsoft.util.Pager;

/**
 * 运输车辆service
* @author  fengql 
* @date 2016年9月27日 上午9:20:57
 */
public interface TrackService {

	/**
	 * 根据参数获取运输车辆信息
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public List<Track> getByConditions(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据参数获取运输车辆信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<Track> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存运输车辆数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:21:57 
	* @parameter  
	* @return
	 */
	public void save(Track bean, String oper) throws Exception;
	
	/**
	 * 根据id获取运输车辆
	* @author  fengql 
	* @date 2016年9月26日 下午2:23:44 
	* @parameter  
	* @return
	 */
	public Track getById(Integer id) throws Exception;
	
	/**
	 * 更新运输车辆数据
	* @author  fengql 
	* @date 2016年9月26日 下午2:29:11 
	* @parameter  
	* @return
	 */
	public void update(Track bean, String oper) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年9月26日 下午2:33:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	
	/**
	 * 上传
	 * @author  ww 
	 * @date 2016年11月21日 上午11:05:21
	 * @parameter  
	 * @return
	 */
	public void updateFilePath(Map<String, Object> params,HttpServletRequest request) throws Exception;

	/**
	 * @Description: 根据车号获取驾驶员
	 * @author army.liu 
	 * @param @param carNumber
	 * @param @return    设定文件
	 * @return Track    返回类型
	 * @throws
	 * @see
	 */
	public Track getByCarNumber(String carNumber) throws Exception;
	
	/**
	 * 获取保费数据
	 * @author  ww 
	 * @date 2016年12月8日 下午4:31:38
	 * @parameter  
	 * @return
	 */
	public List<TrackInsurance> getInsuranceList(String carNumber,String type) throws Exception;
	
}
