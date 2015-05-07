package com.wiiy.oa.preferences.enums;
/**
 * 折旧周期枚举
 * @author Aswan
 *
 */
public enum DepreciationCycleEnum {
	Year("年"),Month("月");
	private String title;

	DepreciationCycleEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
