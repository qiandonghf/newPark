	package com.wiiy.crm.dto;

import java.util.List;

import com.wiiy.crm.entity.DataReport;

public class DataReportDto {
	private String groupName;
	private List<DataReport> dataReportList;
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public List<DataReport> getDataReportList() {
		return dataReportList;
	}
	public void setDataReportList(List<DataReport> dataReportList) {
		this.dataReportList = dataReportList;
	}
	
}
