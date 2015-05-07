package com.wiiy.crm.preferences.enums;

public enum InvestmentAttTypeEnum {
	CONTRACT("合同电子稿"),CONTRACTSCAN("合同扫描件"),AGREEMENT("协议"),AGREEMENTSCAN("协议扫描件"),POLICY("优惠政策");
	
	private String title;

	InvestmentAttTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
