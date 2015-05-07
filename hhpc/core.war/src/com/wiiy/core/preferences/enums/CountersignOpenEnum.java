package com.wiiy.core.preferences.enums;

public enum CountersignOpenEnum {
	CLOSE("关闭状态"),UNDONE("开启状态");
	
	private String title;

	CountersignOpenEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
