package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.AppVersionMapper;
import com.jshpsoft.domain.AppVersion;
import com.jshpsoft.service.AppVersionService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年10月24日 上午9:49:43
 */
@Service("appVersionService")
public class AppVersionServiceImpl implements AppVersionService {

	@Autowired
	private AppVersionMapper appVersionMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Override
	public Pager<AppVersion> getPageData(Map<String, Object> params)
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
		
		List<AppVersion> list = appVersionMapper.getPageList(params);
		int totalCount = appVersionMapper.getPageTotalCount(params);
		
		Pager<AppVersion> pager = new Pager<AppVersion>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存、修改app版本管理")
	public void save(AppVersion bean, String operId) throws Exception {
		Integer id = bean.getId();
		if( null == id ){
			bean.setStatus(Constants.AppVersionStatus.NEW);
			bean.setDelFlag(Constants.DelFlag.N);
			bean.setInsertTime( new Date() );
			bean.setInsertUser(operId);
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			appVersionMapper.insert(bean);
		}else{
			bean.setUpdateTime(new Date());
			bean.setUpdateUser(operId);
			appVersionMapper.updateByConditions(bean);
			
		}
		
	}

	@Override
	public AppVersion getById(Integer id) throws Exception {
		return appVersionMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="提交app版本管理")
	public void submit(Integer id, String operId) throws Exception {
		AppVersion bean = appVersionMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setStatus(Constants.AppVersionStatus.SUBMIT);
		appVersionMapper.updateByConditions(bean);
	}
	
	@Override
	@SystemServiceLog(description="删除app版本管理")
	public void delete(Integer id, String operId) throws Exception {
		AppVersion bean = appVersionMapper.getById(id);
		if( null == bean ){
			throw new RuntimeException("数据查询不到");
		}
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(operId);
		bean.setDelFlag(Constants.DelFlag.Y);
		appVersionMapper.updateByConditions(bean);
		
	}

	@Override
	@SystemServiceLog(description="更新app版本管理上传地址")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateFilePath(Map<String, Object> params,HttpServletRequest request) throws Exception 
	{
		if(null != params.get("appFilePath") && !"".equals(params.get("appFilePath")))
		{
			String path = params.get("appFilePath").toString().toString();
			String type = appVersionMapper.getById(Integer.parseInt(params.get("id").toString())).getType();
			AppVersion app = new AppVersion();
			if("0".equals(type))//0 苹果
			{
				String newFilePath = commonService.reStoreFile( Constants.UploadType.APPMANAGE_IOS, path , request);
				app.setId(Integer.parseInt(params.get("id").toString()));
				app.setAppFilePath(newFilePath);
			}
			if("1".equals(type))//1 安卓
			{
				String newFilePath = commonService.reStoreFile( Constants.UploadType.APPMANAGE_AND, path , request);
				app.setId(Integer.parseInt(params.get("id").toString()));
				app.setAppFilePath(newFilePath);
			}
			
			appVersionMapper.updateByConditions(app);
		}
	}

	@Override
	public AppVersion getTopOne(Map<String, Object> params) throws Exception {
		return appVersionMapper.getTopOne(params);
	}

}
