package com.wiiy.oa.preferences.enums;

public enum ReportStatusEnum {
	NORMAL("完成"),UNFINISH("进行中"),LATE("延迟");
	private String title;

	ReportStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
