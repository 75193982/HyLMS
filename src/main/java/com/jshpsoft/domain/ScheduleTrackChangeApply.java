package com.jshpsoft.domain;

import java.util.Date;

public class ScheduleTrackChangeApply {
    private Integer id;

    private String scheduleBillNo;

    private String reason;

    private Integer oldDriverId;

    private String oldCarNumber;

    private String status;

    private String mark;

    private Integer newDriverId;

    private String newCarNumber;

    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;
    
    private String oldDriverName;
    
    private String newDriverName;

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

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Integer getOldDriverId() {
		return oldDriverId;
	}

	public void setOldDriverId(Integer oldDriverId) {
		this.oldDriverId = oldDriverId;
	}

	public String getOldCarNumber() {
        return oldCarNumber;
    }

    public void setOldCarNumber(String oldCarNumber) {
        this.oldCarNumber = oldCarNumber;
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

    public Integer getNewDriverId() {
		return newDriverId;
	}

	public void setNewDriverId(Integer newDriverId) {
		this.newDriverId = newDriverId;
	}

	public String getNewCarNumber() {
        return newCarNumber;
    }

    public void setNewCarNumber(String newCarNumber) {
        this.newCarNumber = newCarNumber;
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

	public String getOldDriverName() {
		return oldDriverName;
	}

	public void setOldDriverName(String oldDriverName) {
		this.oldDriverName = oldDriverName;
	}

	public String getNewDriverName() {
		return newDriverName;
	}

	public void setNewDriverName(String newDriverName) {
		this.newDriverName = newDriverName;
	}

}