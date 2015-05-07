package com.wiiy.crm.preferences.enums;
/**
 * 账单状态
 * @author Aswan
 *
 */
public enum BillStatusEnum {
	UNPAID ("未结算"), 
    FULLPAID("结算"),
    CHARGEOFF("核销");

	
	private String title;

	BillStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
