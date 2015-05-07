package com.wiiy.crm.preferences.enums;
/**
 * 租赁合同标的类型
 * @author Aswan
 *
 */
public enum SubjectRentEnum {
    RENT("租金"), 
    MANAGE("物管费");
	
	private String title;

	SubjectRentEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
