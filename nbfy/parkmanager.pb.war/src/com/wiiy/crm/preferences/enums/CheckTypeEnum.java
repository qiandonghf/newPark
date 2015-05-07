package com.wiiy.crm.preferences.enums;
/**
 * 自检类型
 * @author Aswan
 *
 */
public enum CheckTypeEnum {
	CONTRACTEND("合同到期自检"),ROOMKIND("房间性质自检");
	
	private String title;

	CheckTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
