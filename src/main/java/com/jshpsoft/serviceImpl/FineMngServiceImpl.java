package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.FineMapper;
import com.jshpsoft.domain.Fine;
import com.jshpsoft.service.FineMngService;
import com.jshpsoft.util.Constants;

/**
 * @author  ww 
 * @date 2016年12月3日 上午10:27:57
 */
@Service("fineMngService")
public class FineMngServiceImpl implements FineMngService {

	@Autowired
	private FineMapper fineMapper;
	
	@Override
	@SystemServiceLog(description="保存、修改罚款比例信息")
	public void save(Fine bean,String operId) throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		if(null == bean.getId())
		{
			bean.setInsertUser(operId);
			bean.setInsertTime(new Date());
			bean.setDelFlag(Constants.DelFlag.N);
			fineMapper.insert(bean);
		}
		else
		{
			bean.setUpdateUser(operId);
			bean.setUpdateTime(new Date());
			fineMapper.update(bean);
		}
	}

	@Override
	public List<Fine> getByConditions(Map<String, Object> params)
			throws Exception {
		return fineMapper.getByConditions(params);
	}

	@Override
	public Fine getById(Integer id) throws Exception {
		return fineMapper.getById(id);
	}

}
