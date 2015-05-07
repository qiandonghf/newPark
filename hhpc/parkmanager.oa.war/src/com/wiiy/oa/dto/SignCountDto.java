package com.wiiy.oa.dto;

import java.util.List;

public class SignCountDto {
	private Long id;
	private String username;
	private List<MonthDto> monthDtoList;
	private MonthDto monthDto;
	private String memo;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public List<MonthDto> getMonthDtoList() {
		return monthDtoList;
	}
	public void setMonthDtoList(List<MonthDto> monthDtoList) {
		this.monthDtoList = monthDtoList;
	}
	public MonthDto getMonthDto() {
		return monthDto;
	}
	public void setMonthDto(MonthDto monthDto) {
		this.monthDto = monthDto;
	}

}
