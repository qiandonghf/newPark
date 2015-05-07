package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 工作计划偏差
 *
 */
public enum WorkReportOffsetEnum {
	NORMAL("正常"),LITTLE("微小偏差"),ENORMOUS("较大偏差");
	private String title;

	WorkReportOffsetEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
