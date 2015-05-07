package com.wiiy.core.preferences.enums;

public enum ApprovalTypeEnum {
	CONTRACT ("合同"),
	PROCESS ("入驻企业流程单"),
	EXPIRE ("合同到期"),
	REVIEW ("合同会签"),
	INVESTMENT("项目");
	private String title;

	ApprovalTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
