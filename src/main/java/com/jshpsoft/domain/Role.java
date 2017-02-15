package com.jshpsoft.domain;

import java.util.List;

public class Role {
    private Integer id;

    private String name;

    private String mark;

    private Integer orderId;

    private Integer parentId;
    
    //
    private List<RoleMenus> menusList;
    
    //
    private List<RoleUserGroups> userGroupsList;
    
	public List<RoleUserGroups> getUserGroupsList() {
		return userGroupsList;
	}

	public void setUserGroupsList(List<RoleUserGroups> userGroupsList) {
		this.userGroupsList = userGroupsList;
	}

	public List<RoleMenus> getMenusList() {
		return menusList;
	}

	public void setMenusList(List<RoleMenus> menusList) {
		this.menusList = menusList;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }
}