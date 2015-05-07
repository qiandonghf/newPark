package com.wiiy.crm.dto;

public class StatisticDto {
	
	private Integer iid;
	private Integer lid;
	private String name;
	private Integer amount;
	private Double dValue;
	private Double dValue2;
	private Integer iValue;
	private String memo;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAmount() {
		return amount;
	}
	public void setAmount(Integer amount) {
		this.amount = amount;
	}
	public Double getdValue() {
		return dValue;
	}
	public void setdValue(Double dValue) {
		this.dValue = dValue;
	}
	public Integer getiValue() {
		return iValue;
	}
	public void setiValue(Integer iValue) {
		this.iValue = iValue;
	}
	public Integer getIid() {
		return iid;
	}
	public void setIid(Integer iid) {
		this.iid = iid;
	}
	public Integer getLid() {
		return lid;
	}
	public void setLid(Integer lid) {
		this.lid = lid;
	}
	public Double getdValue2() {
		return dValue2;
	}
	public void setdValue2(Double dValue2) {
		this.dValue2 = dValue2;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
}
