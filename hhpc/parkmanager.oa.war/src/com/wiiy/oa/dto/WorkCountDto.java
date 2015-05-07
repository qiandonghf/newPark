package com.wiiy.oa.dto;

import java.util.List;

public class WorkCountDto {
	private Long id;
	private String username;
	private List<MonthDto> monthDtoList;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public List<MonthDto> getMonthDtoList() {
		return monthDtoList;
	}
	public void setMonthDtoList(List<MonthDto> monthDtoList) {
		this.monthDtoList = monthDtoList;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}

}
