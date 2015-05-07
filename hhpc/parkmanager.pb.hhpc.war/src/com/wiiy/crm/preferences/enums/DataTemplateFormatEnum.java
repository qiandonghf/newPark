package com.wiiy.crm.preferences.enums;

import java.util.List;
import java.util.Map;

import com.wiiy.crm.entity.DataProperty;
import com.wiiy.crm.entity.DataReportProperty;
import com.wiiy.crm.entity.DataReportValue;
import com.wiiy.crm.preferences.format.BusinessDataReportFormat;
import com.wiiy.crm.preferences.format.DataReportFormat;
import com.wiiy.crm.preferences.format.DefaultReportFormat;

public enum DataTemplateFormatEnum {
	
	DEFAULT("默认", new DefaultReportFormat()),BUSINESSDATA("企业经营数据",new BusinessDataReportFormat());
	private String title;
	private DataReportFormat format;

	DataTemplateFormatEnum(String title, DataReportFormat format) {
		this.title = title;
		this.format = format;
	}

	public String getTitle() {
		return title;
	}
	
	public String format(List<DataProperty> propertyList){
		return format.format(propertyList);
	}
	public String format(List<DataReportProperty> propertyList,Map<Long, DataReportValue> valueMap){
		return format.format(propertyList,valueMap);
	}

}