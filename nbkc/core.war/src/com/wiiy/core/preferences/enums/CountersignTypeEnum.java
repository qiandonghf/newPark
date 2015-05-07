package com.wiiy.core.preferences.enums;

public enum CountersignTypeEnum {
	PROCESS("入驻企业流程单"),EXPIRE("合同到期审批单"),REVIEW("合同会签审核单");
	
	private String title;

	CountersignTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
