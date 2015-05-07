package com.wiiy.core.preferences.enums;

public enum CountersignDoneEnum {
	WAIT("待办"),ALREADY("已办");
	
	private String title;

	CountersignDoneEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
