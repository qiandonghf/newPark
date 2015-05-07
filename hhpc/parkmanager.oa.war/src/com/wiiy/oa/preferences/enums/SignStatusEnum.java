package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Administrator
 *签到签退状态枚举
 */
public enum SignStatusEnum {
	NORMAL("正常"),LATE("迟到"),LEAVEEARLY("早退");
	private String title;

	SignStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
