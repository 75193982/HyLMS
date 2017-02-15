package com.jshpsoft.domain;

import java.util.Date;

public class TaskHistory {
    private Integer id;

    private Integer itemId;

    private Integer processDetailId;

    private String operateUserId;

    private Date operateTime;

    private String mark;

    private String attachFileName;
    
    private String attachFilePath;
    
    private String successFlag;
    
    //
    private String operateUserName;
    private String processDetailName;
    private String itemName;
    
    public String getSuccessFlag() {
		return successFlag;
	}

	public void setSuccessFlag(String successFlag) {
		this.successFlag = successFlag;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getAttachFileName() {
		return attachFileName;
	}

	public void setAttachFileName(String attachFileName) {
		this.attachFileName = attachFileName;
	}

	public String getAttachFilePath() {
		return attachFilePath;
	}

	public void setAttachFilePath(String attachFilePath) {
		this.attachFilePath = attachFilePath;
	}

	public String getProcessDetailName() {
		return processDetailName;
	}

	public void setProcessDetailName(String processDetailName) {
		this.processDetailName = processDetailName;
	}

	public String getOperateUserName() {
		return operateUserName;
	}

	public void setOperateUserName(String operateUserName) {
		this.operateUserName = operateUserName;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getItemId() {
        return itemId;
    }

    public void setItemId(Integer itemId) {
        this.itemId = itemId;
    }

    public Integer getProcessDetailId() {
        return processDetailId;
    }

    public void setProcessDetailId(Integer processDetailId) {
        this.processDetailId = processDetailId;
    }

    public String getOperateUserId() {
        return operateUserId;
    }

    public void setOperateUserId(String operateUserId) {
        this.operateUserId = operateUserId;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }
}