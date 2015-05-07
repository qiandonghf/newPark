package com.wiiy.crm.preferences.enums;

public enum CustomerTypeEnum {
	BUSINESS("商业客户"),ENTERPRISE("企业客户"),PERSONAL("个人客户");
	private String title;

	CustomerTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
