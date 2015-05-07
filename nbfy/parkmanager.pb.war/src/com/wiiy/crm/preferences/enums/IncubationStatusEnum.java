package com.wiiy.crm.preferences.enums;

public enum IncubationStatusEnum {
    INCUBATING("在孵企业"),  // 在孵企业
    GRADUATED("毕业企业"),   // 毕业企业
    INCOMPLETED("肄业企业"), // 肄业企业
    ELIMINATED("淘汰企业");   // 淘汰企业
	
	private String title;

	IncubationStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
