package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.ItemTypeMapper;
import com.jshpsoft.dao.ProcessDetailMapper;
import com.jshpsoft.dao.ProcessMapper;
import com.jshpsoft.dao.StockMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.ItemType;
import com.jshpsoft.domain.ProcessDetail;
import com.jshpsoft.domain.ProcessInfo;
import com.jshpsoft.domain.Stock;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.ProcessService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service
public class ProcessServiceImpl implements ProcessService {

	@Autowired
	private ProcessMapper processMapper;
	
	@Autowired
	private ProcessDetailMapper processDetailMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private StockMapper stockMapper;
	
	@Autowired
	private ItemTypeMapper itemTypeMapper;
	
	@Override
	@SystemServiceLog(description="查询流程列表信息")
	public Pager<ProcessInfo> getPageData(Map<String, Object> params) throws Exception {
		String pageSize;
		try{
			pageSize = params.get("pageSize").toString();
			String pageStartIndex = params.get("pageStartIndex").toString();
			int pageEndIndex = Integer.parseInt(pageStartIndex) + Integer.parseInt(pageSize);
			params.put("pageEndIndex", pageEndIndex);
			
		}catch(Exception e){
			throw new RuntimeException("参数缺失或不正确");
		}
		
		List<ProcessInfo> list = processMapper.getPageList(params);
		if( null != list && list.size()> 0 ){
			for(int i=0; i<list.size(); i++){
				ProcessInfo bean = list.get(i);
				//提交人
				String insertUserId = bean.getInsertUser();
				if( StringUtils.isNotEmpty(insertUserId) ){
					User user = userMapper.getById( Integer.parseInt(insertUserId));
					if( null != user ){
						list.get(i).setInsertUserName( user.getName() );
					}
					
				}
				//仓库名称
				Integer stockId = bean.getStockId();
				if( null != stockId && stockId != 0 ){
					Stock stock = stockMapper.getById( stockId );
					if( null != stock ){
						list.get(i).setStockName( stock.getName() );
					}
					
				}
				//项目类型名称
				Integer itemTypeId = bean.getItemTypeId();
				if(  null != itemTypeId && itemTypeId != 0 ){
					ItemType it = itemTypeMapper.getById( itemTypeId );
					if( null != it ){
						list.get(i).setProcessName( it.getName() );
					}
					
				}
				
			}
		}
		int totalCount = processMapper.getPageTotalCount(params);
		
		Pager<ProcessInfo> pager = new Pager<ProcessInfo>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存流程信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(ProcessInfo bean, String operId) throws Exception {
		
		Integer id = bean.getId();
		if( null == id ){
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setSystemFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			processMapper.insert(bean);
			
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			processMapper.update(bean);
			
		}
		
	}

	@Override
	@SystemServiceLog(description="查询流程详细信息")
	public ProcessInfo getById(Integer id) throws Exception {
		return processMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="删除流程信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void delete(Integer id, String operId) throws Exception {
		ProcessInfo bean = processMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		processMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="查询流程步骤详细信息")
	public List<ProcessDetail> getProcessDetailList(Integer processId)
			throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("processId", processId);
		List<ProcessDetail> pdList = processDetailMapper.getByConditions(params);
		if( null != pdList && pdList.size() > 0 ){
			for(int i=0; i<pdList.size(); i++){
				ProcessDetail pd = pdList.get(i);
				String operateUserId = pd.getOperateUserId();
				if( StringUtils.isNotEmpty(operateUserId) ){
					User user = userMapper.getById( Integer.parseInt(operateUserId) );
					if( null != user ){
						pdList.get(i).setOperateUserName(user.getName());
					}
					
				}
			}
		}
		
		return pdList;
	}

	@Override
	@SystemServiceLog(description="保存流程步骤详细信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void saveProcessDetailList(ProcessInfo bean, String operId)
			throws Exception {
		Integer processId = bean.getId();
		processDetailMapper.deleteByProcessId(processId);
		
		List<ProcessDetail> detailList = bean.getDetailList();
		if( null != detailList && detailList.size() > 0){
			for(int i=0; i<detailList.size(); i++){
				ProcessDetail detail = detailList.get(i);
				detail.setId(null);
				detail.setOrderNo(i);
				detail.setDelFlag(Constants.DelFlag.N);
				detail.setInsertTime(new Date());
				detail.setInsertUser(operId);
				detail.setUpdateTime(new Date());
				detail.setUpdateUser(operId);
				processDetailMapper.insert(detail);
				
			}
			
		}
		
	}

	@Override
	@SystemServiceLog(description="修改流程状态")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void modifyStatus(Integer id, String enabled, String operId) throws Exception{
		ProcessInfo bean = processMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		String status = "";
		if( "Y".equals(enabled) ){
			status = Constants.ProcessStatus.USEING;
		}else{
			status = Constants.ProcessStatus.NEW;
		}
		bean.setStatus(status);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		processMapper.update(bean);
	}

	@Override
	public List<ProcessInfo> getProcessListForOffice(Integer stockId)
			throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("stockId", stockId);
		params.put("systemFlag", Constants.SystemFlag.N);
		params.put("status", Constants.ProcessStatus.USEING);
		List<ProcessInfo> pList = processMapper.getByConditions(params);
		if( null != pList && pList.size() > 0 ){
			for(int i=0; i<pList.size(); i++){
				Integer itemTypeId = pList.get(i).getItemTypeId();
				ItemType it = itemTypeMapper.getById(itemTypeId);
				pList.get(i).setMark(it.getName());
			}
		}
		return pList;
	}

}
