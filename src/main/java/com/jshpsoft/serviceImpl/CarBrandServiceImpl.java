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
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jshpsoft.annotation.SystemServiceLog;
import com.jshpsoft.dao.CarBrandMapper;
import com.jshpsoft.dao.SupplierBusinessMapper;
import com.jshpsoft.dao.SupplierBusinessPriceMapper;
import com.jshpsoft.dao.SupplierMapper;
import com.jshpsoft.domain.CarBrand;
import com.jshpsoft.domain.Supplier;
import com.jshpsoft.domain.SupplierBusiness;
import com.jshpsoft.domain.SupplierBusinessPrice;
import com.jshpsoft.service.CarBrandService;
import com.jshpsoft.util.Constants;
import com.jshpsoft.util.ExcelReader;
import com.jshpsoft.util.Pager;

@Service("carBrandService")
public class CarBrandServiceImpl implements CarBrandService {
	
	@Autowired
	private CarBrandMapper carBrandMapper;
	
	@Autowired
	private SupplierBusinessPriceMapper supplierBusinessPriceMapper;
	
	@Autowired
	private SupplierBusinessMapper supplierBusinessMapper;
	
	@Autowired
	private SupplierMapper supplierMapper;
	
	@Override
	@SystemServiceLog(description="查询汽车品牌信息")
	public List<CarBrand> getByConditions(Map<String, Object> params)
			throws Exception {
		params.put("delFlag", Constants.DelFlag.N);
		return carBrandMapper.getByConditions(params);
	}

	@Override
	@SystemServiceLog(description="查询汽车品牌列表信息")
	public Pager<CarBrand> getPageData(Map<String, Object> params) throws Exception {
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
		List<CarBrand> list = carBrandMapper.getPageList(params);
		int totalCount = carBrandMapper.getPageTotalCount(params);
		
		Pager<CarBrand> pager = new Pager<CarBrand>();
		pager.setRecords(list);
		pager.setTotalCounts(totalCount);
		pager.setPageSize( Integer.parseInt(pageSize) );
		pager.getTotalPages();
		
		return pager;
	}
	
	@Override
	@SystemServiceLog(description="新增汽车品牌信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void save(CarBrand bean, String oper) throws Exception {
		
		if( null == bean ){
			throw new RuntimeException("汽车品牌信息为空");
		}
		
		//验证该汽车品牌名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("brandName", bean.getBrandName());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarBrand> carBrand = carBrandMapper.getByConditions(params);
		if(null !=carBrand && carBrand.size()>0){
			throw new RuntimeException("该汽车品牌已存在，请检查");
		}
		
		//插入汽车品牌表
		bean.setInsertTime(new Date());
		bean.setInsertUser(oper);
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.N);
		carBrandMapper.insert(bean);
	}

	@Override
	@SystemServiceLog(description="根据id获取汽车品牌明细")
	public CarBrand getById(Integer id) throws Exception {
		return carBrandMapper.getById(id);
	}

	@Override
	@SystemServiceLog(description="更新汽车品牌信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void update(CarBrand bean, String oper) throws Exception {
		
		if( null == bean ){
			throw new RuntimeException("汽车品牌信息为空");
		}
		
		//验证该汽车品牌名称是否已经存在
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("brandName", bean.getBrandName());
		params.put("delFlag", Constants.DelFlag.N);
		List<CarBrand> carBrand = carBrandMapper.getByConditions(params);
		if(null !=carBrand && carBrand.size()>0 && (int)carBrand.get(0).getId() != (int)bean.getId()){
			throw new RuntimeException("该汽车品牌已存在，请检查");
		}
		
		//更新汽车品牌数据
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		carBrandMapper.update(bean);
	}

	@Override
	@SystemServiceLog(description="删除汽车品牌信息")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void updateById(Integer id, String oper) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		params.put("updateTime", new Date());
		params.put("updateUser", oper);
		params.put("delFlag", Constants.DelFlag.Y);
		carBrandMapper.updateById(params);
		SupplierBusinessPrice bean = new SupplierBusinessPrice();
		bean.setUpdateTime(new Date());
		bean.setUpdateUser(oper);
		bean.setDelFlag(Constants.DelFlag.Y);
		bean.setBusinessId(id);
		supplierBusinessPriceMapper.updateByBusinessId(bean);//删除品牌的同时 删除价格信息
	}

	@Override
	@SystemServiceLog(description="根据品牌id获取车型")
	public List<CarBrand> getCarTypeList(Integer id) throws Exception {
		List<CarBrand> result = new ArrayList<CarBrand>();
		CarBrand bean = carBrandMapper.getById(id);
		
		if( null != bean ){
			String[] cartypes = bean.getCarType().split("\\|");
			for(int i=0; i<cartypes.length; i++){
				CarBrand carBrand=new CarBrand();
				carBrand.setCarType(cartypes[i]);
				result.add(carBrand);
			}		
		}
		
		return result;
	}

	@Override
	@SystemServiceLog(description="品牌设置保存")
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public void siteSave(HttpServletRequest request,
			Map<String, Object> params,String oper) throws Exception 
	{
		SupplierBusiness sm = supplierBusinessMapper.getById(Integer.valueOf(params.get("id").toString()));
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
					List<SupplierBusinessPrice> spList = supplierBusinessPriceMapper.getByConditions(par);
					if(null != spList && spList.size() > 0)
					{
						SupplierBusinessPrice s = new SupplierBusinessPrice();
						s.setUpdateUser(oper);
						s.setUpdateTime(new Date());
						s.setDelFlag(Constants.DelFlag.Y);
						s.setBusinessId(Integer.parseInt(params.get("brandId").toString()));
						supplierBusinessPriceMapper.updateByBusinessId(s);//根据业务id删除
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
					List<SupplierBusinessPrice> spList = supplierBusinessPriceMapper.getByConditions(par);
					if(null != spList && spList.size() > 0)
					{
						SupplierBusinessPrice s = new SupplierBusinessPrice();
						s.setUpdateUser(oper);
						s.setUpdateTime(new Date());
						s.setDelFlag(Constants.DelFlag.Y);
						s.setBusinessId(Integer.parseInt(params.get("brandId").toString()));
						supplierBusinessPriceMapper.updateByBusinessId(s);//根据业务id删除
					}
				}
				else
				{
					throw new RuntimeException("请上传价格数据模板!");
				}
			}
		}
		
		SupplierBusiness bean = new SupplierBusiness();
		bean.setAccountType(params.get("billType").toString());
		bean.setBalanceType(params.get("settlementType").toString());
		bean.setId(Integer.valueOf(params.get("id").toString()));
		supplierBusinessMapper.update(bean);
		
		int sheetIndex = Integer.valueOf(params.get("settlementType").toString());//结算模式的标记   0-车型,1-单价,2-总价
		
		String filePartPath = ( null != params.get("filePath") ) ? params.get("filePath").toString() : null;
		if( StringUtils.isNotEmpty(filePartPath) ){
			String rootPath = System.getProperty("HyLMS.root");
			String filePath =rootPath + filePartPath;
			Workbook wb = ExcelReader.createWb(filePath) ;
			// 获取Workbook中Sheet个数
			//int sheetTotal = wb.getNumberOfSheets() ;
			//System.out.println("工作簿中的工作表个数为：{}"+sheetTotal);
			// 获取Sheet 始终取第一个
			Sheet sheet = ExcelReader.getSheet(wb, 0) ;
			// 遍历Sheet
			List<Object[]> list = ExcelReader.listFromSheet(sheet,sheetIndex) ;
			SupplierBusinessPrice sbp = new SupplierBusinessPrice();
			if(list == null || list.isEmpty()) return ;
			//车型模板要拼写
			if(sheetIndex == 0)
			{
				/*Iterator<Object[]> iter = list.iterator() ;
			while(iter.hasNext()) {
				Object[] t = iter.next() ;
				if(t == null) {
					System.out.println(t.toString());
				} else {
					//int index = 1 ;
					if(t != null && t.length != 0)
					{
						StringBuffer sb = new StringBuffer() ;
						Object[] tt = {};
						
						for(int i = 0 ,len = t.length ; i < len ; i++) {
							sb.append(t[i] + ",") ;
							
						}
						System.out.println(sb.toString());
					}
					
				}
			}*/
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
							sbp.setSupplierId(Integer.valueOf(params.get("supplierId").toString()));
							sbp.setBusinessId(Integer.valueOf(params.get("brandId").toString()));//业务id  品牌设置id
							sbp.setInsertUser(oper);
							sbp.setInsertTime(new Date());
							sbp.setDelFlag(Constants.DelFlag.N);
							supplierBusinessPriceMapper.insert(sbp);
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
						sbp.setSupplierId(Integer.valueOf(params.get("supplierId").toString()));
						sbp.setBusinessId(Integer.valueOf(params.get("brandId").toString()));//业务id  品牌设置id
						sbp.setInsertUser(oper);
						sbp.setInsertTime(new Date());
						sbp.setDelFlag(Constants.DelFlag.N);
						supplierBusinessPriceMapper.insert(sbp);
					}
					
				}
			}
			//反填供应商 库区 多个以"|" 分开
			Map<String,Object> p = new HashMap<String, Object>();
			p.put("delFlag", Constants.DelFlag.N);
			p.put("supplierId", params.get("supplierId"));
			List<SupplierBusinessPrice> sl = supplierBusinessPriceMapper.getLibNameBySup(p);
			String stocks = "";
			if(null != sl && sl.size() > 0)
			{
				for(int i = 0;i<sl.size();i++)
				{
					SupplierBusinessPrice s = sl.get(i);
					if(null != s)
					{
						if(null != s.getLibName() && !"".equals(s.getLibName()))
						{
							stocks += s.getLibName()+"|";
						}
					}
				}
				stocks = stocks.substring(0,stocks.length()-1);
				Supplier sp = new Supplier();
				sp.setStocks(stocks);
				sp.setId(Integer.valueOf(params.get("supplierId").toString()));
				supplierMapper.update(sp);
			}
		}
	}

}
