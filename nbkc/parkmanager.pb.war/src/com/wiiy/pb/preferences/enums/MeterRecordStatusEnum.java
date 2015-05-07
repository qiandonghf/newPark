package com.wiiy.pb.preferences.enums;

public enum MeterRecordStatusEnum {
	INITIAL("初始"),GENERATED("已生成"),CKECKOUT("已出账");
    private String title;

    MeterRecordStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
