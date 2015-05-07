package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 日程重复方式
 *
 */
public enum RepeatEnum {
	NOREPEAT("不重复"),EVERYDAY("每天"),EVERYWORKDAY("每工作日"),EVERYWEEK("每周"),EVERYMONTH("每月"),EVERYYEAR("每年");
	private String title;

	RepeatEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
