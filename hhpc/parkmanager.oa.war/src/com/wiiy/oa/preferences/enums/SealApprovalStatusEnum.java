package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 *印章审批状态枚举
 */
public enum SealApprovalStatusEnum {
	PENDING("待审批"),AGREE("同意"),DISAGREE("不同意");
	private String title;

	SealApprovalStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
