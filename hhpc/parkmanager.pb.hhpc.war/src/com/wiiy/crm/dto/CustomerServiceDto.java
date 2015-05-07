package com.wiiy.crm.dto;

import java.util.List;

public class CustomerServiceDto {
	
	private String createdDate;
	private String customerName;
	private String type;
	private String contectName;
	private String startDate;
	private String endDate;
	private String phone;
	private String userName;

	private String orgName;
	private String serviceResult;
	private String status;
	private String description;
	private String suggest;
	
	private	List<CustomerServiceTrackDto> list;
	
	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContectName() {
		return contectName;
	}

	public void setContectName(String contectName) {
		this.contectName = contectName;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getOrgName() {
		return orgName;
	}

	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}

	public String getServiceResult() {
		return serviceResult;
	}

	public void setServiceResult(String serviceResult) {
		this.serviceResult = serviceResult;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSuggest() {
		return suggest;
	}

	public void setSuggest(String suggest) {
		this.suggest = suggest;
	}

	public List<CustomerServiceTrackDto> getList() {
		return list;
	}

	public void setList(List<CustomerServiceTrackDto> list) {
		this.list = list;
	}

}
