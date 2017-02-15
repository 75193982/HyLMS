package com.jshpsoft.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class BalanceBill {
    private Integer id;

    private String type;
    
    private Integer businessId;

    private Integer carCount;

    private Integer distance;

    private String status;

    private String balanceType;
    
    private BigDecimal transportAmount;
    
    private BigDecimal oilAmount;
    
    private Integer oilBalanceRatio;

    private BigDecimal balanceAmount;

    private String mark;

    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private Date verifyTime;

    private String verifyUser;

    private String delFlag;
    
    //上游对账
    private String waybillNo;
    private String brand;
    private String supplierName;

    private List<CarStock> detailList;//商品车明细
    
    //下游对账
    private String carTrackName;//车队名称
    private String scheduleBillNo;//调度单号
    private List<ScheduleBillDetail> scheduleList;//调度单明细

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getBusinessId() {
		return businessId;
	}

	public void setBusinessId(Integer businessId) {
		this.businessId = businessId;
	}

	public Integer getCarCount() {
		return carCount;
	}

	public void setCarCount(Integer carCount) {
		this.carCount = carCount;
	}

	public Integer getDistance() {
		return distance;
	}

	public void setDistance(Integer distance) {
		this.distance = distance;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBalanceType() {
		return balanceType;
	}

	public void setBalanceType(String balanceType) {
		this.balanceType = balanceType;
	}

	public BigDecimal getTransportAmount() {
		return transportAmount;
	}

	public void setTransportAmount(BigDecimal transportAmount) {
		this.transportAmount = transportAmount;
	}

	public BigDecimal getOilAmount() {
		return oilAmount;
	}

	public void setOilAmount(BigDecimal oilAmount) {
		this.oilAmount = oilAmount;
	}

	public Integer getOilBalanceRatio() {
		return oilBalanceRatio;
	}

	public void setOilBalanceRatio(Integer oilBalanceRatio) {
		this.oilBalanceRatio = oilBalanceRatio;
	}

	public BigDecimal getBalanceAmount() {
		return balanceAmount;
	}

	public void setBalanceAmount(BigDecimal balanceAmount) {
		this.balanceAmount = balanceAmount;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
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

	public Date getVerifyTime() {
		return verifyTime;
	}

	public void setVerifyTime(Date verifyTime) {
		this.verifyTime = verifyTime;
	}

	public String getVerifyUser() {
		return verifyUser;
	}

	public void setVerifyUser(String verifyUser) {
		this.verifyUser = verifyUser;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public String getWaybillNo() {
		return waybillNo;
	}

	public void setWaybillNo(String waybillNo) {
		this.waybillNo = waybillNo;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public List<CarStock> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<CarStock> detailList) {
		this.detailList = detailList;
	}

	public String getCarTrackName() {
		return carTrackName;
	}

	public void setCarTrackName(String carTrackName) {
		this.carTrackName = carTrackName;
	}

	public String getScheduleBillNo() {
		return scheduleBillNo;
	}

	public void setScheduleBillNo(String scheduleBillNo) {
		this.scheduleBillNo = scheduleBillNo;
	}

	public List<ScheduleBillDetail> getScheduleList() {
		return scheduleList;
	}

	public void setScheduleList(List<ScheduleBillDetail> scheduleList) {
		this.scheduleList = scheduleList;
	}
    
   
}