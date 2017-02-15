package com.jshpsoft.serviceImpl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.DepartmentMapper;
import com.jshpsoft.domain.Department;
import com.jshpsoft.service.DepartmentService;
import com.jshpsoft.util.Constants;

/**
 * @author  ww 
 * @date 2016年9月27日 上午9:54:06
 */
@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Override
	public List<Department> getByConditions(Map<String, Object> params)
			throws Exception {
		return departmentMapper.getByConditions(params);
	}

	@Override
	public Department getById(int id) throws Exception {
		
		return departmentMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="插入部门信息")
	public void insert(Department bean) throws Exception {
		bean.setInsertTime(new Date());
		bean.setDelFlag(Constants.DelFlag.N);
		departmentMapper.insert(bean);

	}

	@Override
	@SystemServiceLog(description="修改部门信息")
	public int update(Department bean) throws Exception {
		bean.setUpdateTime(new Date());
		departmentMapper.update(bean);
		return 0;
	}

	@Override
	@SystemServiceLog(description="逻辑删除部门信息")
	public void delete(Map<String, Object> params) throws Exception {
		params.put("updateTime", new Date());
		params.put("delFlag", Constants.DelFlag.Y);
		departmentMapper.delete(params);
	}

}
