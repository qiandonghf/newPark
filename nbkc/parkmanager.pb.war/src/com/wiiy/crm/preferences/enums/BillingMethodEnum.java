package com.wiiy.crm.preferences.enums;

/**
 * 计费方式
 */
public enum BillingMethodEnum {
//    0：按时计费
//    1：按天计费
//    2：按月计费
//    3：按年计费
//    4：按固定价格计费

    HOUR("按时计费"),
    DAY("按天计费"),
    MONTH("按月计费"),
    YEAR("按年计费"),
    FIXED("按固定价格计费");
    private String title;

    BillingMethodEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
