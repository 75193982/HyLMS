package com.jshpsoft.domain;

import java.util.Date;

public class TrackTyreChangeApply {
    private Integer id;

    private String carNumber;

    private String oldTyreNo;

    private String oldTyrePic;

    private String newTyreNo;

    private String newTyrePic;

    private Date applyTime;
    
    private String status;

    private String mark;
   
    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;
    
    private double price;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCarNumber() {
        return carNumber;
    }

    public void setCarNumber(String carNumber) {
        this.carNumber = carNumber;
    }

    public String getOldTyreNo() {
        return oldTyreNo;
    }

    public void setOldTyreNo(String oldTyreNo) {
        this.oldTyreNo = oldTyreNo;
    }

    public String getOldTyrePic() {
        return oldTyrePic;
    }

    public void setOldTyrePic(String oldTyrePic) {
        this.oldTyrePic = oldTyrePic;
    }

    public String getNewTyreNo() {
        return newTyreNo;
    }

    public void setNewTyreNo(String newTyreNo) {
        this.newTyreNo = newTyreNo;
    }

    public String getNewTyrePic() {
        return newTyrePic;
    }

    public void setNewTyrePic(String newTyrePic) {
        this.newTyrePic = newTyrePic;
    }

    public Date getApplyTime() {
		return applyTime;
	}

	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
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

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
    
}