package com.wiiy.crm.dto;

import java.util.Map;

import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.CustomerVentureType;

public class CustomerVentureTypeSearchResultDto {
	
	private Long customerId;
	private Customer customer;
	private Map<String,CustomerVentureType> map;
	
	public Long getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Map<String, CustomerVentureType> getMap() {
		return map;
	}
	public void setMap(Map<String, CustomerVentureType> map) {
		this.map = map;
	}

}
