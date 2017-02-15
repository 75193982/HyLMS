package com.jshpsoft.domain;

import java.io.Serializable;

public abstract class BasicDomain implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5853552510012814755L;

	private Integer pageStartIndex;//分页开始索引
	
	private Integer pageSize;//分页大小
	
	private String secho;//前台参数

	public String getSecho() {
		return secho;
	}

	public void setSecho(String secho) {
		this.secho = secho;
	}

	public Integer getPageStartIndex() {
		return pageStartIndex;
	}

	public void setPageStartIndex(Integer pageStartIndex) {
		this.pageStartIndex = pageStartIndex;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	
}
