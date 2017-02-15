package com.jshpsoft.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class TrackInsurance {
    private Integer id;

    private String type;

    private String carNumber;

    private int driverId;

    private String insuranceBillNo;

    private Date startTime;

    private Date endTime;

    private BigDecimal amount;
    
    private BigDecimal balance;

    private String status;
    
    private String payStatus;

    private Date noticeTime;

    private String mark;

    private String invoiceAttachPath;

    private String insuranceBillPath;

    private String payLogPath;

    private String accidentReportPath;

    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;
    
    private Date reportTime;
    
    private String surveyMobile;
    
    private String materialCompleteFlag;
    
    private String materialMark;
    
    private Integer carDamageCostApplyId;
    
    private String insuranceCompany;
    
    private String insuranceType;
    
	public Integer getCarDamageCostApplyId() {
		return carDamageCostApplyId;
	}

	public void setCarDamageCostApplyId(Integer carDamageCostApplyId) {
		this.carDamageCostApplyId = carDamageCostApplyId;
	}

	//
    private List<TrackInsuranceDetail> detailList;
    
    private List<TrackInsurancePayLog> insurancePayLogList;
    
    private String driverName;
    
    public Date getReportTime() {
		return reportTime;
	}

	public void setReportTime(Date reportTime) {
		this.reportTime = reportTime;
	}

	public String getSurveyMobile() {
		return surveyMobile;
	}

	public void setSurveyMobile(String surveyMobile) {
		this.surveyMobile = surveyMobile;
	}

	public String getMaterialCompleteFlag() {
		return materialCompleteFlag;
	}

	public void setMaterialCompleteFlag(String materialCompleteFlag) {
		this.materialCompleteFlag = materialCompleteFlag;
	}

	public String getMaterialMark() {
		return materialMark;
	}

	public void setMaterialMark(String materialMark) {
		this.materialMark = materialMark;
	}

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

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public int getDriverId() {
		return driverId;
	}

	public void setDriverId(int driverId) {
		this.driverId = driverId;
	}

	public String getInsuranceBillNo() {
        return insuranceBillNo;
    }

    public void setInsuranceBillNo(String insuranceBillNo) {
        this.insuranceBillNo = insuranceBillNo;
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

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getBalance() {
		return balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

	public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public Date getNoticeTime() {
        return noticeTime;
    }

    public void setNoticeTime(Date noticeTime) {
        this.noticeTime = noticeTime;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    public String getInvoiceAttachPath() {
        return invoiceAttachPath;
    }

    public void setInvoiceAttachPath(String invoiceAttachPath) {
        this.invoiceAttachPath = invoiceAttachPath;
    }

    public String getInsuranceBillPath() {
        return insuranceBillPath;
    }

    public void setInsuranceBillPath(String insuranceBillPath) {
        this.insuranceBillPath = insuranceBillPath;
    }

    public String getPayLogPath() {
        return payLogPath;
    }

    public void setPayLogPath(String payLogPath) {
        this.payLogPath = payLogPath;
    }

    public String getAccidentReportPath() {
        return accidentReportPath;
    }

    public void setAccidentReportPath(String accidentReportPath) {
        this.accidentReportPath = accidentReportPath;
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

	public List<TrackInsuranceDetail> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<TrackInsuranceDetail> detailList) {
		this.detailList = detailList;
	}

	public String getInsuranceCompany() {
		return insuranceCompany;
	}

	public void setInsuranceCompany(String insuranceCompany) {
		this.insuranceCompany = insuranceCompany;
	}

	public String getInsuranceType() {
		return insuranceType;
	}

	public void setInsuranceType(String insuranceType) {
		this.insuranceType = insuranceType;
	}

	public List<TrackInsurancePayLog> getInsurancePayLogList() {
		return insurancePayLogList;
	}

	public void setInsurancePayLogList(
			List<TrackInsurancePayLog> insurancePayLogList) {
		this.insurancePayLogList = insurancePayLogList;
	}

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
    
}