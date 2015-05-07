package com.wiiy.core.preferences.enums;

public enum ContactStatusEnum {
	ACCEPT("受理"),CLOSE("关闭"),SUSPEND("挂起");
	
	private String title;

	ContactStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
