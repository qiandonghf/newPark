package com.wiiy.crm.dto;

import java.util.Map;

import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.IncubationRoute;

public class IncubationRouteSearchResultDto {
	
	private Long customerId;
	private Customer customer;
	private Map<String,IncubationRoute> map;
	
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
	public Map<String, IncubationRoute> getMap() {
		return map;
	}
	public void setMap(Map<String, IncubationRoute> map) {
		this.map = map;
	}
	
}
