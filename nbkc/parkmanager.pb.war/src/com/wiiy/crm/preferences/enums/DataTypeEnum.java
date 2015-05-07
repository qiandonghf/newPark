package com.wiiy.crm.preferences.enums;
/**
 * 报表数据类型
 * @author aswan
 *
 */
public enum DataTypeEnum {
	INT("整数"),DOUBLE("小数"),STRING("文本"),SELECT("列表选择"),DATETIME("日期");
	private String title;

	DataTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
