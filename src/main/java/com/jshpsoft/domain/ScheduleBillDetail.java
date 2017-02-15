package com.jshpsoft.domain;

import java.util.Date;
import java.util.List;

public class ScheduleBillDetail {
    private Integer id;

    private String scheduleBillNo;

    private Integer carShopId;

    private String mark;

    private Integer amount;

    private String carStockIds;

    private String attachmentIds;

    private String attachmentCounts;

    private String status;

    private String startProvince;
    private String startAddress;
    private String targetProvince;
    private String targetCity;
    
    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;

    private List<CarStock> carList;//商品车明细
    private List<CarAttachmentStock> carAttachmentList;//配件明细
    private String carShopName;//经销单位名称   
    
    private int type;
    private Date sendTime;
    private Date arrivalTime;
    //
    private String waybillNo;
    private String brandName;
    private int count;
    private List<String> vinList;
    private String carStyle;
    private Integer supplierId;
    private String supplierName;
    private double money;
    
	public String getStartProvince() {
		return startProvince;
	}

	public void setStartProvince(String startProvince) {
		this.startProvince = startProvince;
	}

	public String getCarStyle() {
		return carStyle;
	}

	public void setCarStyle(String carStyle) {
		this.carStyle = carStyle;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public List<String> getVinList() {
		return vinList;
	}

	public void setVinList(List<String> vinList) {
		this.vinList = vinList;
	}

	public Date getArrivalTime() {
		return arrivalTime;
	}

	public void setArrivalTime(Date arrivalTime) {
		this.arrivalTime = arrivalTime;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getWaybillNo() {
		return waybillNo;
	}

	public void setWaybillNo(String waybillNo) {
		this.waybillNo = waybillNo;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getCarShopName() {
		return carShopName;
	}

	public void setCarShopName(String carShopName) {
		this.carShopName = carShopName;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getScheduleBillNo() {
        return scheduleBillNo;
    }

    public void setScheduleBillNo(String scheduleBillNo) {
        this.scheduleBillNo = scheduleBillNo;
    }

    public Integer getCarShopId() {
        return carShopId;
    }

    public void setCarShopId(Integer carShopId) {
        this.carShopId = carShopId;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public String getCarStockIds() {
        return carStockIds;
    }

    public void setCarStockIds(String carStockIds) {
        this.carStockIds = carStockIds;
    }

    public String getAttachmentIds() {
        return attachmentIds;
    }

    public void setAttachmentIds(String attachmentIds) {
        this.attachmentIds = attachmentIds;
    }

    public String getAttachmentCounts() {
        return attachmentCounts;
    }

    public void setAttachmentCounts(String attachmentCounts) {
        this.attachmentCounts = attachmentCounts;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

	public List<CarStock> getCarList() {
		return carList;
	}

	public void setCarList(List<CarStock> carList) {
		this.carList = carList;
	}

	public List<CarAttachmentStock> getCarAttachmentList() {
		return carAttachmentList;
	}

	public void setCarAttachmentList(List<CarAttachmentStock> carAttachmentList) {
		this.carAttachmentList = carAttachmentList;
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

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
	}
    
}