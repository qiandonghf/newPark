package com.wiiy.oa.preferences.enums;

public enum DocTypeEnum {
	PRIVATE("个人文档"),SHARED("共享文档"),PUBLIC("公共文档");
	private String title;

	DocTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
