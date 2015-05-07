package com.wiiy.cms.preferences.enums;
/**
 * 
 * @author Aswan
 *水印位置枚举
 */
public enum FloatingTypeEnum {
	
	FLOATING("漂浮"),LEFT("左侧浮动"),RIGHT("右侧浮动");
	private String title;

	FloatingTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
