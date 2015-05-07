package com.wiiy.crm.dto;

import java.util.Date;


public class BillOnDesktopOutDto {
	private Long billId;
	private String billType;
	private Date createTime;
	private double moneyPerBill;
	private String customerName;
	public Long getBillId() {
		return billId;
	}
	public void setBillId(Long billId) {
		this.billId = billId;
	}
	public String getBillType() {
		return billType;
	}
	public void setBillType(String billType) {
		this.billType = billType;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public double getMoneyPerBill() {
		return moneyPerBill;
	}
	public void setMoneyPerBill(double moneyPerBill) {
		this.moneyPerBill = moneyPerBill;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
}
