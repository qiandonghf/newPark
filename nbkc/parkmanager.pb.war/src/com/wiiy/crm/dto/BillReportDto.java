package com.wiiy.crm.dto;

import java.util.List;

public class BillReportDto {
	private String customerName;
	private String time;
	private List<StatisticDto> inOutList;
	private Double totalIn;
	private Double totalOut;
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	public Double getTotalIn() {
		return totalIn;
	}
	public void setTotalIn(Double totalIn) {
		this.totalIn = totalIn;
	}
	public Double getTotalOut() {
		return totalOut;
	}
	public void setTotalOut(Double totalOut) {
		this.totalOut = totalOut;
	}
	public List<StatisticDto> getInOutList() {
		return inOutList;
	}
	public void setInOutList(List<StatisticDto> inOutList) {
		this.inOutList = inOutList;
	}
	
}
