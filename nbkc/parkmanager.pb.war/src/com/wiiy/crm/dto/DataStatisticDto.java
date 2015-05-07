package com.wiiy.crm.dto;

import java.util.Date;

public class DataStatisticDto {
	private Long id;
	private String name;
	private Double dValue;
	private Integer iValue;
	private Date date;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
}
