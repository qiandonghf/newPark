package com.wiiy.oa.preferences.enums;
/**
 * 折旧类型枚举
 * @author Aswan
 *
 */
public enum DepreciationEnum {
	Average("平均计算法");
	private String title;

	DepreciationEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
