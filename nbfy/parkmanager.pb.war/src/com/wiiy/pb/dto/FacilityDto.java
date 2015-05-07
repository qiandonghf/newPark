package com.wiiy.pb.dto;

import java.util.Date;
import java.util.List;

import com.wiiy.pb.entity.FacilityOrder;

public class FacilityDto {
	private Date date;
	private List<FacilityOrder> facilityOrderList;
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public List<FacilityOrder> getFacilityOrderList() {
		return facilityOrderList;
	}
	public void setFacilityOrderList(List<FacilityOrder> facilityOrderList) {
		this.facilityOrderList = facilityOrderList;
	}
	
}
