package com.jshpsoft.domain;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class ScheduleBill {
    private Integer id;

    private String scheduleBillNo;

    private Date sendTime;

    private Date receiveTime;

    private Date planReachTime;

    private int driverId;
    
    private int codriverId;

    private String carNumber;

    private String startAddress;

    private String endAddress;

    private Integer amount;
    
    private String status;

    private String mark;

    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;

    private String type;
    
    private String modifyEnabledFlag;
    
    private int outSourcingId;
    
    private List<ScheduleBillDetail> detailList;//调度单明细
    
    //成本管理用到
    private String carTrackName;//车队名称
    private BigDecimal cashAmount;//驳运费用(现金)
    private BigDecimal oilAmount;//油费
    private BigDecimal sumAmount;//总金额
    private Integer oilBalanceRatio;//油费结算比例
    private String balanceFlag;//是否能对账标志：Y可以N不可以
    
    private List<TransportPrepayApply> preList;//z装运预付明细
    
    //装运预付申请
    private String mobile;//手机号码
    private BigDecimal prepayCash;//预付现金
    private String bankName;//开户行名称
    private String bankAccount;//账号
    private String oilCardNo;//油卡卡号
    //private BigDecimal oilAmount;//预付油费--上面已有	
    private Integer transportCostApplyId;
    private String transportCostApplyStatus;
    private Date prepayTime;//预付时间
	
    //
    private String brand;
    
    private Integer stockId;
    
    private String stockName;
    
    private String driverName;
    
    private String codriverName;
    
    private String insertUserName;
    
    private double degree;//发车次数
    
    public int getOutSourcingId() {
		return outSourcingId;
	}

	public void setOutSourcingId(int outSourcingId) {
		this.outSourcingId = outSourcingId;
	}

	public String getInsertUserName() {
		return insertUserName;
	}

	public void setInsertUserName(String insertUserName) {
		this.insertUserName = insertUserName;
	}

	public Date getPrepayTime() {
		return prepayTime;
	}

	public void setPrepayTime(Date prepayTime) {
		this.prepayTime = prepayTime;
	}

	public String getModifyEnabledFlag() {
		return modifyEnabledFlag;
	}

	public void setModifyEnabledFlag(String modifyEnabledFlag) {
		this.modifyEnabledFlag = modifyEnabledFlag;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

    public Integer getTransportCostApplyId() {
		return transportCostApplyId;
	}

	public void setTransportCostApplyId(Integer transportCostApplyId) {
		this.transportCostApplyId = transportCostApplyId;
	}

	public String getTransportCostApplyStatus() {
		return transportCostApplyStatus;
	}

	public void setTransportCostApplyStatus(String transportCostApplyStatus) {
		this.transportCostApplyStatus = transportCostApplyStatus;
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

    public Date getSendTime() {
        return sendTime;
    }

    public void setSendTime(Date sendTime) {
        this.sendTime = sendTime;
    }

    public Date getReceiveTime() {
        return receiveTime;
    }

    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }

    public Date getPlanReachTime() {
        return planReachTime;
    }

    public void setPlanReachTime(Date planReachTime) {
        this.planReachTime = planReachTime;
    }

    public int getDriverId() {
		return driverId;
	}

	public void setDriverId(int driverId) {
		this.driverId = driverId;
	}

	public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getStartAddress() {
        return startAddress;
    }

    public void setStartAddress(String startAddress) {
        this.startAddress = startAddress;
    }

    public String getEndAddress() {
        return endAddress;
    }

    public void setEndAddress(String endAddress) {
        this.endAddress = endAddress;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public String getDelFlag() {
        return delFlag;
    }

    public void setDelFlag(String delFlag) {
        this.delFlag = delFlag;
    }

	public List<ScheduleBillDetail> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<ScheduleBillDetail> detailList) {
		this.detailList = detailList;
	}

	public String getCarTrackName() {
		return carTrackName;
	}

	public void setCarTrackName(String carTrackName) {
		this.carTrackName = carTrackName;
	}

	public BigDecimal getCashAmount() {
		return cashAmount;
	}

	public void setCashAmount(BigDecimal cashAmount) {
		this.cashAmount = cashAmount;
	}

	public BigDecimal getOilAmount() {
		return oilAmount;
	}

	public void setOilAmount(BigDecimal oilAmount) {
		this.oilAmount = oilAmount;
	}

	public BigDecimal getSumAmount() {
		return sumAmount;
	}

	public void setSumAmount(BigDecimal sumAmount) {
		this.sumAmount = sumAmount;
	}

	public Integer getOilBalanceRatio() {
		return oilBalanceRatio;
	}

	public void setOilBalanceRatio(Integer oilBalanceRatio) {
		this.oilBalanceRatio = oilBalanceRatio;
	}

	public String getBalanceFlag() {
		return balanceFlag;
	}

	public void setBalanceFlag(String balanceFlag) {
		this.balanceFlag = balanceFlag;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public BigDecimal getPrepayCash() {
		return prepayCash;
	}

	public void setPrepayCash(BigDecimal prepayCash) {
		this.prepayCash = prepayCash;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankAccount() {
		return bankAccount;
	}

	public void setBankAccount(String bankAccount) {
		this.bankAccount = bankAccount;
	}

	public String getOilCardNo() {
		return oilCardNo;
	}

	public void setOilCardNo(String oilCardNo) {
		this.oilCardNo = oilCardNo;
	}

	public List<TransportPrepayApply> getPreList() {
		return preList;
	}

	public void setPreList(List<TransportPrepayApply> preList) {
		this.preList = preList;
	}

	public Integer getStockId() {
		return stockId;
	}

	public void setStockId(Integer stockId) {
		this.stockId = stockId;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public double getDegree() {
		return degree;
	}

	public void setDegree(double degree) {
		this.degree = degree;
	}

	public int getCodriverId() {
		return codriverId;
	}

	public void setCodriverId(int codriverId) {
		this.codriverId = codriverId;
	}

	public String getCodriverName() {
		return codriverName;
	}

	public void setCodriverName(String codriverName) {
		this.codriverName = codriverName;
	}
    
	
}