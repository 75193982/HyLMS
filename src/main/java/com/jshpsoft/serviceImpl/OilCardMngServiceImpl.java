package com.jshpsoft.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CashInOutMapper;
import com.jshpsoft.dao.OilCardOperateLogMapper;
import com.jshpsoft.dao.OilCardStockMapper;
import com.jshpsoft.dao.UserMapper;
import com.jshpsoft.domain.CashInOut;
import com.jshpsoft.domain.OilCardOperateLog;
import com.jshpsoft.domain.OilCardStock;
import com.jshpsoft.domain.User;
import com.jshpsoft.service.OilCardMngService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.ExcelReader;
import com.jshpsoft.util.Pager;

@Service("oilCardMngService")
public class OilCardMngServiceImpl implements OilCardMngService {
	
	@Autowired
	private OilCardStockMapper oilCardStockMapper;
	
	@Autowired
	private OilCardOperateLogMapper oilCardOperateLogMapper;
	
	@Autowired
	private CashInOutMapper cashInOutMapper;
	
	@Autowired
	private UserMapper userMapper;

	@Override
	@SystemServiceLog(description="获取油卡信息")
	public List<OilCardStock> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return oilCardStockMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="获取油卡信息")
	public Pager<OilCardStock> getPageData(Map<String, Object> params)
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
		List<OilCardStock> list = oilCardStockMapper.getPageList(params);
		int totalCount = oilCardStockMapper.getPageTotalCount(params);
		
		Pager<OilCardStock> pager = new Pager<OilCardStock>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="新增油卡信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(OilCardStock bean, String oper) throws Exception {
		
		if( null == bean ){
			throw new RuntimeException("油卡信息为空");
		}
		
		//验证该油卡卡号是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("cardNoCheck", bean.getCardNo());
		params.put("delFlag", Constants.DelFlag.N);
		List<OilCardStock> oilCard = oilCardStockMapper.getByConditions(params);
		if(null !=oilCard && oilCard.size()>0){
			throw new RuntimeException("该油卡卡号已存在，请检查");
		}
		
		//插入数据到油卡库存表
		bean.setStatus(Constants.OilCardStatus.NEW);//0新建
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		oilCardStockMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取油卡信息")
	public OilCardStock getById(Integer id) throws Exception {
		return oilCardStockMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新油卡信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(OilCardStock bean, String oper) throws Exception {
		if( null == bean ){
			throw new RuntimeException("油卡信息为空");
		}
		
		//验证该油卡卡号是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("cardNoCheck", bean.getCardNo());
		params.put("delFlag", Constants.DelFlag.N);
		List<OilCardStock> oilCard = oilCardStockMapper.getByConditions(params);
		if(null !=oilCard && oilCard.size()>0 && (int)oilCard.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该油卡卡号已存在，请检查");
		}
		
		//更新油卡信息
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		oilCardStockMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除油卡信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		oilCardStockMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="提交油卡信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void submit(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("status", Constants.OilCardStatus.UNUSED);//1未使用
		//更新状态
		oilCardStockMapper.updateById(params);
		
		/*OilCardStock bean = oilCardStockMapper.getById(id);
		//插入油卡日志表
		OilCardOperateLog log = new OilCardOperateLog();
		log.setOilCardId(id);
		log.setMoney(bean.getMoney());
		log.setMark("新增油卡");
		log.setInsertTime(new Date());
		log.setInsertUser(oper);
		log.setUpdateTime(new Date());
		log.setUpdateUser(oper);
		log.setDelFlag(Constants.DelFlag.N);
		oilCardOperateLogMapper.insert(log);*/
	}

	@Override
	@SystemServiceLog(description="发放油卡")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void grant(Map<String, Object> params, String oper) throws Exception {
		params.put("receiveTime", new Date());
		params.put("status", Constants.OilCardStatus.RECEIVE);//2已领取
		//更新状态、领取人
		oilCardStockMapper.updateById(params);
		
		/*OilCardStock bean = oilCardStockMapper.getById(Integer.parseInt(String.valueOf(params.get("id") )));
		//插入油卡日志表
		OilCardOperateLog log = new OilCardOperateLog();
		log.setOilCardId(bean.getId());
		log.setMoney(bean.getMoney());
		log.setReceiveUser(String.valueOf(params.get("receiveUser")));
		log.setMark("发放油卡");
		log.setInsertTime(new Date());
		log.setInsertUser(oper);
		log.setUpdateTime(new Date());
		log.setUpdateUser(oper);
		log.setDelFlag(Constants.DelFlag.N);
		oilCardOperateLogMapper.insert(log);*/
	}

	@Override
	@SystemServiceLog(description="回收油卡")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void recover(Map<String, Object> params, String oper)
			throws Exception {
		params.put("receiveUser", "");
		params.put("receiveTime", "");
		params.put("status", Constants.OilCardStatus.UNUSED);//1未使用
		//更新状态、金额、领取人为空
		oilCardStockMapper.updateById(params);
		
		/*OilCardStock bean = oilCardStockMapper.getById(Integer.parseInt(String.valueOf(params.get("id"))));
		//插入油卡日志表
		OilCardOperateLog log = new OilCardOperateLog();
		log.setOilCardId(bean.getId());
		log.setMoney(bean.getMoney());
		log.setMark("回收油卡");
		log.setInsertTime(new Date());
		log.setInsertUser(oper);
		log.setUpdateTime(new Date());
		log.setUpdateUser(oper);
		log.setDelFlag(Constants.DelFlag.N);
		oilCardOperateLogMapper.insert(log);*/
	}

	@Override
	@SystemServiceLog(description="油卡充值")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void recharge(Map<String, Object> params, String oper)
			throws Exception {
		OilCardStock bean = oilCardStockMapper.getById(Integer.parseInt(String.valueOf(params.get("id"))));
		Double money = bean.getMoney().doubleValue();
		
		/*//插入油卡日志表
		OilCardOperateLog log = new OilCardOperateLog();
		log.setOilCardId(bean.getId());
		log.setMoney(new BigDecimal( String.valueOf(params.get("money")) ));
		log.setMark("油卡充值");
		log.setInsertTime(new Date());
		log.setInsertUser(oper);
		log.setUpdateTime(new Date());
		log.setUpdateUser(oper);
		log.setDelFlag(Constants.DelFlag.N);
		oilCardOperateLogMapper.insert(log);*/
		
		//插入现金收支表
		CashInOut cash = new CashInOut();
		User user = userMapper.getById(Integer.parseInt(oper));
		int departmentId = 0;
		if( null != user && null != user.getDepartmentId() ){
			departmentId = user.getDepartmentId();
		}
		cash.setDepartmentId(departmentId);
		cash.setBusinessType(Constants.CashInOutBusinessType.OilCard);
		cash.setType(Constants.CashInOutType.OUT);//支出
		cash.setDetailId(bean.getId());
		cash.setMark("油卡充值");
		cash.setMoney( params.get("money") != null ? Double.parseDouble(params.get("money").toString()) : 0 );
		cash.setStatus(Constants.CashInOutStatus.SUBMIT);//已提交
		cash.setSystemFlag(Constants.SystemFlag.Y);//系统插入
		cash.setInsertTime(new Date());
		cash.setInsertUser(oper);
		cash.setUpdateTime(new Date());
		cash.setUpdateUser(oper);
		cash.setDelFlag(Constants.DelFlag.N);
		cashInOutMapper.insert(cash);	
		
		//更新金额
		Double moneyAdd = Double.valueOf(String.valueOf(params.get("money")));
		params.put("money", money+moneyAdd);
		oilCardStockMapper.updateById(params);
	}

	@Override
	@SystemServiceLog(description="获取油卡操作日志")
	public Pager<OilCardOperateLog> queryOilCardLog(Map<String, Object> params)
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
	@SystemServiceLog(description="导出油卡信息")
	public Map<String, Object> getExportData(Map<String, Object> params)
			throws Exception {
		//得到油卡库存数据
		params.put("delFlag", Constants.DelFlag.N);
		List<OilCardStock> detailList = oilCardStockMapper.getByConditions(params);
		
		//构造导出表格
		Map<String, Object> formatData = new HashMap<String, Object>();
		// sheet
		List<String> sheetList = new ArrayList<String>();
		sheetList.add("sheet");
		formatData.put("sheetList", sheetList);
		 
		// 标题
		Map<String, Object> sheetData = new HashMap<String, Object>();
		sheetData.put("title", "当前油卡库存数据");//
		sheetData.put("titleMergeSize", 10);//导出数据的列数

		// 表头
		List<String> tableHeadList = new ArrayList<String>();
		tableHeadList.add("序号");
		tableHeadList.add("类型");
		tableHeadList.add("来源");
		tableHeadList.add("卡类型");
		tableHeadList.add("卡号");
		tableHeadList.add("状态");
		tableHeadList.add("创建人");
		tableHeadList.add("创建时间");
		tableHeadList.add("领取人");
		tableHeadList.add("领取时间");
		sheetData.put("tableHeader", tableHeadList);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		
		// 表数据
		List<List<String>> tableData = new ArrayList<List<String>>();
		for(int i=0;i<detailList.size();i++){
			//获取每一行数据
			OilCardStock oilCard = detailList.get(i);
			
			//加载数据
			List<String> rowData = new ArrayList<String>();
			rowData.add(String.valueOf(i+1));
			
			if(oilCard.getType().equals("0")){
				rowData.add("公司购买");
			}else{
				rowData.add("供应商抵款");
			}
			
			rowData.add(oilCard.getSource());
			if("0".equals(oilCard.getCardType()))
			{
				rowData.add("中石化");
			}
			else
			{
				rowData.add("中石油");
			}
			rowData.add(oilCard.getCardNo());
			
			if(oilCard.getStatus().equals(Constants.OilCardStatus.NEW)){
				rowData.add("新建");
			}else if(oilCard.getStatus().equals(Constants.OilCardStatus.UNUSED)){
				rowData.add("未使用");
			}else if(oilCard.getStatus().equals(Constants.OilCardStatus.RECEIVE)){
				rowData.add("已领取");
			}
			
			rowData.add(oilCard.getInsertUserName());
			if(oilCard.getInsertTime() != null){
				rowData.add( sdf.format(oilCard.getInsertTime()) );
			}else{
				rowData.add("");
			}
			
			rowData.add(oilCard.getReceiveUser());
			if(oilCard.getReceiveTime() != null){
				rowData.add( sdf.format(oilCard.getReceiveTime()) );
			}else{
				rowData.add("");
			}
			
			tableData.add(rowData);
		}
		sheetData.put("tableData", tableData);
		formatData.put("sheetData", sheetData);
		
		return formatData;
	}

	@Override
	@SystemServiceLog(description="导入油卡基础信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void input(HttpServletRequest request, Map<String, Object> params,
			String oper) throws Exception {
		if(null == params.get("filePath") || "".equals(params.get("filePath")))
		{
			throw new RuntimeException("请上传油卡基础数据模板!");
		}
		String filePartPath = params.get("filePath").toString();
		String rootPath = System.getProperty("HyLMS.root");
		String filePath =rootPath + filePartPath;
		Workbook wb = ExcelReader.createWb(filePath);
		Sheet sheet = ExcelReader.getSheet(wb, 0) ;
		List<Object[]> list = ExcelReader.listFromSheet(sheet);
		
		OilCardStock sbp = new OilCardStock();
		if(null != list && list.size() > 0)
		{
			params.clear();
			
			for(int k = 1;k<list.size();k++)//第二行开始
			{
				Object[] t = list.get(k);
				if(t != null && t.length != 0)
				{
					params.put("cardNoCheck", t[3]);//卡号
					List<OilCardStock> ol = oilCardStockMapper.getByConditions(params);
					if(null != ol && ol.size() > 0)
					{
						throw new RuntimeException("EXECL模板第"+(k+1)+"行卡号已存在，请先检查！");
						
					}
					if("公司购买".equals(t[0]))
					{
						sbp.setType("0");
					}
					else if("供应商抵款".equals(t[0]))
					{
						sbp.setType("1");
					}else{
						sbp.setType("");
					}
					
					if(null != t[1] && !"".equals(t[1]))
					{
						sbp.setSource(t[1].toString());
					}
					else
					{
						sbp.setSource("");
					}
					
					if("中石化".equals(t[2]))
					{
						sbp.setCardType("0");
					}
					else if("中石油".equals(t[2]))
					{
						sbp.setCardType("1");
					}else{
						sbp.setCardType("");
					}
					
					if(null != t[3] && !"".equals(t[3]))
					{
						sbp.setCardNo(t[3].toString());
					}
					else
					{
						sbp.setCardNo("");
					}
					sbp.setInsertUser(oper);
					sbp.setInsertTime(new Date());
					sbp.setDelFlag(Constants.DelFlag.N);
					sbp.setStatus(Constants.OilCardStatus.NEW);
					oilCardStockMapper.insert(sbp);
				}
				
			}
		}
	}
	
}
