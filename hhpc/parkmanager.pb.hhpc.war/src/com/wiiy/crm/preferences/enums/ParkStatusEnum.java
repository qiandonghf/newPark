package com.wiiy.crm.preferences.enums;

public enum ParkStatusEnum {
	APPLY("申请"),INPARK("入驻"),OUTPARK("迁出");
	
	private String title;

	ParkStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
