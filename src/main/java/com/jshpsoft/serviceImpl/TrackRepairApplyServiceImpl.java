package com.jshpsoft.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarDamageStockMapper;
import com.jshpsoft.dao.TrackRepairApplyMapper;
import com.jshpsoft.domain.CarDamageStock;
import com.jshpsoft.domain.TrackRepairApply;
import com.jshpsoft.service.TrackRepairApplyService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.Pager;
/**
 * 折损维修登记serviceImpl
* @author  lvhao 
* @date 2016年12月21日 上午8:35:59
 */
@Service
public class TrackRepairApplyServiceImpl implements TrackRepairApplyService {
	@Autowired
	private TrackRepairApplyMapper trackRepairApplyMapper ;
	
	@Autowired
	private CarDamageStockMapper carDamageStockMapper;
	@Override
	public Pager<TrackRepairApply> getPageData(Map<String, Object> params)
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
		List<TrackRepairApply> list = trackRepairApplyMapper.getPageList(params);
		int totalCount = trackRepairApplyMapper.getPageTotalCount(params);
		Pager<TrackRepairApply> pager = new Pager<TrackRepairApply>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="修改折损维修登记")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int save(TrackRepairApply apply) throws Exception {
		       apply.setInsertTime(new Date());
		       apply.setDelFlag(Constants.DelFlag.N);
		       apply.setStatus(Constants.TrackRepairApplyStatus.NEW);
		return trackRepairApplyMapper.save(apply);
	}

	@Override
	public List<CarDamageStock> getDamageStocks() throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("status", Constants.CarStatus.HASIN);
		return carDamageStockMapper.getByConditions(params);
	}

	@Override
	public TrackRepairApply getDetail(int id) throws Exception {
		
		return trackRepairApplyMapper.getDetail(id);
	}

	@Override
	@SystemServiceLog(description="修改折损维修登记")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int update(TrackRepairApply apply) throws Exception {
		if( null == apply || null == apply.getId() ){
			throw new RuntimeException("id为空");
		}
		
		return trackRepairApplyMapper.update(apply);
	}

	@Override
	@SystemServiceLog(description="删除折损维修登记")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int delete(TrackRepairApply apply) throws Exception {
		if( null == apply || null == apply.getId() ){
			throw new RuntimeException("id为空");
		}
		
		return trackRepairApplyMapper.update(apply);
	}

	@Override
	@SystemServiceLog(description="提交折损维修登记")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int submit(TrackRepairApply apply) throws Exception {
		if( null == apply || null == apply.getId() ){
			throw new RuntimeException("id为空");
		}
		
		return trackRepairApplyMapper.update(apply);
	}

	@Override
	public int confirm(TrackRepairApply apply) throws Exception {
		if( null == apply || null == apply.getId() ){
			throw new RuntimeException("id为空");
		}
		
		return trackRepairApplyMapper.update(apply);
	}

	@Override
	public List<TrackRepairApply> getPrint(Map<String, Object> params)
			throws Exception {
		
		return trackRepairApplyMapper.getByConditions(params);
	}

	@Override
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
				//得到收支数据
				params.put("delFlag", Constants.DelFlag.N);
				List<TrackRepairApply> list = trackRepairApplyMapper.getByConditions(params);
				//构造导出表格
				Map<String, Object> formatData = new HashMap<String, Object>();
				// sheet
				List<String> sheetList = new ArrayList<String>();
				sheetList.add("sheet");
				formatData.put("sheetList", sheetList);
				// 标题
				Map<String, Object> sheetData = new HashMap<String, Object>();
				sheetData.put("title", "折损维修登记信息");//
				sheetData.put("titleMergeSize", 11);//导出数据的列数
				// 表头
				List<String> tableHeadList = new ArrayList<String>();
				tableHeadList.add("序号");
				tableHeadList.add("折损车架号");
				tableHeadList.add("维修项目");
				tableHeadList.add("维修厂");
				tableHeadList.add("维修电话");
				tableHeadList.add("预计修好时间");
				tableHeadList.add("状态");
				tableHeadList.add("登记人");
				tableHeadList.add("登记时间");
				tableHeadList.add("取车人");
				tableHeadList.add("取车时间");
				sheetData.put("tableHeader", tableHeadList);

				SimpleDateFormat sdf = new SimpleDateFormat(Constants.DATE_TIME_FORMAT);
				
				// 表数据
				List<List<String>> tableData = new ArrayList<List<String>>();
				for(int i=0;i<list.size();i++){
					//获取每一行数据
					 TrackRepairApply trackRepairApply = list.get(i);
					//加载数据
					List<String> rowData = new ArrayList<String>();
					rowData.add(String.valueOf(i+1));
					rowData.add(null == trackRepairApply.getVin() ? "" :trackRepairApply.getVin() );
					rowData.add(null == trackRepairApply.getRepairContent() ? "" :trackRepairApply.getRepairContent() );
					rowData.add(null == trackRepairApply.getRepairCompany() ? "" :trackRepairApply.getRepairCompany() );
					rowData.add(null == trackRepairApply.getRepairTelephone() ? "" :trackRepairApply.getRepairTelephone() );
					rowData.add(null == trackRepairApply.getRepairFinishedTime() ? "" :sdf.format(trackRepairApply.getRepairFinishedTime()) );
					switch (null == trackRepairApply.getStatus() ? "" : trackRepairApply.getStatus() ) {
					case Constants.TrackRepairApplyStatus.NEW:
						rowData.add("新建");
						break;
					case Constants.TrackRepairApplyStatus.ING:
						rowData.add("修理中");
						break;
					case Constants.TrackRepairApplyStatus.FINISH:
						rowData.add("已完成");
						break;
					default:
						break;
					}
					rowData.add(null == trackRepairApply.getName() ? "" :trackRepairApply.getName() );
					rowData.add(null == trackRepairApply.getApplyTime() ? "" :sdf.format(trackRepairApply.getApplyTime()) );
					rowData.add(null == trackRepairApply.getFinishUser() ? "" :trackRepairApply.getFinishUser());
					rowData.add(null == trackRepairApply.getFinishTime() ? "" :sdf.format(trackRepairApply.getFinishTime()) );
					tableData.add(rowData);
				}
				sheetData.put("tableData", tableData);
				formatData.put("sheetData", sheetData);
				
				return formatData;
	}

	
	
}
