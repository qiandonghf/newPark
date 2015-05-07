package com.wiiy.crm.preferences.enums;
/**
 * 企业申请宣传状态
 * @author zhf
 *
 */
public enum CustomerApplyState {
	APPLYING ("申请中"),NOAPPLICATION("未申请"),AGREE("申请通过");
	private String title;

	CustomerApplyState(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
