package com.wiiy.crm.preferences.enums;
/**
 * 账单收入支出类型
 * @author Aswan
 *
 */
public enum BillInOutEnum {
	IN ("收入"), 
    OUT("支出");

	
	private String title;

	BillInOutEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
