package com.wiiy.cms.preferences.enums;
/**
 * 
 * @author Aswan
 *水印位置枚举
 */
public enum PositionEnum {
	
	TOPLEFT("顶部居左"),TOPRIGHT("顶部居右"),BOTTOMLEFT("底部居左"),MOTTONRIGHT("底部居右");
	private String title;

	PositionEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
