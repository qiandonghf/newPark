package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 工作汇报状态
 *
 */
public enum WorkReportStatusEnum {
	TEMPORARY("暂存"),REPORTED("已提交");
	private String title;

	WorkReportStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
