package com.wiiy.crm.preferences.enums;

public enum CustomerRouteTypeEnum {
	
	COUNTRY("国家级"),PROVINCE("省级"),CITY("市级");
	
	private String title;

	CustomerRouteTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
