package com.jshpsoft.domain;

import java.util.Date;

/**
 * @author  ww 
 * @date 2016年11月26日 下午6:01:41
 */
public class OutSourcingBusiness {
	
	private Integer id;
	
	private Integer outSourcingId;
	
	private Integer supplierId;

	private String brandName;
	
	private String accountType;
	
	private String balanceType;
	
	private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;
    
    private String outSourcingName;
    
    private String supplierName;
    
    private String updateUserName;
    
    private String filePath;//价格模板上传地址
    
    private String oids;//承运商id 逗号,分隔

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOutSourcingId() {
		return outSourcingId;
	}

	public void setOutSourcingId(Integer outSourcingId) {
		this.outSourcingId = outSourcingId;
	}
	
	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

	public String getBalanceType() {
		return balanceType;
	}

	public void setBalanceType(String balanceType) {
		this.balanceType = balanceType;
	}

	public Date getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}

	public String getInsertUser() {
		return insertUser;
	}

	public void setInsertUser(String insertUser) {
		this.insertUser = insertUser;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getOutSourcingName() {
		return outSourcingName;
	}

	public void setOutSourcingName(String outSourcingName) {
		this.outSourcingName = outSourcingName;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getUpdateUserName() {
		return updateUserName;
	}

	public void setUpdateUserName(String updateUserName) {
		this.updateUserName = updateUserName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getOids() {
		return oids;
	}

	public void setOids(String oids) {
		this.oids = oids;
	}
    
}
