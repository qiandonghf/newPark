package com.wiiy.crm.preferences.enums;

/**
 * 单位价格类型
 */
public enum PriceUnitEnum {

    DAY("元/日/平方米"),
    MONTH("元/月/平方米"),
    ONCE("一次性");
    private String title;

    PriceUnitEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
