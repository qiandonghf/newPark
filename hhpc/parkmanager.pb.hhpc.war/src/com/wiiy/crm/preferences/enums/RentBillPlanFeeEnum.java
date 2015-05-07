package com.wiiy.crm.preferences.enums;
/**
 * 租赁合同资金计划费用类型
 * @author Aswan
 *
 */
public enum RentBillPlanFeeEnum {
    RENT("租金"), 
    MANAGE("物管费"),
    ENERGY("能源损耗费");
	
	private String title;

	RentBillPlanFeeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
