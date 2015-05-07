package com.wiiy.core.preferences.enums;

public enum ContactTypeEnum {
	INVESTMENTCONTACT("招商项目审批联系单"),RENTOUTCONTACT("退房联系单"),BUSINESSCENTERCONTACT("创业服务中心工作联系单"),TENEMENTCENTERCONTACT("物业客户服务中心联系单"),FINANCECONTACT("财务联系单"),CARPORTOUTCONTACT("车位退租确认单"),CUSTOMERSERVICECONTACT("客服联系单");
	
	private String title;

	ContactTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
