package com.wiiy.crm.dto;

import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.entity.Staffer;

public class CustomerSearchResultDto {
	
	private Customer customer;
	private Staffer manager;
	private Staffer legal;
	
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public Staffer getManager() {
		return manager;
	}
	public void setManager(Staffer manager) {
		this.manager = manager;
	}
	public Staffer getLegal() {
		return legal;
	}
	public void setLegal(Staffer legal) {
		this.legal = legal;
	}
}
