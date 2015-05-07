package com.wiiy.crm.preferences.enums;
/**
 * 企业服务单状态
 * @author aswan
 *
 */
public enum CustomerServiceResultEnum {
	SOLVED("已解决"),UNSOLVE("未解决"),PartSOLVED("部分解决");
	private String title;

	CustomerServiceResultEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
