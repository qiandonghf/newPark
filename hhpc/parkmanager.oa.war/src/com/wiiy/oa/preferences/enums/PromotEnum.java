package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 日程提醒方式
 *
 */
public enum PromotEnum {
	NOPROMOT("不提醒"),NOW("立即提醒"),LASTDAY("前一天"),CURRENTDAY("同一日"),SPECIALDAY("指定时间");
	private String title;

	PromotEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
