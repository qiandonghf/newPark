package com.wiiy.crm.preferences.enums;

/**
 * 合同类型
 */
public enum ContractItemEnum {

	/*FZFQY("非在孵企业"),KDWJRXYS("宽带网接入协议书"),ZFQY("在孵企业"),ZCQLXSQY("政策期留学生企业"),ZCQZFQY("政策期在孵企业");*/
	WYGL("物业管理合同"),CFZL("厂房租赁合同"),BGLZL("办公楼租赁合同");
	
    private String title;

    ContractItemEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
