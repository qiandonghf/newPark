package com.wiiy.pb.preferences.enums;

public enum MeterKindEnum {
	HOUSEHOLD("分户表"),SELF("自用表");
    private String title;

    MeterKindEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
