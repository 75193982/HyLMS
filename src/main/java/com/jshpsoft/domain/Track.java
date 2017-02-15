package com.jshpsoft.domain;

import java.math.BigDecimal;
import java.util.Date;

public class Track {
    private Integer id;

    private Integer outSourcingId;
    
    private String type;

    private String no;//车头车牌号
    
    private String xno;//车厢车牌号

    private int driverId;
    
    private int codriverId;//副驾驶员

    private String ower;

    private String owerAddress;

    private String vin;

    private String engineNo;

    private Date registerTime;

    private String size;

    private Date insuranceStartTime;

    private Date insuranceEndTime;

    private String insuranceCompany;

    private Date annualReviewTime;

    private BigDecimal standardOilWear;

    private BigDecimal oilDiscountLimit;

    private BigDecimal oilDiscountPoint;

    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;
    
    private String outSourcingName;//外协单位名称
    private String mobile;//手机号码

    private String drivingFilePath;
    
    private String toperatingFilePath;
    
    private String xoperatingFilePath;
    
    private String status;
    
    private int lastDistance;//距上次保养公里数
    
    //
    private String driverName;
    
    private String codriverName;
    
    public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public int getDriverId() {
		return driverId;
	}

	public void setDriverId(int driverId) {
		this.driverId = driverId;
	}
	
	public int getCodriverId() {
		return codriverId;
	}

	public void setCodriverId(int codriverId) {
		this.codriverId = codriverId;
	}

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

    public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getXno() {
		return xno;
	}

	public void setXno(String xno) {
		this.xno = xno;
	}

	public String getOwer() {
        return ower;
    }

    public void setOwer(String ower) {
        this.ower = ower;
    }

    public String getOwerAddress() {
        return owerAddress;
    }

    public void setOwerAddress(String owerAddress) {
        this.owerAddress = owerAddress;
    }

    public String getVin() {
        return vin;
    }

    public void setVin(String vin) {
        this.vin = vin;
    }

    public String getEngineNo() {
        return engineNo;
    }

    public void setEngineNo(String engineNo) {
        this.engineNo = engineNo;
    }

    public Date getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(Date registerTime) {
        this.registerTime = registerTime;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public Date getInsuranceStartTime() {
        return insuranceStartTime;
    }

    public void setInsuranceStartTime(Date insuranceStartTime) {
        this.insuranceStartTime = insuranceStartTime;
    }

    public Date getInsuranceEndTime() {
        return insuranceEndTime;
    }

    public void setInsuranceEndTime(Date insuranceEndTime) {
        this.insuranceEndTime = insuranceEndTime;
    }

    public String getInsuranceCompany() {
        return insuranceCompany;
    }

    public void setInsuranceCompany(String insuranceCompany) {
        this.insuranceCompany = insuranceCompany;
    }

    public Date getAnnualReviewTime() {
        return annualReviewTime;
    }

    public void setAnnualReviewTime(Date annualReviewTime) {
        this.annualReviewTime = annualReviewTime;
    }

    public BigDecimal getStandardOilWear() {
        return standardOilWear;
    }

    public void setStandardOilWear(BigDecimal standardOilWear) {
        this.standardOilWear = standardOilWear;
    }

    public BigDecimal getOilDiscountLimit() {
        return oilDiscountLimit;
    }

    public void setOilDiscountLimit(BigDecimal oilDiscountLimit) {
        this.oilDiscountLimit = oilDiscountLimit;
    }

    public BigDecimal getOilDiscountPoint() {
        return oilDiscountPoint;
    }

    public void setOilDiscountPoint(BigDecimal oilDiscountPoint) {
        this.oilDiscountPoint = oilDiscountPoint;
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

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getDrivingFilePath() {
		return drivingFilePath;
	}

	public void setDrivingFilePath(String drivingFilePath) {
		this.drivingFilePath = drivingFilePath;
	}

	public String getToperatingFilePath() {
		return toperatingFilePath;
	}

	public void setToperatingFilePath(String toperatingFilePath) {
		this.toperatingFilePath = toperatingFilePath;
	}

	public String getXoperatingFilePath() {
		return xoperatingFilePath;
	}

	public void setXoperatingFilePath(String xoperatingFilePath) {
		this.xoperatingFilePath = xoperatingFilePath;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getLastDistance() {
		return lastDistance;
	}

	public void setLastDistance(int lastDistance) {
		this.lastDistance = lastDistance;
	}

	public String getCodriverName() {
		return codriverName;
	}

	public void setCodriverName(String codriverName) {
		this.codriverName = codriverName;
	}
    
}