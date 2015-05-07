package com.wiiy.crm.preferences.enums;
/**
 * 资金计划状态
 * @author Aswan
 *
 */
public enum BillPlanStatusEnum {
    UNCHECK("未出账"), 
    INCHECKED("收款出账"),  
    OUTCHECKED("退款出账"),
    CHARGEOFF("已核销");

	
	private String title;

	BillPlanStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
