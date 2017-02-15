package com.jshpsoft.domain;

import java.util.Date;

public class OutSourcing {
    private Integer id;

    private String name;

    private String address;

    private String linkUser;

    private Date brithday;

    private String linkTelephone;

    private String linkMobile;

    private Date startTime;
    
    private Date endTime;

    private String needInvoiceFlag;

    private String invoiceOrder;

    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;

    private Integer transportOilCostRatio;  

	public Integer getTransportOilCostRatio() {
		return transportOilCostRatio;
	}

	public void setTransportOilCostRatio(Integer transportOilCostRatio) {
		this.transportOilCostRatio = transportOilCostRatio;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLinkUser() {
        return linkUser;
    }

    public void setLinkUser(String linkUser) {
        this.linkUser = linkUser;
    }

    public Date getBrithday() {
        return brithday;
    }

    public void setBrithday(Date brithday) {
        this.brithday = brithday;
    }

    public String getLinkTelephone() {
        return linkTelephone;
    }

    public void setLinkTelephone(String linkTelephone) {
        this.linkTelephone = linkTelephone;
    }

    public String getLinkMobile() {
        return linkMobile;
    }

    public void setLinkMobile(String linkMobile) {
        this.linkMobile = linkMobile;
    }

    public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getNeedInvoiceFlag() {
        return needInvoiceFlag;
    }

    public void setNeedInvoiceFlag(String needInvoiceFlag) {
        this.needInvoiceFlag = needInvoiceFlag;
    }

    public String getInvoiceOrder() {
        return invoiceOrder;
    }

    public void setInvoiceOrder(String invoiceOrder) {
        this.invoiceOrder = invoiceOrder;
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
}