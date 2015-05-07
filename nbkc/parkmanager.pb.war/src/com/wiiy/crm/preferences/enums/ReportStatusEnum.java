package com.wiiy.crm.preferences.enums;
/**
 * 报表状态
 * @author aswan
 * 
 */
public enum ReportStatusEnum {
	UNPUB("未发布"),PUBED("已发布"),CLOSE("已关闭");
	private String title;

	ReportStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
