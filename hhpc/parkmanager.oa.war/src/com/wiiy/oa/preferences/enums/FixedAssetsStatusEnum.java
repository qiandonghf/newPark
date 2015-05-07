package com.wiiy.oa.preferences.enums;

public enum FixedAssetsStatusEnum {
	NORMAL("使用中"),BROKEN("报废");
	private String title;

	FixedAssetsStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
