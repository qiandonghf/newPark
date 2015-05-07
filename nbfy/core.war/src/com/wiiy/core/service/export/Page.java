package com.wiiy.core.service.export;

import java.util.List;

public class Page {

	private long totalCount;
	
	private int pageSize = 20;
	
	private int pageNo = 1;
	
	private List result;
	
	/**
	 * 总页数
	 * @return
	 */
	public long getCount(){
		return (totalCount - 1) / pageSize + 1;
	}

	public long getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public List getResult() {
		return result;
	}

	public void setResult(List result) {
		this.result = result;
	}

	
}
