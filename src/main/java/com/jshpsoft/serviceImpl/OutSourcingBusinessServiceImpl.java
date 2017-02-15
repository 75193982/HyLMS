package com.jshpsoft.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.OutSourcingBusinessMapper;
import com.jshpsoft.dao.OutSourcingBusinessPriceMapper;
import com.jshpsoft.dao.OutSourcingMapper;
import com.jshpsoft.dao.SupplierBusinessMapper;
import com.jshpsoft.domain.OutSourcingBusiness;
import com.jshpsoft.domain.OutSourcingBusinessPrice;
import com.jshpsoft.service.OutSourcingBusinessService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.ExcelReader;
import com.jshpsoft.util.Pager;

/**
 * @author  ww 
 * @date 2016年12月3日 上午8:49:41
 */
@Service("outSourcingBusinessService")
public class OutSourcingBusinessServiceImpl implements
		OutSourcingBusinessService {
	
	@Autowired
	private OutSourcingBusinessMapper outSourcingBusinessMapper;
	
	@Autowired
	private OutSourcingBusinessPriceMapper outSourcingBusinessPriceMapper;
	
	@Autowired
	private OutSourcingMapper outSourcingMapper;
	
	@Autowired
	private SupplierBusinessMapper supplierBusinessMapper;
	

	@Override
	public List<OutSourcingBusiness> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return outSourcingBusinessMapper.getByConditions(params);
	}

	@Override
	public Pager<OutSourcingBusiness> getPageData(Map<String, Object> params)
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
		List<OutSourcingBusiness> list = outSourcingBusinessMapper.getPageList(params);
		int totalCount = outSourcingBusinessMapper.getPageTotalCount(params);
		
		Pager<OutSourcingBusiness> pager = new Pager<OutSourcingBusiness>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}

	@Override
	@SystemServiceLog(description="保存、修改承运商设置信息")
	public void save(OutSourcingBusiness bean, String oper) throws Exception {
		if(null == bean)
		{
			throw new RuntimeException("实体为空");
		}
		if(null == bean.getId())
		{
			if(bean.getFilePath() != null && !"".equals(bean.getFilePath()))//地址不为空
			{
				if(bean.getBalanceType() != null && !"".equals(bean.getBalanceType()))////结算模式不为空       0-车型,1-单价,2-总价
				{
					//插入business表
					this.saveOutSourcingBusiness(bean, oper);
					//插入价格表
					this.inputExecl(bean.getBalanceType(), bean.getFilePath(), bean.getOutSourcingId(), bean.getId(), oper);
					
					//应用到其它承运商
					if(null != bean.getOids() && !"".equals(bean.getOids()))
					{
						String[] oids = bean.getOids().split(",");
						if(oids.length > 0)
						{
							for(int i = 0; i< oids.length; i++)
							{
								OutSourcingBusiness ob = new OutSourcingBusiness();
								ob.setOutSourcingId(Integer.valueOf(oids[i]));
								ob.setSupplierId(bean.getSupplierId());
								ob.setBrandName(bean.getBrandName());
								ob.setAccountType(bean.getAccountType());
								ob.setBalanceType(bean.getBalanceType());
								this.saveOutSourcingBusiness(ob, oper);
								this.inputExecl(bean.getBalanceType(), bean.getFilePath(), ob.getOutSourcingId(), ob.getId(), oper);
							}
						}
					}
					
				}
			}
		}
		else //编辑
		{
			if(bean.getFilePath() != null && !"".equals(bean.getFilePath()))//上传地址不为空 表示有模板要导入 
			{
				if(bean.getBalanceType() != null && !"".equals(bean.getBalanceType()))////结算模式不为空     先删除 在插入        0-车型,1-单价,2-总价
				{
					OutSourcingBusinessPrice s = new OutSourcingBusinessPrice();
					s.setUpdateUser(oper);
					s.setUpdateTime(new Date());
					s.setDelFlag(Constants.DelFlag.Y);
					s.setBusinessId(bean.getId());
					outSourcingBusinessPriceMapper.updateByBusinessId(s);  //根据业务id删除
					//更新business表
					this.updateOutSourcingBusiness(bean, oper);
					//插入价格
					this.inputExecl(bean.getBalanceType(), bean.getFilePath(), bean.getOutSourcingId(), bean.getId(), oper);
					
					//应用到其它承运商(删除当前选择的，然后重新插入)
					if(null != bean.getOids() && !"".equals(bean.getOids()))
					{
						String[] oids = bean.getOids().split(",");
						if(oids.length > 0)
						{
							for(int i = 0; i< oids.length; i++)
							{
								Map<String,Object> params = new HashMap<String, Object>();
								params.put("delFlag", Constants.DelFlag.N);
								params.put("outSourcingId",oids[i]);
								params.put("supplierId",bean.getSupplierId());
								params.put("brandName",bean.getBrandName());
								List<OutSourcingBusiness> list = outSourcingBusinessMapper.getByConditions(params);
								if(null != list && list.size() > 0)
								{
									OutSourcingBusinessPrice ss = new OutSourcingBusinessPrice();
									ss.setUpdateUser(oper);
									ss.setUpdateTime(new Date());
									ss.setDelFlag(Constants.DelFlag.Y);
									ss.setBusinessId(list.get(0).getId());
									outSourcingBusinessPriceMapper.updateByBusinessId(ss);//先删除价格表
									list.get(0).setDelFlag(Constants.DelFlag.Y);
									list.get(0).setUpdateTime(new Date());
									list.get(0).setUpdateUser(oper);
									outSourcingBusinessMapper.update(list.get(0));//再删除business表
									
								}
								
								OutSourcingBusiness ob = new OutSourcingBusiness();
								ob.setOutSourcingId(Integer.valueOf(oids[i]));
								ob.setSupplierId(bean.getSupplierId());
								ob.setBrandName(bean.getBrandName());
								ob.setAccountType(bean.getAccountType());
								ob.setBalanceType(bean.getBalanceType());
								this.saveOutSourcingBusiness(ob, oper);
								this.inputExecl(bean.getBalanceType(), bean.getFilePath(), ob.getOutSourcingId(), ob.getId(), oper);
							}
						}
					}
				}
			}
			else
			{
				//更新business表
				this.updateOutSourcingBusiness(bean, oper);
			}
		}

	}

	public void saveOutSourcingBusiness(OutSourcingBusiness bean, String oper) throws Exception
	{
		Map<String,Object> params = new HashMap<String, Object>();
		params.put("delFlag", Constants.DelFlag.N);
		params.put("outSourcingId",bean.getOutSourcingId());
		params.put("supplierId",bean.getSupplierId());
		params.put("brandName",bean.getBrandName());
		List<OutSourcingBusiness> list = outSourcingBusinessMapper.getByConditions(params);
		if(null != list && list.size() > 0)
		{
			throw new RuntimeException("此承运商供应商、品牌已有！");
		}
		bean.setInsertUser(oper);
		bean.setInsertTime(new Date());
		bean.setUpdateUser(oper);
		bean.setUpdateTime(new Date());
		bean.setDelFlag(Constants.DelFlag.N);
		outSourcingBusinessMapper.insert(bean);
	}
	
	public void updateOutSourcingBusiness(OutSourcingBusiness bean, String oper) throws Exception
	{
		OutSourcingBusiness s = outSourcingBusinessMapper.getById(bean.getId());
		if( !bean.getSupplierId().equals(s.getSupplierId()) && !bean.getBrandName().equals(s.getBrandName())) //供应商、品牌都不等
		{
			Map<String,Object> params = new HashMap<String, Object>();
			params.put("delFlag", Constants.DelFlag.N);
			params.put("outSourcingId",bean.getOutSourcingId());
			params.put("supplierId",bean.getSupplierId());
			params.put("brandName",bean.getBrandName());
			List<OutSourcingBusiness> list = outSourcingBusinessMapper.getByConditions(params);
			if(null != list && list.size() > 0)
			{
				throw new RuntimeException("此承运商供应商、品牌已有！");
			}
		}
		bean.setUpdateUser(oper);
		bean.setUpdateTime(new Date());
		outSourcingBusinessMapper.update(bean);
	}
	
	@Override
	@SystemServiceLog(description="删除承运商品牌设置信息")
	public void delete(Integer id, String oper) throws Exception {
		OutSourcingBusiness bean = new OutSourcingBusiness();
		bean.setUpdateUser(oper);
		bean.setUpdateTime(new Date());
		bean.setDelFlag(Constants.DelFlag.Y);
		bean.setId(id);
		outSourcingBusinessMapper.update(bean);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("delFlag", Constants.DelFlag.N);
		params.put("businessId", id);
		List<OutSourcingBusinessPrice> spList = outSourcingBusinessPriceMapper.getByConditions(params);
		if(null != spList && spList.size() > 0)
		{
			OutSourcingBusinessPrice s = new OutSourcingBusinessPrice();
			s.setUpdateUser(oper);
			s.setUpdateTime(new Date());
			s.setDelFlag(Constants.DelFlag.Y);
			s.setBusinessId(id);
			outSourcingBusinessPriceMapper.updateByBusinessId(s);//根据业务id删除
		}

	}

	@Override
	public OutSourcingBusiness getById(Integer id) throws Exception {
		return outSourcingBusinessMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="承运商设置保存")
	public void siteSave(HttpServletRequest request,
			OutSourcingBusiness bean, String oper) throws Exception 
	{
		
//		OutSourcingBusiness bean = new OutSourcingBusiness();
//		bean.setAccountType(params.get("billType").toString());
//		bean.setBalanceType(params.get("settlementType").toString());
//		bean.setId(Integer.valueOf(params.get("id").toString()));
//		outSourcingBusinessMapper.update(bean);
		
		/*OutSourcingBusiness sm = outSourcingBusinessMapper.getById(Integer.valueOf(params.get("id").toString()));
		if(null == sm )
		{
			throw new RuntimeException("查询为空！");
		}
		
		if(null == sm.getBalanceType() || "".equals(sm.getBalanceType()))//结算模式为空
		{
			if(null == params.get("filePath") || "".equals(params.get("filePath")))
			{
				throw new RuntimeException("请上传价格数据模板!");
			}
		}
		else //结算模式不为空
		{
			if(params.get("settlementType").toString().equals(sm.getBalanceType()))//如果一样 地址为空 不操作，不为空 先删除 再插入
			{
				if(null != params.get("filePath") && !"".equals(params.get("filePath")))
				{
					Map<String, Object> par = new HashMap<String, Object>();
					par.put("delFlag", Constants.DelFlag.N);
					par.put("businessId", Integer.parseInt(params.get("brandId").toString()));//业务id
					List<OutSourcingBusinessPrice> spList = outSourcingBusinessPriceMapper.getByConditions(par);
					if(null != spList && spList.size() > 0)
					{
						OutSourcingBusinessPrice s = new OutSourcingBusinessPrice();
						s.setUpdateUser(oper);
						s.setUpdateTime(new Date());
						s.setDelFlag(Constants.DelFlag.Y);
						s.setBusinessId(Integer.parseInt(params.get("brandId").toString()));
						outSourcingBusinessPriceMapper.updateByBusinessId(s);//根据业务id删除
					}
				}
			}
			else//如果不一样   地址为空 提醒，不为空 先删除 再插入
			{
				if(null != params.get("filePath") || !"".equals(params.get("filePath")))
				{
					Map<String, Object> par = new HashMap<String, Object>();
					par.put("delFlag", Constants.DelFlag.N);
					par.put("businessId", Integer.parseInt(params.get("brandId").toString()));//业务id
					List<OutSourcingBusinessPrice> spList = outSourcingBusinessPriceMapper.getByConditions(par);
					if(null != spList && spList.size() > 0)
					{
						OutSourcingBusinessPrice s = new OutSourcingBusinessPrice();
						s.setUpdateUser(oper);
						s.setUpdateTime(new Date());
						s.setDelFlag(Constants.DelFlag.Y);
						s.setBusinessId(Integer.parseInt(params.get("brandId").toString()));
						outSourcingBusinessPriceMapper.updateByBusinessId(s);//根据业务id删除
					}
				}
				else
				{
					throw new RuntimeException("请上传价格数据模板!");
				}
			}
		}*/
		
		

	}

	//导入execl
	public void inputExecl(String settlementType,String filePath,int outSourcingId,int businessId,String oper) throws Exception
	{
		int sheetIndex = Integer.valueOf(settlementType);//结算模式的标记   0-车型,1-单价,2-总价
		
		String filePartPath = ( null != filePath ) ? filePath : null;
		if( StringUtils.isNotEmpty(filePartPath) ){
			String rootPath = System.getProperty("HyLMS.root");
			String filePaths =rootPath + filePartPath;
			Workbook wb = ExcelReader.createWb(filePaths) ;
			// 获取Workbook中Sheet个数
			//int sheetTotal = wb.getNumberOfSheets() ;
			//System.out.println("工作簿中的工作表个数为：{}"+sheetTotal);
			// 获取Sheet 始终取第一个
			Sheet sheet = ExcelReader.getSheet(wb, 0) ;
			// 遍历Sheet
			List<Object[]> list = ExcelReader.listFromSheet(sheet,sheetIndex) ;
			OutSourcingBusinessPrice sbp = new OutSourcingBusinessPrice();
			if(list == null || list.isEmpty()) return ;
			//车型模板要拼写
			if(sheetIndex == 0)
			{
				//车型(第2行)
				Object[] cartype = list.get(1);
				List<Object> carList = new ArrayList<Object>();
				for(int i = 0;i<cartype.length;i++)
				{
					if(i >= (Constants.importExeclLength.priceLength-1))
					{
						if(null != cartype[i] && !"".equals(cartype[i]))
						{
							carList.add(cartype[i].toString().trim());
						}
						else
						{
							carList.add("");
						}
					}
				}
				//System.out.println("--carList--"+carList.size());
				
				//价格
				List<Object[]> priceList = new ArrayList<Object[]>();
				//库区、始发地、目的省、目的地、厂家里程
				List<Object[]> basicList = new ArrayList<Object[]>();
				//前2行是表头信息
				for(int i = 2;i<list.size();i++)
				{
					Object[] t = list.get(i);
					Object[] pl2 = new Object[t.length-Constants.importExeclLength.priceLength+1];
					Object[] b = new Object[Constants.importExeclLength.priceLength-1];
					for(int j = 0;j<t.length;j++)
					{
						if(j<(Constants.importExeclLength.priceLength-1))
						{
							b[j] = t[j];
						}
						if(j >= (Constants.importExeclLength.priceLength-1))
						{
							if(null != t[j] && !"".equals(t[j]))
							{
								pl2[j-Constants.importExeclLength.priceLength+1] = t[j].toString().trim();
							}
						}
					}
					basicList.add(b);
					priceList.add(pl2);
				}
				//System.out.println("----price---"+priceList.size());
				
				for(int i =0;i<priceList.size();i++)
				{
					Object[] p = priceList.get(i);
					for(int j = 0;j < p.length;j++)
					{
						if(null != p[j] && !"".equals(p[j]))
						{
							sbp.setPrice(Double.parseDouble(p[j].toString()));
							sbp.setCarType(carList.get(j).toString());
							Object[] basic = basicList.get(i);
							sbp.setLibName(basic[0].toString());
							sbp.setStartAddress(basic[1].toString());
							if(null != basic[2] && !"".equals(basic[2]))
							{
								sbp.setEndProvince(basic[2].toString());
							}
							else
							{
								sbp.setEndProvince("");
							}
							sbp.setEndAddress(basic[3].toString());
							sbp.setDistance(new Double(Double.parseDouble(basic[4].toString())).intValue());
							sbp.setOutSourcingId(outSourcingId);
							sbp.setBusinessId(businessId);//业务id  
							sbp.setInsertUser(oper);
							sbp.setInsertTime(new Date());
							sbp.setDelFlag(Constants.DelFlag.N);
							outSourcingBusinessPriceMapper.insert(sbp);
						}
					}
				}
			}
			else
			{
				for(int k = 1;k<list.size();k++)//第二行开始
				{
					Object[] t = list.get(k);
					if(t != null && t.length != 0)
					{
						sbp.setLibName(t[0].toString());
						sbp.setStartAddress(t[1].toString());
						if(null != t[2] && !"".equals(t[2]))
						{
							sbp.setEndProvince(t[2].toString());
						}
						else
						{
							sbp.setEndProvince("");
						}
						sbp.setEndAddress(t[3].toString());
						if(sheetIndex == 1)//单价
						{
							sbp.setDistance(new Double(Double.parseDouble(t[4].toString())).intValue());
							sbp.setPrice(Double.parseDouble(t[5].toString()));
						}
						if(sheetIndex == 2)//总价
						{
							sbp.setPrice(Double.parseDouble(t[4].toString()));
						}
						sbp.setOutSourcingId(outSourcingId);
						sbp.setBusinessId(businessId);//业务id 
						sbp.setInsertUser(oper);
						sbp.setInsertTime(new Date());
						sbp.setDelFlag(Constants.DelFlag.N);
						outSourcingBusinessPriceMapper.insert(sbp);
					}
					
				}
			}
			
		}
	}
	@Override
	public List<OutSourcingBusiness> getSupBrandName(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		List<OutSourcingBusiness> list = outSourcingBusinessMapper.getByConditions(params);
		/*List<String> ll = new ArrayList<String>();
		if(null != list && list.size() > 0)
		{
			params.clear();
			for(int i = 0;i<list.size();i++)
			{
				params.put("supplierId", list.get(i).getSupplierId());//供应商id
				params.put("delFlag", Constants.DelFlag.N);
				List<SupplierBusiness> slist = supplierBusinessMapper.getByConditions(params);
				if(null != slist && slist.size() > 0)
				{
					for(int j = 0;j<slist.size();j++)
					{
						ll.add(slist.get(j).getBrandName());
					}
				}
			}
		}
		List<String> sll = new ArrayList<String>(new HashSet<String>(ll));//集合去重
*/		return list;
	}

	@Override
	public List<OutSourcingBusiness> getBrandNameByOs(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return outSourcingBusinessMapper.getBrandNameByOs(params);
	}

}
