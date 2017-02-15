package com.jshpsoft.domain;

import java.util.Date;

/**
 * 单程利润
 * @author  ww 
 * @date 2017年1月9日 上午11:28:09
 */
public class OneWayProfit {
	
	private Integer id;//调度单id
	
	private String scheduleBillNo;
	
	private Date sendTime;
	
	private String carNumber;
	
	private String driverName;
	
	private int amount;
	
	private double receiveMoney;
	
	private double onWayMoney;
	
	private double chaMoney;
	
	

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

	public String getCarNumber() {
		return carNumber;
	}

	public void setCarNumber(String carNumber) {
		this.carNumber = carNumber;
	}

	public String getDriverName() {
		return driverName;
	}

	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public double getReceiveMoney() {
		return receiveMoney;
	}

	public void setReceiveMoney(double receiveMoney) {
		this.receiveMoney = receiveMoney;
	}

	public double getOnWayMoney() {
		return onWayMoney;
	}

	public void setOnWayMoney(double onWayMoney) {
		this.onWayMoney = onWayMoney;
	}

	public double getChaMoney() {
		return chaMoney;
	}

	public void setChaMoney(double chaMoney) {
		this.chaMoney = chaMoney;
	}
	

}
