package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 * 车辆状态
 *
 */
public enum CarStatusEnum{
	NORMAL("正常"),FIXING("维修"),SCRAPPED("报废");
	private String title;

	CarStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
