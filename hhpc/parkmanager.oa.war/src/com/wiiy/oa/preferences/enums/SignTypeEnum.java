package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Administrator
 *签到 签退枚举
 */
public enum SignTypeEnum {
	IN("签到"),OUT("签退");
	private String title;

	SignTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
