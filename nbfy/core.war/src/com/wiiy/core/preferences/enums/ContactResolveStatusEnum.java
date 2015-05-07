package com.wiiy.core.preferences.enums;

public enum ContactResolveStatusEnum {
	UNSOLVED("未解决"),SOLVED("已解决"),PARTSOLVED("部分解决");
	private String title;

	ContactResolveStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

}
