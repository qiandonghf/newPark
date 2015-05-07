package com.wiiy.core.preferences.enums;

public enum CountersignStatusEnum {
	CLOSE("开启状态"),UNDONE("关闭状态");
	
	private String title;

	CountersignStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
