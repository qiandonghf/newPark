package com.wiiy.crm.preferences.enums;
/**
 * 押金类型
 * @author Aswan
 *
 */
public enum DepositTypeEnum {
	WATERELECTRICITY("水电费押金"),ROOM("房租押金");
	private String title;

	DepositTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
