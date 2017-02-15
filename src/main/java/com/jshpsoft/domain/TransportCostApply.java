package com.jshpsoft.domain;

import java.util.Date;
import java.util.List;

public class TransportCostApply {
    private Integer id;

    private Date applyTime;

    private String carNumber;

    private int driverId;
    
    private int codriverId;

    private String scheduleBillNo;

    private double amount;

    private double oilAmount;

    private String status;

    private String mark;

    private String prepayApplyIds;
    
    private double balanceCash;
    
    private double balanceOil;

    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;

    private double distance;
    private double standardOilWear;
    private double oilPrice;
    private String discountFlag;
    private double oilDiscountLimit;
    private double oilDiscountPoint;
    private double balanceCashNextMonth;
    
    //
    private List<TransportCostApplyDetail> costList;
    
    private List<TaskHistory> taskList;
    
    private List<TransportPrepayApply> prepayList;
   
    private List<TransportCostCashDetailLog> cashChangeLogList;
    
    private String driverName;
    private double discountAmount;//折现油费对应的现金
    private double discountTotalAmount;//折现后总现金
    private double discountTotalOilAmount;//折现后总油费
    
    private double oilAndAmountSum;//运费总成
    private String codriverName;
  
    public double getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(double discountAmount) {
		this.discountAmount = discountAmount;
	}

	public double getDiscountTotalAmount() {
		return discountTotalAmount;
	}

	public void setDiscountTotalAmount(double discountTotalAmount) {
		this.discountTotalAmount = discountTotalAmount;
	}

	public double getDiscountTotalOilAmount() {
		return discountTotalOilAmount;
	}

	public void setDiscountTotalOilAmount(double discountTotalOilAmount) {
		this.discountTotalOilAmount = discountTotalOilAmount;
	}

	public double getBalanceCashNextMonth() {
		return balanceCashNextMonth;
	}

	public void setBalanceCashNextMonth(double balanceCashNextMonth) {
		this.balanceCashNextMonth = balanceCashNextMonth;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getOilAmount() {
		return oilAmount;
	}

	public void setOilAmount(double oilAmount) {
		this.oilAmount = oilAmount;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public double getStandardOilWear() {
		return standardOilWear;
	}

	public void setStandardOilWear(double standardOilWear) {
		this.standardOilWear = standardOilWear;
	}

	public double getOilPrice() {
		return oilPrice;
	}

	public void setOilPrice(double oilPrice) {
		this.oilPrice = oilPrice;
	}

	public String getDiscountFlag() {
		return discountFlag;
	}

	public void setDiscountFlag(String discountFlag) {
		this.discountFlag = discountFlag;
	}

	public double getOilDiscountLimit() {
		return oilDiscountLimit;
	}

	public void setOilDiscountLimit(double oilDiscountLimit) {
		this.oilDiscountLimit = oilDiscountLimit;
	}

	public double getOilDiscountPoint() {
		return oilDiscountPoint;
	}

	public void setOilDiscountPoint(double oilDiscountPoint) {
		this.oilDiscountPoint = oilDiscountPoint;
	}

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public List<TransportCostCashDetailLog> getCashChangeLogList() {
		return cashChangeLogList;
	}

	public void setCashChangeLogList(
			List<TransportCostCashDetailLog> cashChangeLogList) {
		this.cashChangeLogList = cashChangeLogList;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getApplyTime() {
        return applyTime;
    }

    public void setApplyTime(Date applyTime) {
        this.applyTime = applyTime;
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
	
	public int getCodriverId() {
		return codriverId;
	}

	public void setCodriverId(int codriverId) {
		this.codriverId = codriverId;
	}

	public String getScheduleBillNo() {
        return scheduleBillNo;
    }

    public void setScheduleBillNo(String scheduleBillNo) {
        this.scheduleBillNo = scheduleBillNo;
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

    public String getPrepayApplyIds() {
        return prepayApplyIds;
    }

    public void setPrepayApplyIds(String prepayApplyIds) {
        this.prepayApplyIds = prepayApplyIds;
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

	public List<TransportCostApplyDetail> getCostList() {
		return costList;
	}

	public void setCostList(List<TransportCostApplyDetail> costList) {
		this.costList = costList;
	}

	public List<TaskHistory> getTaskList() {
		return taskList;
	}

	public void setTaskList(List<TaskHistory> taskList) {
		this.taskList = taskList;
	}

	public double getBalanceCash() {
		return balanceCash;
	}

	public void setBalanceCash(double balanceCash) {
		this.balanceCash = balanceCash;
	}

	public double getBalanceOil() {
		return balanceOil;
	}

	public void setBalanceOil(double balanceOil) {
		this.balanceOil = balanceOil;
	}

	public List<TransportPrepayApply> getPrepayList() {
		return prepayList;
	}

	public void setPrepayList(List<TransportPrepayApply> prepayList) {
		this.prepayList = prepayList;
	}

	public String getCodriverName() {
		return codriverName;
	}

	public void setCodriverName(String codriverName) {
		this.codriverName = codriverName;
	}

	public double getOilAndAmountSum() {
		return oilAndAmountSum;
	}

	public void setOilAndAmountSum(double oilAndAmountSum) {
		this.oilAndAmountSum = oilAndAmountSum;
	}
	
}