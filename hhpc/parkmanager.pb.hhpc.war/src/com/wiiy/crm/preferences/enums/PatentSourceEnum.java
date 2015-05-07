package com.wiiy.crm.preferences.enums;
/**
 * 专利来源
 * @author Aswan
 *
 */
public enum PatentSourceEnum {
	INTERNAL ("国内"), 
	EXTERNAL("国外");
	
	private String title;

	PatentSourceEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
