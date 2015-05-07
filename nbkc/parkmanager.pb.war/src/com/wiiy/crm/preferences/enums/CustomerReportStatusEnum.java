package com.wiiy.crm.preferences.enums;

public enum CustomerReportStatusEnum {
	
	UNPUB("未上报"),
	SAVED("已保存"),
	PUB("已上报"),
	BACK("退回");
	
	private String title;

	CustomerReportStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
