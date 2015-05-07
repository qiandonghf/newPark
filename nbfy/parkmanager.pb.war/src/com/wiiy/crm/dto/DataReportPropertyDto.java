package com.wiiy.crm.dto;

import java.util.ArrayList;
import java.util.List;

import com.wiiy.crm.entity.DataReportProperty;

public class DataReportPropertyDto {
	
	private Long id;
	
	private DataReportProperty property;
	
	private Double dcount;
	
	private Integer icount;
	
	private String name;
	
	private List<DataReportPropertyDto> propertyList;
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public DataReportPropertyDto() {
		propertyList = new ArrayList<DataReportPropertyDto>();
		icount = 0;
		dcount = 0d;
	}

	public List<DataReportPropertyDto> getPropertyList() {
		return propertyList;
	}

	public void setPropertyList(List<DataReportPropertyDto> propertyList) {
		this.propertyList = propertyList;
	}

	public DataReportProperty getProperty() {
		return property;
	}

	public void setProperty(DataReportProperty property) {
		this.property = property;
	}

	public Double getDcount() {
		return dcount;
	}

	public void setDcount(Double dcount) {
		this.dcount = dcount;
	}

	public Integer getIcount() {
		return icount;
	}

	public void setIcount(Integer icount) {
		this.icount = icount;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	
	
}
