package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.MessageMapper;
import com.jshpsoft.dao.OilCardOperateLogMapper;
import com.jshpsoft.dao.OilCardStockMapper;
import com.jshpsoft.domain.OilCardOperateLog;
import com.jshpsoft.domain.OilCardStock;
import com.jshpsoft.service.OilCardOperateLogService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月23日 下午3:41:29
 */
@Service("oilCardOperateLogService")
public class OilCardOperateLogServiceImpl implements OilCardOperateLogService {
	
	@Autowired
	private OilCardOperateLogMapper oilCardOperateLogMapper;
	
	@Autowired
	private OilCardStockMapper oilCardStockMapper;
	
	@Autowired
	private MessageMapper messageMapper;
	
	@Autowired
	private CommonService commonService;

	@Override
	@SystemServiceLog(description="保存，更新油卡收支信息管理")
	public void save(OilCardOperateLog bean, String oper) throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		Integer id = bean.getId();
		if(id == null)
		{
			if("1".equals(bean.getType()))//支出
			{
				Map<String,Object> params = new HashMap<String, Object>();
				params.put("receiveUserId", bean.getReceiveUserId());
				params.put("oilCardNo", bean.getOilCardNo());
				List<OilCardOperateLog> list = oilCardOperateLogMapper.getByConditions(params);
				if(null != list && list.size() > 0)
				{
					throw new RuntimeException("该使用人、卡号已重复");
				}
			}
			
			bean.setApplyMoney(bean.getMoney());
			bean.setStatus(Constants.OilCardOperateStatus.NEW);
     		bean.setInsertUser(oper);
			bean.setInsertTime(new Date());
			bean.setDelFlag(Constants.DelFlag.N);
			oilCardOperateLogMapper.insert(bean);
		}
		else
		{
			if("1".equals(bean.getType()))//支出
			{
				Map<String,Object> params = new HashMap<String, Object>();
				params.put("receiveUserId", bean.getReceiveUserId());
				params.put("oilCardNo", bean.getOilCardNo());
				List<OilCardOperateLog> list = oilCardOperateLogMapper.getByConditions(params);
				if(null != list && list.size() > 0)
				{
					if(!bean.getId().equals(list.get(0).getId())){
						throw new RuntimeException("该使用人、卡号已重复");
					}
				}
			} 
			bean.setApplyMoney(bean.getMoney());
			bean.setUpdateUser(oper);
     		bean.setUpdateTime(new Date());
     		oilCardOperateLogMapper.update(bean);
		}
		
	}

	@Override
	@SystemServiceLog(description="删除油卡收支信息管理")
	public void delete(int id, String oper) throws Exception {
		OilCardOperateLog bean = new OilCardOperateLog();
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.Y);
		bean.setId(id);
		oilCardOperateLogMapper.update(bean);
		
	}

	@Override
	public Pager<OilCardOperateLog> getPageData(Map<String, Object> params)
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
		
		List<OilCardOperateLog> list = oilCardOperateLogMapper.getPageList(params);
		int totalCount = oilCardOperateLogMapper.getPageTotalCount(params);
		
		Pager<OilCardOperateLog> pager = new Pager<OilCardOperateLog>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	public OilCardOperateLog getById(Integer id) throws Exception {
		return oilCardOperateLogMapper.getById(id);
	}

	@Override
	public void submit(int id, String oper) throws Exception {
		OilCardOperateLog bean = oilCardOperateLogMapper.getById(id);
		if(bean == null)
		{
			throw new RuntimeException("查询实体不存在");
		}
		if(null != bean.getType() && !"".equals(bean.getType()))
		{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(oper);
			bean.setStatus(Constants.OilCardOperateStatus.FINISH);//已完成
			oilCardOperateLogMapper.update(bean);
			
		}
		
		
	}

	@Override
	@SystemServiceLog(description="确认油卡收支信息")
	public OilCardOperateLog dosure(int id, String oper) throws Exception {
		OilCardOperateLog bean = oilCardOperateLogMapper.getById(id);
		if(bean == null)
		{
			throw new RuntimeException("查询实体不存在");
		}
		double chong = 0;
		double xiaofei = 0;
		 
		Map<String,Object> p = new HashMap<String, Object>();
		p.put("receiveUser",bean.getReceiveUserId());
		p.put("delFlag", Constants.DelFlag.N);
		List<OilCardStock> ol = oilCardStockMapper.getByConditions(p);
		Map<String,Object> params = new HashMap<String, Object>();
		if(null != ol && ol.size() > 0)
		{
			for(int j = 0;j<ol.size();j++)
			{
				//充值
				params.put("oilCardNo", ol.get(j).getCardNo());
				params.put("type", "0");
				params.put("status", Constants.OilCardOperateStatus.FINISH);//已完成
				List<OilCardOperateLog> cList = oilCardOperateLogMapper.getByConditions(params);
				if(null != cList && cList.size() > 0)
				{
					for(int i = 0;i<cList.size();i++)
					{
						chong += cList.get(i).getMoney();
					}
				}
			}
		}
		
		//消费
		params.clear();
		params.put("receiveUserId", bean.getReceiveUserId());
		params.put("type", "1");
		params.put("status", Constants.OilCardOperateStatus.FINISH);//已完成
		List<OilCardOperateLog> chuList = oilCardOperateLogMapper.getByConditions(params);
		if(null != chuList && chuList.size() > 0)
		{
			for(int i = 0; i< chuList.size();i++)
			{
				xiaofei +=chuList.get(i).getMoney();
			}
		}
		
		bean.setJieyu(chong-xiaofei);
		return bean;
		
	}

	@Override
	@SystemServiceLog(description="确认保存油卡收支信息")
	public void sureSave(Map<String, Object> params) throws Exception {
		params.put("status", Constants.OilCardOperateStatus.FINISH);
		oilCardOperateLogMapper.updateById(params);
		
		OilCardOperateLog bean = oilCardOperateLogMapper.getById(Integer.parseInt(params.get("id").toString()));
		if(bean == null)
		{
			throw new RuntimeException("查询实体不存在");
		}
		
		//推送消息给驾驶员
		String content = "新消息："+bean.getMark()+"确认完成!";
		commonService.pushMsgToUser(Integer.parseInt(bean.getReceiveUserId()), content );
		
		//推送消息给驾驶员
		/*Message message = new Message();
		message.setReceiveUserId(Integer.parseInt(bean.getReceiveUserId()) );
		message.setMark("新消息："+bean.getMark()+"确认完成！");
		message.setStatus("N");//未阅
		message.setInsertUser(params.get("oper").toString());
		message.setInsertTime(new Date());
		message.setDelFlag(Constants.DelFlag.N);
		messageMapper.insert(message);*/
	}

	@Override
	public List<OilCardOperateLog> getByConditions(Map<String, Object> params)
			throws Exception {
		
		return oilCardOperateLogMapper.getByConditions(params);
	}

}
