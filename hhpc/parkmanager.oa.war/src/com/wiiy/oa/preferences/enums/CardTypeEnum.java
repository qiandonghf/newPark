package com.wiiy.oa.preferences.enums;

public enum CardTypeEnum {
	PERSON("个人"),COMPANY("单位");
	private String title;

	CardTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
