package com.jshpsoft.domain;

public class BalanceCar {
	 
	//收入管理
    private Integer id;//商品车id
    private Integer type;
    private Integer supplierId;
    private String supplierName;
    private String brand;
    private String model;
    private String vin;
    private String waybillDate;//下单日期
    private String waybillNo;
    private String carNumber;
    private String scheduleDate;//装运日期
    private String scheduleBillNo;
    private String startProvince;
    private String startAddress;
    private String targetProvince;
    private String targetCity;
    private Integer count;
    private Integer distance;
    private double price;//结算单价
    private double bargePrice;//驳板费
    private double farePrice;//加价运费
    private double otherDeduct;//其他扣除
    private double balancePrice;//结算运费
    private double sumPrice;//最终费用
    private String waybillStatus;//运单状态
    private String balanceFlag;//是否能对账标志：Y可以N不可以
    private double transportPrice;//二手车的运费
    
    //成本管理--一些在上面
    private Integer outSourcingId;//承运商id
    private String outSourcingName;//承运商
    private String scheduleStatus;//调度单状态
    
	public String getStartProvince() {
		return startProvince;
	}
	public void setStartProvince(String startProvince) {
		this.startProvince = startProvince;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getSupplierId() {
		return supplierId;
	}
	public void setSupplierId(Integer supplierId) {
		this.supplierId = supplierId;
	}
	public String getSupplierName() {
		return supplierName;
	}
	public void setSupplierName(String supplierName) {
		this.supplierName = supplierName;
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
	public String getWaybillDate() {
		return waybillDate;
	}
	public void setWaybillDate(String waybillDate) {
		this.waybillDate = waybillDate;
	}
	public String getWaybillNo() {
		return waybillNo;
	}
	public void setWaybillNo(String waybillNo) {
		this.waybillNo = waybillNo;
	}
	public String getCarNumber() {
		return carNumber;
	}
	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}
	public String getScheduleDate() {
		return scheduleDate;
	}
	public void setScheduleDate(String scheduleDate) {
		this.scheduleDate = scheduleDate;
	}
	public String getScheduleBillNo() {
		return scheduleBillNo;
	}
	public void setScheduleBillNo(String scheduleBillNo) {
		this.scheduleBillNo = scheduleBillNo;
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
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Integer getDistance() {
		return distance;
	}
	public void setDistance(Integer distance) {
		this.distance = distance;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getBargePrice() {
		return bargePrice;
	}
	public void setBargePrice(double bargePrice) {
		this.bargePrice = bargePrice;
	}
	public double getFarePrice() {
		return farePrice;
	}
	public void setFarePrice(double farePrice) {
		this.farePrice = farePrice;
	}
	public double getOtherDeduct() {
		return otherDeduct;
	}
	public void setOtherDeduct(double otherDeduct) {
		this.otherDeduct = otherDeduct;
	}
	public double getBalancePrice() {
		return balancePrice;
	}
	public void setBalancePrice(double balancePrice) {
		this.balancePrice = balancePrice;
	}
	public String getWaybillStatus() {
		return waybillStatus;
	}
	public void setWaybillStatus(String waybillStatus) {
		this.waybillStatus = waybillStatus;
	}
	public String getBalanceFlag() {
		return balanceFlag;
	}
	public void setBalanceFlag(String balanceFlag) {
		this.balanceFlag = balanceFlag;
	}
	public double getSumPrice() {
		return sumPrice;
	}
	public void setSumPrice(double sumPrice) {
		this.sumPrice = sumPrice;
	}
	public double getTransportPrice() {
		return transportPrice;
	}
	public void setTransportPrice(double transportPrice) {
		this.transportPrice = transportPrice;
	}
	public Integer getOutSourcingId() {
		return outSourcingId;
	}
	public void setOutSourcingId(Integer outSourcingId) {
		this.outSourcingId = outSourcingId;
	}
	public String getOutSourcingName() {
		return outSourcingName;
	}
	public void setOutSourcingName(String outSourcingName) {
		this.outSourcingName = outSourcingName;
	}
	public String getScheduleStatus() {
		return scheduleStatus;
	}
	public void setScheduleStatus(String scheduleStatus) {
		this.scheduleStatus = scheduleStatus;
	}
    
	
}