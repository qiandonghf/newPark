package com.wiiy.oa.dto;

import java.util.Date;
import java.util.List;

import com.wiiy.commons.util.DateUtil;


public class DateDto {
	private Date date;
	private String day;
	private List<DayDto> dayDtoList; 
	
	public DateDto(Date date,String day) {
		super();
		this.date = date;
		this.day = day;
	}
	
	public Date getDate() {
		return date;
	}
	public String getDay() {
		return DateUtil.format(date,"d");
	}

	public List<DayDto> getDayDtoList() {
		return dayDtoList;
	}

	public void setDayDtoList(List<DayDto> dayDtoList) {
		this.dayDtoList = dayDtoList;
	}

	
}
