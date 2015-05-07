package com.wiiy.pb.dto;

import java.util.Date;
import java.util.List;

import com.wiiy.pb.entity.FacilityOrder;


public class WeekDto {
	private Integer year;
	private Integer week;
	private List<Date> dateList;
	private Integer num = 0;
	private List<FacilityOrder> facilityOrderList;
	private List<FacilityDto> facilityDtoList;
	
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Integer getWeek() {
		return week;
	}
	public void setWeek(Integer week) {
		this.week = week;
	}
	public List<Date> getDateList() {
		return dateList;
	}
	public void setDateList(List<Date> dateList) {
		this.dateList = dateList;
	}
	public List<FacilityOrder> getFacilityOrderList() {
		return facilityOrderList;
	}
	public void setFacilityOrderList(List<FacilityOrder> facilityOrderList) {
		this.facilityOrderList = facilityOrderList;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public List<FacilityDto> getFacilityDtoList() {
		return facilityDtoList;
	}
	public void setFacilityDtoList(List<FacilityDto> facilityDtoList) {
		this.facilityDtoList = facilityDtoList;
	}
}
