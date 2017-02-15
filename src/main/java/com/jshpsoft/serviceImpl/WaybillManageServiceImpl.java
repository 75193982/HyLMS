package com.jshpsoft.serviceImpl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarAttachmentStockMapper;
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.dao.WaybillMapper;
import com.jshpsoft.domain.CarAttachmentStock;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.domain.Waybill;
import com.jshpsoft.service.CarAttachmentStockService;
import com.jshpsoft.service.CarStockMangeService;
import com.jshpsoft.service.WaybillManageService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;
@Service("waybillManageService")
public class WaybillManageServiceImpl implements WaybillManageService {
	@Resource
	private WaybillMapper waybillMapper ;
	@Resource
	private CarStockMapper carStockMapper ;
	@Resource
	private CarAttachmentStockMapper attachmentStockMapper;
	@Resource
	private CarAttachmentStockMapper attachmentMngMapper;
	@Resource
	private CommonService commonService;
	@Resource
	private CarStockMangeService carStockMangeService;
	@Resource
	private  CarAttachmentStockService carAttachmentStockService;
	@Override
	@SystemServiceLog(description="插入运单")
	public void insertWaybill(Waybill waybill, HttpServletRequest req) throws Exception {
		
		//附件处理
		String attachFileName = waybill.getAttachFileName();
		if( StringUtils.isNotEmpty(attachFileName) ){
			String attachFilePath = waybill.getAttachFilePath();
			String newFilePath = commonService.reStoreFile( Constants.UploadType.WAYBILL, attachFilePath , req);
			waybill.setAttachFilePath( newFilePath );
			waybill.setAttachFileName(attachFileName);
		}
		
			waybill.getStartAddress().trim();
			/*if(null != waybill.getStartAddress() && !"".equals(waybill.getStartAddress()))
			{
				//判断最后一个 字是否等于“市”
				if(!"市".equals(waybill.getStartAddress().substring(waybill.getStartAddress().length()-1,waybill.getStartAddress().length())))
				{
					waybill.setStartAddress(waybill.getStartAddress()+"市");
				}
			}*/
			waybill.getTargetProvince().trim();
			waybill.getTargetCity().trim();
			waybill.setStatus(Constants.WaibillStatus.NEW.getValue());			
			waybillMapper.insertWaybill(waybill);
		
	
	}
	
	@Override
	@SystemServiceLog(description="查询运单")
	public Pager<Waybill> getWaybillList(Map<String, Object> params)
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
		List<Waybill> waybillList = waybillMapper.getWaybillList(params);
		int totalCount = waybillMapper.getWaybillCount(params);
		Pager<Waybill> pager = new Pager<Waybill>();
		pager.setRecords(waybillList);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="按id删除运单")
	public int deleteWaybill(int id) throws Exception {
		Waybill waybill = waybillMapper.queryWaybill(id);
		if(null != waybill && !waybill.getStatus().equals(Constants.WaibillStatus.NEW.getValue())){
			return -1 ;
		}
		
		List<CarStock> queryCarStock = carStockMapper.queryCarStock(id);
		if( !queryCarStock.isEmpty() ||queryCarStock.size() > 0 ){
			return -2 ;
		}
		
		
		List<CarAttachmentStock> list = attachmentStockMapper.selectCarAttachmentStockBywaybillId(id);
		if( !list.isEmpty() ||list.size() > 0 ){
			return -3 ;
		}
		
		return waybillMapper.deleteWaybill(id);
		
	}

	@Override
	@SystemServiceLog(description="按id查询运单")
	public Waybill queryWaybill(int id) throws Exception {
		
		return waybillMapper.queryWaybill(id);
	}

	@Override
	@SystemServiceLog(description="修改运单")
	public int updateWaybill(Waybill waybill, HttpServletRequest req) throws Exception {
		Waybill queryWaybill = waybillMapper.queryWaybill(waybill.getId());
//		if(null !=queryWaybill && !queryWaybill.getStatus().equals(Constants.WaibillStatus.NEW.getValue())){
//			return -1 ;
//		}
		
		//附件处理
		String attachFileName = waybill.getAttachFileName();
		if( StringUtils.isNotEmpty(attachFileName) && !attachFileName.equals( queryWaybill.getAttachFileName() )){
			String attachFilePath = waybill.getAttachFilePath();
			String newFilePath = commonService.reStoreFile( Constants.UploadType.WAYBILL, attachFilePath , req);
			waybill.setAttachFilePath( newFilePath );
			waybill.setAttachFileName(attachFileName);
		}
		waybill.getStartAddress().trim();
		/*if(null != waybill.getStartAddress() && !"".equals(waybill.getStartAddress()))
		{
			//判断最后一个 字是否等于“市”
			if(!"市".equals(waybill.getStartAddress().substring(waybill.getStartAddress().length()-1,waybill.getStartAddress().length())))
			{
				waybill.setStartAddress(waybill.getStartAddress()+"市");
			}
		}*/
		waybill.getTargetProvince().trim();
		waybill.getTargetCity().trim();	
		return waybillMapper.updateWaybill(waybill);
	}

	@Override
	@Transactional
	@SystemServiceLog(description="提交运单、绑定商品车、配件")
	public int submitWaybill(Map<String, Object> params) throws Exception {
		params.put("status", Constants.WaibillStatus.NEW.getValue());
		int pageTotalCount = carStockMapper.selectCountById(params);
		if( pageTotalCount <=0 )
			return -1 ;
		
		params.put("status", Constants.WaibillStatus.UNREVIEW.getValue());
		int waybill = waybillMapper.submitWaybill(params);

		//添加到流程中
		String waybillNo = "";
		Waybill waybillBean = waybillMapper.getById( Integer.parseInt(params.get("id").toString()));
		if( null != waybillBean ){
			waybillNo = waybillBean.getWaybillNo();
			commonService.addToProcess( 
					Constants.ProcessType.YD, 
					Integer.parseInt(params.get("id").toString()), 
					Integer.parseInt(params.get("operId").toString()), 
					CommonUtil.getProcessName(Constants.ProcessType.YD, waybillNo)
					);
			
		}
		
		return waybill ;

	}

	
	
	
	
	@Override
	@Transactional
	@SystemServiceLog(description="撤回运单、绑定商品车、配件")
	public int cancelWaybill(Map<String, Object> params) throws Exception {	
		
		Waybill checkWaybill = waybillMapper.queryWaybill((int) params.get("id"));
		if(!checkWaybill.getStatus() .equals(Constants.WaibillStatus.UNREVIEW.getValue())){
			return -1 ;
		}

		params.put("status", Constants.WaibillStatus.NEW.getValue());
		int waybill = waybillMapper.submitWaybill(params);
		if(waybill > 0 ){
			int carStock = carStockMapper.submitCarStock(params);
			if(carStock > 0 )
			attachmentMngMapper.submitCarAttachment(params);
			
			return waybill ;
		}
			
		return 0;
		
	}

	@Override
	@SystemServiceLog(description="查看运单绑定的商品车、配件")
	public Waybill checkWaybill(int id) throws Exception {
		Waybill waybill = waybillMapper.queryWaybill(id);
		
		if(null != waybill){
			List<CarStock> list = carStockMapper.queryCarStock(id);
			double amount = 0;
			if(null != list && list.size() > 0)
			{
				for(int i = 0;i<list.size();i++)
				{
					if(Constants.CarStockType.ESC.equals(list.get(i).getType()))//二手车
					{
						if(null != list.get(i).getTransportPrice())
						{
							amount +=list.get(i).getTransportPrice().doubleValue();
						}
						
					}
				}
			}
			waybill.setAmount(new BigDecimal(amount));
			waybill.setCarStockList(list);
			 List<CarAttachmentStock> list2 = attachmentMngMapper.queryCarAttachment(id);
			waybill.setCarAttachmentStockList(list2);
		}
		
		return waybill;
	}

	@Override
	@Transactional
	public void auditSuccess(int waybillId, int status, int userId)throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", waybillId);
		params.put("status", status);
		params.put("insertUser", userId);
		waybillMapper.submitWaybill(params);	
		
		carStockMangeService.verifySuccess(waybillId, String.valueOf(userId));
		
		params.put("waybillId", waybillId);
		carAttachmentStockService.checked(params);
		
	}

	@Override
	@Transactional
	public void auditFail(int waybillId, int status, int operId)throws Exception {
		auditForConfirm(waybillId, status, operId);
	}

	@Override
	public void auditForConfirm(int waybillId, int status, int operId) throws Exception {
		Waybill wb = waybillMapper.getById( waybillId );
		wb.setStatus(status+"");
		wb.setUpdateTime( CommonUtil.format(new Date(), Constants.DATE_TIME_FORMAT ));
		wb.setUpdateUser(operId+"");
		waybillMapper.updateWaybill(wb);
		
	}
	
}
