package com.wiiy.crm.dto;

import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportValue;

public class DataPropertyDto {
	
	private DataReportProperty dataReportProperty;
	private DataReportValue dataReportValue;
	
	public DataPropertyDto() {
	}
	
	public DataPropertyDto(DataReportProperty dataReportProperty,
			DataReportValue dataReportValue) {
		this.dataReportProperty = dataReportProperty;
		this.dataReportValue = dataReportValue;
	}

	
	public DataReportProperty getDataReportProperty() {
		return dataReportProperty;
	}
	public void setDataReportProperty(DataReportProperty dataReportProperty) {
		this.dataReportProperty = dataReportProperty;
	}
	public DataReportValue getDataReportValue() {
		return dataReportValue;
	}
	public void setDataReportValue(DataReportValue dataReportValue) {
		this.dataReportValue = dataReportValue;
	}

}
