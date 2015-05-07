package com.wiiy.crm.preferences.enums;

public enum PriorityEnum {
	HIGH("高"),MIDDLE("中"),LOW("低");
	
	private String title;

	PriorityEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
