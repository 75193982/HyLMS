package com.jshpsoft.domain;

import java.math.BigDecimal;
import java.util.List;


public class Waybill {
    private Integer id;

    private Integer stockId;

    private String type;

    private String waybillNo;

    private Integer supplierId;

    private String brand;

    private Integer carShopId;

    private String sendTime;
    
    private String mark;

    private String receiveUser;

    private String receiveUserTelephone;

    private String receiveUserMobile;

    private String startProvince;
    private String startAddress;

    private String targetProvince;
    private String targetCity;

    private Integer distance;

    private String attachFilePath;
    
    private String attachFileName;

    private String status;

    private String balanceType;

    private BigDecimal amount;

    private String insertTime;

    private String insertUser;

    private String updateTime;

    private String updateUser;

    private String delFlag;

    private String arrivalTime;
    
    private String scheduleBillNo;
    
    //
    private String supplierName;//供应商名称
    private String carShopName;//经销单位
    
    private List<CarStock> carStockList;
    private List<CarAttachmentStock> carAttachmentStockList;
    
    private List<CarDamageStock> carDamageStockList;
    
    //收入管理用到
    private Integer count;//数量
    private BigDecimal attachAmount;//额外费用
    private BigDecimal sumAmount;//总金额
    private String balanceFlag;//是否能对账标志：Y可以N不可以
    
	public String getStartProvince() {
		return startProvince;
	}

	public void setStartProvince(String startProvince) {
		this.startProvince = startProvince;
	}

	public String getScheduleBillNo() {
		return scheduleBillNo;
	}

	public void setScheduleBillNo(String scheduleBillNo) {
		this.scheduleBillNo = scheduleBillNo;
	}

	public String getArrivalTime() {
		return arrivalTime;
	}

	public void setArrivalTime(String arrivalTime) {
		this.arrivalTime = arrivalTime;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getStockId() {
		return stockId;
	}

	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getWaybillNo() {
		return waybillNo;
	}

	public void setWaybillNo(String waybillNo) {
		this.waybillNo = waybillNo;
	}

	public Integer getSupplierId() {
		return supplierId;
	}

	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public Integer getCarShopId() {
		return carShopId;
	}

	public void setCarShopId(Integer carShopId) {
		this.carShopId = carShopId;
	}

	public String getSendTime() {
		return sendTime;
	}

	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}

	public String getReceiveUser() {
		return receiveUser;
	}

	public void setReceiveUser(String receiveUser) {
		this.receiveUser = receiveUser;
	}

	public String getReceiveUserTelephone() {
		return receiveUserTelephone;
	}

	public void setReceiveUserTelephone(String receiveUserTelephone) {
		this.receiveUserTelephone = receiveUserTelephone;
	}

	public String getReceiveUserMobile() {
		return receiveUserMobile;
	}

	public void setReceiveUserMobile(String receiveUserMobile) {
		this.receiveUserMobile = receiveUserMobile;
	}

	public String getStartAddress() {
		return startAddress;
	}

	public void setStartAddress(String startAddress) {
		this.startAddress = startAddress;
	}

	public String getTargetProvince() {
		return targetProvince;
	}

	public void setTargetProvince(String targetProvince) {
		this.targetProvince = targetProvince;
	}

	public String getTargetCity() {
		return targetCity;
	}

	public void setTargetCity(String targetCity) {
		this.targetCity = targetCity;
	}

	public Integer getDistance() {
		return distance;
	}

	public void setDistance(Integer distance) {
		this.distance = distance;
	}

	public String getAttachFilePath() {
		return attachFilePath;
	}

	public void setAttachFilePath(String attachFilePath) {
		this.attachFilePath = attachFilePath;
	}

	public String getAttachFileName() {
		return attachFileName;
	}

	public void setAttachFileName(String attachFileName) {
		this.attachFileName = attachFileName;
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

	public String getInsertTime() {
		return insertTime;
	}

	public void setInsertTime(String insertTime) {
		this.insertTime = insertTime;
	}

	public String getInsertUser() {
		return insertUser;
	}

	public void setInsertUser(String insertUser) {
		this.insertUser = insertUser;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
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

	public String getSupplierName() {
		return supplierName;
	}

	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}

	public String getCarShopName() {
		return carShopName;
	}

	public void setCarShopName(String carShopName) {
		this.carShopName = carShopName;
	}

	public List<CarStock> getCarStockList() {
		return carStockList;
	}

	public void setCarStockList(List<CarStock> carStockList) {
		this.carStockList = carStockList;
	}

	public List<CarAttachmentStock> getCarAttachmentStockList() {
		return carAttachmentStockList;
	}

	public void setCarAttachmentStockList(
			List<CarAttachmentStock> carAttachmentStockList) {
		this.carAttachmentStockList = carAttachmentStockList;
	}

	public List<CarDamageStock> getCarDamageStockList() {
		return carDamageStockList;
	}

	public void setCarDamageStockList(List<CarDamageStock> carDamageStockList) {
		this.carDamageStockList = carDamageStockList;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getAttachAmount() {
		return attachAmount;
	}

	public void setAttachAmount(BigDecimal attachAmount) {
		this.attachAmount = attachAmount;
	}

	public BigDecimal getSumAmount() {
		return sumAmount;
	}

	public void setSumAmount(BigDecimal sumAmount) {
		this.sumAmount = sumAmount;
	}

	public String getBalanceFlag() {
		return balanceFlag;
	}

	public void setBalanceFlag(String balanceFlag) {
		this.balanceFlag = balanceFlag;
	}	

}