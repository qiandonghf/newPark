package com.wiiy.pb.preferences.enums;

public enum MeterStatusEnum {
	NORMAL("正常"),PRESERVE("维护");
    private String title;

    MeterStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
