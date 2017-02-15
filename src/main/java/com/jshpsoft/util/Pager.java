package com.jshpsoft.util;

import java.util.List;

public class Pager<T> {
	private int pageSize = 10;//每页大小
	
	private int totalCounts;//总记录数
	
	private int totalPages;//总页数:总记录数和每页大小计算
	
	private List<T> records;//数据

	//前台带过来的参数
	private Object frontParams;
	
	public Object getFrontParams() {
		return frontParams;
	}

	public void setFrontParams(Object frontParams) {
		this.frontParams = frontParams;
	}

	public Pager() {
	}
	
	public Pager(int pageSize) {
		this.pageSize=pageSize;
	}
	
	public Pager(int currentPage, int pageSize, List<T> records, int totalCounts) {
		this.pageSize = pageSize;
		this.records = records;
		this.totalCounts = totalCounts;
		int s = totalCounts / pageSize;
		int m = totalCounts % pageSize;
		if (m > 0) {
			s += 1;
		}
		this.totalPages = (s == 0 ? 1 : s);
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public List<T> getRecords() {
		return records;
	}

	public void setRecords(List<T> records) {
		this.records = records;
	}

	public int getTotalCounts() {
		return totalCounts;
	}

	public void setTotalCounts(int totalCounts) {
		this.totalCounts = totalCounts;
	}

	public int getTotalPages() {
		int s = totalCounts / pageSize;
		int m = totalCounts % pageSize;
		if (m > 0) {
			s += 1;
		}
		this.totalPages = (s == 0 ? 1 : s);
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

}
