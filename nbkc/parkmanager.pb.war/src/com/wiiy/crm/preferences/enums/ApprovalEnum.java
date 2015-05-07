package com.wiiy.crm.preferences.enums;
/**
 * 审批状态
 * @author aswan
 *
 */
public enum ApprovalEnum {
	UNAPPROVAL("未审批"),AGRESS("同意"),DISAGRESS("不同意");
	private String title;

	ApprovalEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
