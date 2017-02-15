package com.jshpsoft.domain;

import java.util.Date;

public class SalaryPayAllowanceDetail {
    private Integer id;

    private Integer salaryPayDetailId;

    private Integer type;

    private String name;

    private double amount;

    private String mark;

    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;

    public Integer getSalaryPayDetailId() {
		return salaryPayDetailId;
	}

	public void setSalaryPayDetailId(Integer salaryPayDetailId) {
		this.salaryPayDetailId = salaryPayDetailId;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
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
}