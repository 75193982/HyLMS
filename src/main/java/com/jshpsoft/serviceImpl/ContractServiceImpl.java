package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.ContractMapper;
import com.jshpsoft.dao.OutSourcingMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.Contract;
import com.jshpsoft.service.ContractService;
import com.jshpsoft.service.common.CommonService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;

@Service("contractService")
public class ContractServiceImpl implements ContractService {
	
	@Autowired
	private ContractMapper contractMapper;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private OutSourcingMapper outSourcingMapper;
	
	@Autowired
	private CommonService commonService;
	
	@Override
	@SystemServiceLog(description="查询合同信息")
	public List<Contract> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return contractMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询合同列表信息")
	public Pager<Contract> getPageData(Map<String, Object> params) throws Exception {
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
		List<Contract> list = contractMapper.getPageList(params);
		
		//根据type获取主体名称
		if(null != list){
			for(int i=0;i<list.size();i++){
				Contract contract = list.get(i);
				
				if(contract.getType().equals("0")){//员工
					contract.setMainName(userMapper.getById(contract.getMainId()).getName());
				}else{//外协单位
					contract.setMainName(outSourcingMapper.getById(contract.getMainId()).getName());
				}
			}
		}
		int totalCount = contractMapper.getPageTotalCount(params);
		
		Pager<Contract> pager = new Pager<Contract>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增合同信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(Contract bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("合同信息为空");
		}
		
		//验证该合同名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", bean.getCode());
		params.put("delFlag", Constants.DelFlag.N);
		List<Contract> contract = contractMapper.getByConditions(params);
		if(null !=contract && contract.size()>0){
			throw new RuntimeException("该合同编号已存在，请检查");
		}
		
		//插入合同表
		bean.setStatus(Constants.ContractStatus.NEW);//新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		contractMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取合同明细")
	public Contract getById(Integer id) throws Exception {
		return contractMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新合同信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(Contract bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("合同信息为空");
		}
		
		//验证该合同名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("code", bean.getCode());
		params.put("delFlag", Constants.DelFlag.N);
		List<Contract> contract = contractMapper.getByConditions(params);
		if(null !=contract && contract.size()>0 && (int)contract.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该合同编号已存在，请检查");
		}
		
		//更新合同数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		contractMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除合同信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		contractMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="更新附件地址")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateFilePath(Map<String, Object> params,HttpServletRequest req) throws Exception {
		
		String filePath = String.valueOf( params.get("filePath") );
		String newFilePath = commonService.reStoreFile( Constants.UploadType.CONTRACT, filePath , req);
		
		params.put("filePath", newFilePath);
		contractMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="提交合同信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("status", Constants.ContractStatus.EFFECT);
		contractMapper.updateById(params);
	}

}
