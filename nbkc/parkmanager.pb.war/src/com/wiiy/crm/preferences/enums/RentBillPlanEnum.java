package com.wiiy.crm.preferences.enums;

/**
 * 租赁资金结算方式
 */
public enum RentBillPlanEnum {
//    1：一次性结算
//    2：按月结算
//    3：按季（3个月）结算
//    4：按半年（6个月）结算
//    5：按年结算
//    6：年中结算
//    7：年底结算
    ONCE("一次性结算"),
    MONTH("按月结算"),
    THREEMONTH("按季（3个月）结算"),
    SIXMONTH("按半年（6个月）结算"),
    YEAR("按年结算"),
    MIDDLEYEAR("年中结算"),
    ENDYEAR("年底结算");
    private String title;

    RentBillPlanEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
