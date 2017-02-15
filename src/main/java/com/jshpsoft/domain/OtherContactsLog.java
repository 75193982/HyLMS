package com.jshpsoft.domain;

import java.util.Date;

/**
 * @author  ww 
 * @date 2016年10月25日 下午2:13:11
 */
public class OtherContactsLog {
	
	private Integer id;
	
	private Integer otherContactId;
	
	private double amount;
	private Date operateTime;
	
	private String mark;
	
	private Date insertTime;
	
	private String insertUser;
	
	private Date updateTime;
	
	private String updateUser;
	
	private String delFlag;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOtherContactId() {
		return otherContactId;
	}

	public void setOtherContactId(Integer otherContactId) {
		this.otherContactId = otherContactId;
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

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}
	
	

}
