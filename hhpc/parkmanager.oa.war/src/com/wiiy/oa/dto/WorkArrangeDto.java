package com.wiiy.oa.dto;

import java.util.List;


public class WorkArrangeDto {
	private List<WorkClassDto> workClassList;
	private String rest;
	public String getRest() {
		return rest;
	}
	public void setRest(String rest) {
		this.rest = rest;
	}
	public List<WorkClassDto> getWorkClassList() {
		return workClassList;
	}
	public void setWorkClassList(List<WorkClassDto> workClassList) {
		this.workClassList = workClassList;
	}
	
}
