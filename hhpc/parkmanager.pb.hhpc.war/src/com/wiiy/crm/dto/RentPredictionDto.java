package com.wiiy.crm.dto;

import com.wiiy.crm.preferences.enums.BillPlanStatusEnum;

public class RentPredictionDto {
	private String year;
	private BillPlanStatusEnum status;
	private double fee;
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public BillPlanStatusEnum getStatus() {
		return status;
	}
	public void setStatus(BillPlanStatusEnum status) {
		this.status = status;
	}
	public double getFee() {
		return fee;
	}
	public void setFee(double fee) {
		this.fee = fee;
	}
	
}
