package com.jshpsoft.domain;

import java.util.Date;

public class CarOutStockBill {
    private Integer id;

    private Integer stockId;

    private Integer scheduleBillId;

    private Integer scheduleBillDetailId;

    private String type;

    private String startAddress;

    private String targetProvince;
    
    private String targetCity;

    private String receiveUser;

    private String receiveUserTelephone;

    private String receiveUserMobile;

    private String carBrand;

    private String carVin;

    private String carModel;

    private String carColor;

    private String carEngineNo;

    private String carMark;

    private String attachmentName;

    private Integer attachmentCount;

    private Date insertTime;

    private String insertUser;
    
    private String scheduleBillNo;
    private String carShopName;

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

    public Integer getScheduleBillId() {
        return scheduleBillId;
    }

    public void setScheduleBillId(Integer scheduleBillId) {
        this.scheduleBillId = scheduleBillId;
    }

    public Integer getScheduleBillDetailId() {
        return scheduleBillDetailId;
    }

    public void setScheduleBillDetailId(Integer scheduleBillDetailId) {
        this.scheduleBillDetailId = scheduleBillDetailId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getCarBrand() {
        return carBrand;
    }

    public void setCarBrand(String carBrand) {
        this.carBrand = carBrand;
    }

    public String getCarVin() {
        return carVin;
    }

    public void setCarVin(String carVin) {
        this.carVin = carVin;
    }

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public String getCarColor() {
        return carColor;
    }

    public void setCarColor(String carColor) {
        this.carColor = carColor;
    }

    public String getCarEngineNo() {
        return carEngineNo;
    }

    public void setCarEngineNo(String carEngineNo) {
        this.carEngineNo = carEngineNo;
    }

    public String getCarMark() {
        return carMark;
    }

    public void setCarMark(String carMark) {
        this.carMark = carMark;
    }

    public String getAttachmentName() {
        return attachmentName;
    }

    public void setAttachmentName(String attachmentName) {
        this.attachmentName = attachmentName;
    }

    public Integer getAttachmentCount() {
        return attachmentCount;
    }

    public void setAttachmentCount(Integer attachmentCount) {
        this.attachmentCount = attachmentCount;
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

	public String getScheduleBillNo() {
		return scheduleBillNo;
	}

	public void setScheduleBillNo(String scheduleBillNo) {
		this.scheduleBillNo = scheduleBillNo;
	}

	public String getCarShopName() {
		return carShopName;
	}

	public void setCarShopName(String carShopName) {
		this.carShopName = carShopName;
	}
    
    
}