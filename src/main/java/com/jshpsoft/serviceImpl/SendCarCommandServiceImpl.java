package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.SendCarCommandMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.SendCarCommand;
import com.jshpsoft.domain.Track;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.SendCarCommandService;
import com.jshpsoft.service.TrackService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.CommonUtil;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月3日 上午11:00:17
 */
@Service("sendCarCommandService")
public class SendCarCommandServiceImpl implements SendCarCommandService {
	
	@Autowired
	private SendCarCommandMapper sendCarCommandMapper;
	
	@Autowired
	private TrackService trackService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public List<SendCarCommand> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return sendCarCommandMapper.getByConditions(params);
	}

	@Override
	public Pager<SendCarCommand> getPageData(Map<String, Object> params)
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
		
		params.put("delFlag", Constants.DelFlag.N);
		List<SendCarCommand> list = sendCarCommandMapper.getPageList(params);
		int totalCount = sendCarCommandMapper.getPageTotalCount(params);
		
		Pager<SendCarCommand> pager = new Pager<SendCarCommand>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存、修改派车指令")
	public void save(SendCarCommand bean, String oper) throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		if(null == bean.getId())
		{
			bean.setInsertUser(oper);
			bean.setInsertTime(new Date());
			bean.setStatus(Constants.SendCarCommandStatus.NEW);
			bean.setDelFlag(Constants.DelFlag.N);
			sendCarCommandMapper.insert(bean);
		}
		else
		{
			bean.setUpdateUser(oper);
			bean.setUpdateTime(new Date());
			sendCarCommandMapper.update(bean);
		}
	}

	@Override
	@SystemServiceLog(description="删除派车指令")
	public void delete(Integer id, String oper) throws Exception {
		SendCarCommand bean = new SendCarCommand();
		bean.setUpdateUser(oper);
		bean.setUpdateTime(new Date());
		bean.setDelFlag(Constants.DelFlag.Y);
		bean.setId(id);
		sendCarCommandMapper.update(bean);
		
	}

	@Override
	public SendCarCommand getById(Integer id) throws Exception {
		return sendCarCommandMapper.getById(id);
	}

	@Override
	public SendCarCommand getNewOne(String carNumber) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("carNumber", carNumber);
		params.put("status", Constants.SendCarCommandStatus.FINISH);//已完成状态
		return sendCarCommandMapper.getTopOne(params);
	}

	@Override
	@SystemServiceLog(description="提交派车指令")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id,String oper) throws Exception {
		SendCarCommand bean = sendCarCommandMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("派车指令信息不存在！");
		}
		bean.setUpdateUser(oper);
		bean.setUpdateTime(new Date());
		bean.setStatus(Constants.SendCarCommandStatus.SUBMIT);
		sendCarCommandMapper.update(bean);
		
		//根据车号，获取下一步接收人为：驾驶员
		Track t = trackService.getByCarNumber(bean.getCarNumber());
		if( null == t ){
			throw new RuntimeException("装运车辆信息不存在！");
		}

		int nextUserId = t.getDriverId();

		//添加到流程中
		String itemName = CommonUtil.getProcessName(Constants.ProcessType.PCZLSQD, bean.getCarNumber()+": 从"+bean.getStartAddress()+"发往"+bean.getEndAddress());
		commonService.addToProcessForPCZL( 
				Constants.ProcessType.PCZLSQD, 
				id, 
				Integer.parseInt(oper), 
				itemName,
				nextUserId
				);
		
		//提交后，同时发送消息给运营负责人
		User curr = userMapper.getById( Integer.parseInt(bean.getInsertUser()) );
		if( null == curr.getParentId() || 0 == curr.getParentId() ){
			throw new RuntimeException("请联系管理员设置您的上级人员信息！");
		}
		int operMangeUserId = curr.getParentId();
		String content = "新消息：" + itemName;
		commonService.pushMsgToUser( operMangeUserId, content );
		
	}

	@Override
	@SystemServiceLog(description="审核确认派车指令")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void auditForConfirm(int id, int status, int oper) throws Exception {
		SendCarCommand sendCarCommand = sendCarCommandMapper.getById(id);
		if( null == sendCarCommand ){
			throw new RuntimeException("派车指令信息不存在！");
		}
		sendCarCommand.setUpdateUser(oper+"");
		sendCarCommand.setUpdateTime(new Date());
		sendCarCommand.setStatus(status+"");
		sendCarCommandMapper.update(sendCarCommand);
		
	}
	
}
