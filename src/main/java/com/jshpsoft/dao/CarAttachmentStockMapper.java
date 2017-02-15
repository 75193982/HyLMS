package com.jshpsoft.dao;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarAttachmentStock;

/**
 * 
 * @author  ww 
 * @date 2016年9月26日 下午1:18:19
 */
public interface CarAttachmentStockMapper {
	
	public List<CarAttachmentStock> getByConditions(Map<String, Object> params) throws Exception;
	
	public void save(CarAttachmentStock bean) throws Exception;
	
	public CarAttachmentStock getById(int id) throws Exception;
	
	public void update(CarAttachmentStock bean) throws Exception;
	
	public void updateByWaybillId(Map<String, Object> params)throws Exception;
	
	public void delete(Map<String, Object> params) throws Exception;
	/**
	 * 获得分页数据
	 * @author  ww 
	 * @date 2016年9月29日 上午9:08:42
	 * @parameter  
	 * @return
	 */
	public List<CarAttachmentStock> getPageList(Map<String, Object> params) throws Exception;
	
	/**
	 * 获得总页数
	 * @author  ww 
	 * @date 2016年9月29日 上午9:09:10
	 * @parameter  
	 * @return
	 */
	public int getPageTotalCount(Map<String, Object> params) throws Exception;
	
	public List<CarAttachmentStock> queryCarAttachmentStock(Map<String, Object> params) throws Exception;
	
	public int bindCarAttachment(Map<String, Object> params) throws Exception;
	
	
	public int batchCancelBindCarAttachment(int id) throws Exception;
	public int submitCarAttachment(Map<String, Object> params) throws Exception ;
	public List<CarAttachmentStock> queryCarAttachment(int waybillId) throws Exception ;
	
	public void updateById(Map<String, Object> params) throws Exception;
	
	
	public int cancelBindCarAttachment(int id) throws Exception;
	
	/**
	 * 根据配件名称和运单编号模糊查询 
	 * @author  ww 
	 * @date 2016年10月14日 上午10:06:15
	 * @parameter  
	 * @return
	 */
	public List<CarAttachmentStock> getListByNameOrNo(Map<String, Object> params)throws Exception;
	public int getListByNameOrNoTotal(Map<String, Object> params) throws Exception;
	public List<CarAttachmentStock> selectCarAttachmentStockBywaybillId(int waybillId)throws Exception;
	
	//折损配件
	public List<CarAttachmentStock> getPageListDam(Map<String, Object> params) throws Exception;
	
	public int getPageTotalCountDam(Map<String, Object> params) throws Exception;
	
	//绑定折损配件 
	public void bindDamAttachment(Map<String, Object> params) throws Exception;

	/**
	 * 
	 * @Description: id查询单独写
	 * @author army.liu 
	 * @param @param params
	 * @param @return    设定文件
	 * @return List<CarAttachmentStock>    返回类型
	 * @throws
	 * @see
	 */
	public List<CarAttachmentStock> getByIds(Map<String, Object> params) throws Exception;
}
