package com.jshpsoft.domain;

import java.util.Date;
import java.util.List;

public class TrackTyreInOut {
    private Integer id;

    private String billNo;

    private String type;

    private String status;

    private String mark;

    private String buyBillNo;
    
    private Date insertTime;

    private String insertUser;

    private Date updateTime;

    private String updateUser;

    private String delFlag;
    
    private String ids;//轮胎库存id集
    
    private List<TrackTyreInOutDetail> detailList;
    
    private String typeEdit;//
    
    private String brandEdit;
    
    private String sizeEdit;
    
    private Integer sumEdit;
    
    private double priceEdit;
    
    private String insertUserName;
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBillNo() {
        return billNo;
    }

    public void setBillNo(String billNo) {
        this.billNo = billNo;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
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

    public String getBuyBillNo() {
		return buyBillNo;
	}

	public void setBuyBillNo(String buyBillNo) {
		this.buyBillNo = buyBillNo;
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

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public List<TrackTyreInOutDetail> getDetailList() {
		return detailList;
	}

	public void setDetailList(List<TrackTyreInOutDetail> detailList) {
		this.detailList = detailList;
	}

	public String getTypeEdit() {
		return typeEdit;
	}

	public void setTypeEdit(String typeEdit) {
		this.typeEdit = typeEdit;
	}

	public String getBrandEdit() {
		return brandEdit;
	}

	public void setBrandEdit(String brandEdit) {
		this.brandEdit = brandEdit;
	}

	public String getSizeEdit() {
		return sizeEdit;
	}

	public void setSizeEdit(String sizeEdit) {
		this.sizeEdit = sizeEdit;
	}

	public Integer getSumEdit() {
		return sumEdit;
	}

	public void setSumEdit(Integer sumEdit) {
		this.sumEdit = sumEdit;
	}

	public double getPriceEdit() {
		return priceEdit;
	}

	public void setPriceEdit(double priceEdit) {
		this.priceEdit = priceEdit;
	}

	public String getInsertUserName() {
		return insertUserName;
	}

	public void setInsertUserName(String insertUserName) {
		this.insertUserName = insertUserName;
	}
    
}