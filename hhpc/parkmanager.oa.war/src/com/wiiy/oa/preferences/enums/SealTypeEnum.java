package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 *印章类型枚举
 */
public enum SealTypeEnum {
	LEGAL("法人章"),COMPANY("公章"),FINANCE("财务章"),CONTRACT("合同章");
	private String title;

	SealTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
