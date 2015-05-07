package com.wiiy.crm.preferences.enums;
/**
 * 报表类型
 * @author aswan
 * 
 */
public enum ReportTypeEnum {
	MONTH("月报"),SEASON("季报"),HALFYEAR("半年报"),YEAR("年报"),TEMP("临时");
	private String title;

	ReportTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
