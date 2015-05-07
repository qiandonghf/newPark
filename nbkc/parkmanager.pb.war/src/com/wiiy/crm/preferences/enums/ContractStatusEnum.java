package com.wiiy.crm.preferences.enums;
/**
 * 合同状态
 * @author Swan
 *
 */
public enum ContractStatusEnum {
    NEW("新建"),
    EXECUTE("已执行"),
    CLOSED("已关闭");
	
	private String title;

	ContractStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
