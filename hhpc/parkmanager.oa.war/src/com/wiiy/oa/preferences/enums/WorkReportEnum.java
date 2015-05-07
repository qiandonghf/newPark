package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 工作汇报类型
 *
 */
public enum WorkReportEnum {
	WEEK("周报"),MONTH("月报");
	private String title;

	WorkReportEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
