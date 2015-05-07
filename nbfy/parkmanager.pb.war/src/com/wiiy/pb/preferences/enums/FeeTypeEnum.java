package com.wiiy.pb.preferences.enums;

public enum FeeTypeEnum {
	WATER("水表"),ELECTRICITY("电表"),GAS("气表");
    private String title;

    FeeTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
