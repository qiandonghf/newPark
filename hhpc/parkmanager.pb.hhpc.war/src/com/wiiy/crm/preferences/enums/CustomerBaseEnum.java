package com.wiiy.crm.preferences.enums;

/**
 * 合同类型
 */
public enum CustomerBaseEnum {


	SOUTH("江南基地"),NORTH("江北基地"),ACCELERATOR("加速器");
    private String title;

    CustomerBaseEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
