package com.jshpsoft.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarStockMapper;
import com.jshpsoft.domain.CarStock;
import com.jshpsoft.service.CarStockService;
@Service
public class CarStockServiceImpl implements CarStockService {
	@Autowired
	private CarStockMapper carStockMapper;
	@Override
	public List<CarStock> queryCarStockByStatus(Map<String, Object> params)
			throws Exception {
		List<CarStock> list = carStockMapper.queryCarStockByStatus(params);
		return list;
	}
	@Override
	@Transactional
	@SystemServiceLog(description="运单管理：绑定商品车")
	public int bindCarStock(Map<String, Object> params) {
		try {

			String ids= (String) params.get("ids");
			String[] idGroup = ids.split(",");
			for (int i = 0; i <idGroup.length ; i++) {
				params.put("ids", idGroup[i]);
				carStockMapper.bindCarStock(params);
			}
			return 1 ;
		} catch (Exception e) {
			e.printStackTrace();			
		}
	
		
		return 0;
	}
	
	@Override
	@Transactional
	@SystemServiceLog(description="运单管理：绑定商品车")
	public int batchBindCarStock(Map<String, Object> params) throws Exception {
		try {
			carStockMapper.batchCancelBindCarStock((int) params.get("waybillId"));
			String ids= (String) params.get("ids");
			if(null != ids && !"".equals(ids))
			{
				String[] idGroup = ids.split(",");
				for (int i = 0; i <idGroup.length ; i++) {
					params.put("ids", idGroup[i]);
					carStockMapper.bindCarStock(params);
				}
			}
			return 1 ;
	
	}catch (Exception e) {
		e.printStackTrace();			
	}

		return 0;
	}
}
