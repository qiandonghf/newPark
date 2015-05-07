package com.wiiy.crm.preferences.enums;

/**
 * 网络单价类型
 */
public enum NetworkPriceUnitEnum {

    
    MONTH("元/月"),
    YEAR("元/年"),
    ONCE("一次性");
    private String title;

    NetworkPriceUnitEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
