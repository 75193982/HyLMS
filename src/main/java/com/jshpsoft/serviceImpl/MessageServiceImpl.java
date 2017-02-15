package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.dao.MessageMapper;
import com.jshpsoft.domain.Message;
import com.jshpsoft.service.MessageService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("messageService")
public class MessageServiceImpl implements MessageService{

	@Autowired
	private MessageMapper messageMapper;
	
	@Override
	public Pager<Message> getPageData(Map<String, Object> params)
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
		
		
		List<Message> list = messageMapper.getPageList(params);
		int totalCount = messageMapper.getPageTotalCount(params);
		
		Pager<Message> pager = new Pager<Message>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	public Message getById(Integer id) throws Exception {
		return messageMapper.getById(id);
	}

	@Override
	public void updateRead(Integer id, String operId) throws Exception {
		Message bean = messageMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setStatus(Constants.ReadFlag.Y);
		messageMapper.update(bean);
	}

	@Override
	public int getUnReadMsgCount(int userId) throws Exception {
		
		return messageMapper.getUnReadMsgCount(userId);
	}

}
