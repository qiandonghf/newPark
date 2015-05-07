package com.wiiy.crm.preferences.enums;
/**
 * 机构类型
 * @author aswan
 *
 */
public enum AgencyEnum {
	KJZJ("科技中介"),TZJG("投资机构"),GDYX("高等院校"),OTHER("其他");
	private String title;

	AgencyEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
