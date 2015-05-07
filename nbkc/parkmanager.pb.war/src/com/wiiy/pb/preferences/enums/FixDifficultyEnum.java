package com.wiiy.pb.preferences.enums;

/**
 * 维修难度
 */
public enum FixDifficultyEnum {

	High("高"),
	Medium("中"),
    Low("低");
    private String title;

    FixDifficultyEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
