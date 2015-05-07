package com.wiiy.crm.preferences.enums;

public enum OwnerEnum {
	PRIVATE("私有"),PUBLIC("公共");
	private String title;

	OwnerEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
