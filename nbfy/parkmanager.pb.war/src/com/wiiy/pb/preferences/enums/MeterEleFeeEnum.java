package com.wiiy.pb.preferences.enums;

public enum MeterEleFeeEnum {
	WATER("水费"),ELECTRICITY("电费");
	private String title;

	public String getTitle() {
		return title;
	}

	MeterEleFeeEnum(String title) {
		this.title = title;
	}
	
}
