package com.wiiy.core.preferences.enums;

public enum ApprovalStatusEnum {
	UNDETERMINED("待定"),
	AGREE("同意"), 
    DISAGREE("不同意");
	private String title;

	ApprovalStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
