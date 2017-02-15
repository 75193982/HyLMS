package com.jshpsoft.domain;

import java.util.Date;

/**
 * @author  ww 
 * @date 2016年12月8日 上午11:20:04
 */
public class CostApplyReturn {
	
	private Integer id;

	private String costApplyBillNo;
	
	private Integer departmentId;

	private Integer applyUserId;
	
	private Date applyTime;

	private double prepayAmount;
	
	private double realUseAmount;
	
	private double returnAmount;

	private String mark;
	
	private String status;
	
	private Date insertTime;

	private String insertUser;

	private Date updateTime;

	private String updateUser;

	private String delFlag;
	
	private String departmentName;
	
	private String applyUserName;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCostApplyBillNo() {
		return costApplyBillNo;
	}

	public void setCostApplyBillNo(String costApplyBillNo) {
		this.costApplyBillNo = costApplyBillNo;
	}

	public Integer getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Integer departmentId) {
		this.departmentId = departmentId;
	}

	public Integer getApplyUserId() {
		return applyUserId;
	}

	public void setApplyUserId(Integer applyUserId) {
		this.applyUserId = applyUserId;
	}

	public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}

	public double getPrepayAmount() {
		return prepayAmount;
	}

	public void setPrepayAmount(double prepayAmount) {
		this.prepayAmount = prepayAmount;
	}

	public double getRealUseAmount() {
		return realUseAmount;
	}

	public void setRealUseAmount(double realUseAmount) {
		this.realUseAmount = realUseAmount;
	}

	public double getReturnAmount() {
		return returnAmount;
	}

	public void setReturnAmount(double returnAmount) {
		this.returnAmount = returnAmount;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
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

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getApplyUserName() {
		return applyUserName;
	}

	public void setApplyUserName(String applyUserName) {
		this.applyUserName = applyUserName;
	}
	

}
