package com.jshpsoft.domain;

import java.util.Date;

public class ReportForWaybill {
	 
    private Integer stockId;//
    private Integer waybillId;//
    private String waybillNo;
    private Integer carShopId;
    private Integer supplierId;
    private String startAddress;
    private String targetProvince;
    private String targetCity;
    private Date waybillSendTime;
    private String waybillStatus;
    private Integer carStockId;//
    private String carType;
    private String brand;
    private String model;
    private String vin;
    private Date carInStockTime;
    private double carPrice;//二手车价格
    private String carStatus;//
    
    //
    private String carShopName;
    private String supplierName;
    
	public String getCarShopName() {
		return carShopName;
	}
	public void setCarShopName(String carShopName) {
		this.carShopName = carShopName;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
	}
	public Integer getStockId() {
		return stockId;
	}
	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}
	public Integer getWaybillId() {
		return waybillId;
	}
	public void setWaybillId(Integer waybillId) {
		this.waybillId = waybillId;
	}
	public String getWaybillNo() {
		return waybillNo;
	}
	public void setWaybillNo(String waybillNo) {
		this.waybillNo = waybillNo;
	}
	public Integer getCarShopId() {
		return carShopId;
	}
	public void setCarShopId(Integer carShopId) {
		this.carShopId = carShopId;
	}
	public Integer getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
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
	public Date getWaybillSendTime() {
		return waybillSendTime;
	}
	public void setWaybillSendTime(Date waybillSendTime) {
		this.waybillSendTime = waybillSendTime;
	}
	public String getWaybillStatus() {
		return waybillStatus;
	}
	public void setWaybillStatus(String waybillStatus) {
		this.waybillStatus = waybillStatus;
	}
	public Integer getCarStockId() {
		return carStockId;
	}
	public void setCarStockId(Integer carStockId) {
		this.carStockId = carStockId;
	}
	public String getCarType() {
		return carType;
	}
	public void setCarType(String carType) {
		this.carType = carType;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getVin() {
		return vin;
	}
	public void setVin(String vin) {
		this.vin = vin;
	}
	public Date getCarInStockTime() {
		return carInStockTime;
	}
	public void setCarInStockTime(Date carInStockTime) {
		this.carInStockTime = carInStockTime;
	}
	public double getCarPrice() {
		return carPrice;
	}
	public void setCarPrice(double carPrice) {
		this.carPrice = carPrice;
	}
	public String getCarStatus() {
		return carStatus;
	}
	public void setCarStatus(String carStatus) {
		this.carStatus = carStatus;
	}
   
	
}