package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.AttachMoneyLog;
import com.jshpsoft.domain.BalanceCar;
import com.jshpsoft.util.Pager;

/**
 * 收入管理service
* @author  fengql 
* @date 2016年10月25日 上午9:51:12
 */
public interface IncomeMngService {
	
	/**
	 * 根据参数获取收入信息-分页
	* @author  fengql 
	* @date 2016年9月27日 上午9:22:47 
	* @parameter  
	* @return
	 */
	public Pager<BalanceCar> getPageData(Map<String, Object> params) throws Exception;
	
	/**
	 * 保存额外计费
	* @author  fengql 
	* @date 2016年10月25日 上午10:03:28 
	* @parameter  
	* @return
	 */
	public void save(AttachMoneyLog bean, String oper) throws Exception;
	
	/**
	 * 根据运单id获取额外费用
	* @author  fengql 
	* @date 2016年10月25日 上午10:11:14 
	* @parameter  
	* @return
	 */
	public List<AttachMoneyLog> getAttachDetail(Map<String, Object> params) throws Exception;
	
	/**
	 * 根据id更新--删除标记
	* @author  fengql 
	* @date 2016年10月25日 上午10:15:14 
	* @parameter  
	* @return
	 */
	public void updateById(Integer id, String oper) throws Exception;
	
	/**
	 * 打印数据
	* @author  fengql 
	* @date 2016年10月25日 上午10:17:33 
	* @parameter  
	* @return
	 */
	public List<BalanceCar> getPrint(Map<String, Object> params) throws Exception;
		
	/**
	 * 导出数据
	* @author  fengql 
	* @date 2016年10月19日 下午1:14:07 
	* @parameter  
	* @return
	 */
	public Map<String, Object> getExportData(Map<String, Object> params)throws Exception;
	
	/**
	 * 对账
	* @author  fengql 
	* @date 2016年11月4日 下午1:52:28 
	* @parameter  
	* @return
	 */
	public void balance(Integer id, String oper) throws Exception;
	
	/**
	 * 获取总金额
	* @author  fengql 
	* @date 2016年12月7日 上午10:51:46 
	* @parameter  
	* @return
	 */
	public double getSumPrice(Map<String, Object> params) throws Exception;
	
	/**
	 * 
	 * @Description: 获取商品车运费
	 * @author army.liu 
	 * @param @param bean
	 * @param @return
	 * @param @throws Exception    设定文件
	 * @return BalanceCar    返回类型
	 * @throws
	 * @see
	 */
	public BalanceCar getBalanceCar(BalanceCar bean) throws Exception;
}
