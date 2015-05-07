package com.wiiy.pb.preferences.enums;

/**
 * 满意程度
 */
public enum SatisficingEnum {

	VerySatisfied("非常满意"),
	Satisfied("满意"),
	Dissatisfied("不满意"),
	VeryDissatisfied("很不满意");
    private String title;

    SatisficingEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
