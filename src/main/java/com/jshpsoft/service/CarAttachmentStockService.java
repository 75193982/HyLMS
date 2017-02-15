package com.jshpsoft.service;

import java.util.List;
import java.util.Map;

import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarAttachmentStockInOutAndUser;
import com.jshpsoft.domain.CarAttachmentStockInOutDetail;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.util.Pager;

/**
 * 
 * @author  ww 
 * @date 2016年9月26日 下午1:23:56
 */
public interface CarAttachmentStockService {

	public List<Waybill> getWaybillList(Map<String, Object> params) throws Exception;
	public List<CarAttachmentStock> getByConditions(Map<String, Object> params) throws Exception;
	public void save(CarAttachmentStock bean,String stockId,String userName) throws Exception;
	public CarAttachmentStock getById(int id) throws Exception;
	
	public void update(CarAttachmentStock bean) throws Exception;
	
	public void delete(Map<String, Object> params) throws Exception;
	//库存数据
	public Pager<CarAttachmentStock> getPageData(Map<String, Object> params)  throws Exception;
	//得到配件出入库查询数据
	public Pager<CarAttachmentStockInOutAndUser> getInOutPageData(Map<String, Object> params)  throws Exception;
	
	public Pager<CarAttachmentStockInOutDetail> getDetailByParentId(Map<String, Object> params) throws Exception;
	
//	/**
//	 * 提交保存配件入库 
//	 * @author  ww 
//	 * @date 2016年10月12日 下午3:48:44
//	 * @parameter  waybillId--运单编号id,insertUser--操作人id
//	 * @return
//	 */
//	public void submit(Map<String, Object> params)throws Exception;
//	
	
	/**
	 * 审核通过
	 * @author  ww 
	 * @date 2016年10月12日 下午3:50:57
	 * @parameter  waybillId--运单编号id,insertUser--操作人id
	 * @return
	 */
	public void checked(Map<String, Object> params)throws Exception;
	
	
//	/**
//	 * 审核不通过
//	 * @author  ww 
//	 * @date 2016年10月12日 下午3:51:00
//	 * @parameter  waybillId--运单编号id,insertUser--操作人id
//	 * @return
//	 */
//	public void unChecked(Map<String, Object> params)throws Exception;
	
	/**
	 * 查询需要绑定的配件
	 * lvhao
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<CarAttachmentStock> queryCarAttachmentStock(Map<String, Object> params) throws Exception;
	/**
	 * 运单绑定配件
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int bindCarAttachment(Map<String, Object> params) throws Exception;
	
	
	/**
	 * 运单批量绑定配件+取消
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int batchBindCarAttachment(Map<String, Object> params) throws Exception;
	
	/**
	 * 取消 绑定的配件
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public int cancelBindCarAttachment(int id)throws Exception;
	
//	/**
//	 * 提交(保存配件出库单数据)
//	 * @author  ww 
//	 * @date 2016年10月13日 上午11:27:08
//	 * @parameter  scheduleBillNo--调度单号，userId
//	 * @return
//	 */
//	public void submitSchedule(Map<String, Object> params) throws Exception;
	
	/**
	 * 审核通过
	 * @author  ww 
	 * @date 2016年10月13日 下午12:47:32
	 * @parameter  scheduleBillNo--调度单号，userId
	 * @return
	 */
	public void checkedSchedule(Map<String, Object> params) throws Exception;
	
//	/**
//	 * 审核不通过
//	 * @author  ww 
//	 * @date 2016年10月13日 下午12:48:50
//	 * @parameter  scheduleBillNo--调度单号，userId
//	 * @return
//	 */
//	public void unCheckedSchedule(Map<String, Object> params) throws Exception;
	
	public Pager<CarAttachmentStock>getPageByNameOrNo(Map<String, Object> params) throws Exception;
	
	//折损配件
	public Pager<CarAttachmentStock> getPageDataDam(Map<String, Object> params)  throws Exception;
	
	//判断折损配件是否存在该入库单
	public List<CarAttachmentStock> checkRuAttWaybillId(Map<String, Object> params) throws Exception;
	
	//折损配件保存
	public void saveZS(CarAttachmentStock bean,String stockId,String userName) throws Exception;
	
	//修改折损配件
	public void updateZS(CarAttachmentStock bean) throws Exception;
	
}
