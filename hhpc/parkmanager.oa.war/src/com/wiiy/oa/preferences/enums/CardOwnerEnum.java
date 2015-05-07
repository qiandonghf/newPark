package com.wiiy.oa.preferences.enums;

public enum CardOwnerEnum {
	PRIVATE("私有"),PUBLIC("公共");
	private String title;

	CardOwnerEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
