package com.wiiy.oa.preferences.enums;
/*
 * 
 * 职位状态
 */
public enum PositionConditionEnum {
	WORK("在职"),NOTWORK("离职");
	private String title;
	
	PositionConditionEnum(String title){
		this.title = title;
	}
	public String getTitle() {
		return title;
	}
}
