package com.wiiy.crm.dto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.wiiy.crm.entity.Bill;
import com.wiiy.crm.entity.BillType;

public class BillInformDto {
	
	private Long customerId;
	private String customerName;
	
	private Double total;
	
	private List<Bill> billList;
	
	private Map<Long,BillType> billTypeMap;
	
	public void add(Bill bill) {
		billList.add(bill);
		total += bill.getFactPayment();
		if(bill.getBillTypeId()!=null){
			if(!billTypeMap.containsKey(bill.getBillTypeId())){
				billTypeMap.put(bill.getBillTypeId(),bill.getBillType());
			}
		}
	}

	
	public BillInformDto(Long customerId, String customerName) {
		this.customerId = customerId;
		this.customerName = customerName;
		total = 0d;
		billList = new ArrayList<Bill>();
		billTypeMap = new HashMap<Long,BillType>();
	}

	public Long getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Long customerId) {
		this.customerId = customerId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public Double getTotal() {
		return total;
	}

	public void setTotal(Double total) {
		this.total = total;
	}

	public List<Bill> getBillList() {
		return billList;
	}

	public void setBillList(List<Bill> billList) {
		this.billList = billList;
	}


	public Map<Long, BillType> getBillTypeMap() {
		return billTypeMap;
	}


	public void setBillTypeMap(Map<Long, BillType> billTypeMap) {
		this.billTypeMap = billTypeMap;
	}

	
}
