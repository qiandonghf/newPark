package com.wiiy.crm.preferences.enums;
/**
 * 企业服务单状态
 * @author aswan
 *
 */
public enum CustomerServiceStatusEnum {
	ACCEPT("受理"),PENDING("挂起"),CLOSE("关闭")/*,FINISH("完成")*/;
	private String title;

	CustomerServiceStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
