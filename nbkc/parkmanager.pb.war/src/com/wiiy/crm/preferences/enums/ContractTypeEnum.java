package com.wiiy.crm.preferences.enums;

/**
 * 合同类型
 */
public enum ContractTypeEnum {


	RentContract("租赁合同"),	NetWorkContract("网络合同");
    private String title;

    ContractTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
