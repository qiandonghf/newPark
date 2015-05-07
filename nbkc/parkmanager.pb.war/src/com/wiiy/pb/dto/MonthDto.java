package com.wiiy.pb.dto;

import java.util.ArrayList;
import java.util.List;

public class MonthDto {
	Integer year;
	Integer month;
	List<WeekDto> weekList;
	Integer num = 0;
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public MonthDto() {
		weekList = new ArrayList<WeekDto>();
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public List<WeekDto> getWeekList() {
		return weekList;
	}
	public void setWeekList(List<WeekDto> weekList) {
		this.weekList = weekList;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
}
