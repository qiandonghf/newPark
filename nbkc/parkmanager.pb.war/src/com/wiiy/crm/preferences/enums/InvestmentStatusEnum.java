package com.wiiy.crm.preferences.enums;

public enum InvestmentStatusEnum {
	NEW("正常"),SLEEP("睡眠"),APPROVAL("审批中"),AGREE("等待入驻"),DISAGREE("否决"),PARK("已入驻");
	
	private String title;

	InvestmentStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
