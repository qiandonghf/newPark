package com.wiiy.crm.preferences.enums;

public enum ContractRentStatusEnum {
		RENTOFF("退租"),RELET("续租");
		private String title;

	ContractRentStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
