package com.wiiy.pb.preferences.enums;

public enum ParkLogTypeEnums {
	 DATAREPORT("客户信息更新变化"),
	 INVESTMENT("招商日志"),
	 CUSTOMERMODIFY("企业日志"),
	 CONTRACT("合同");
	private String title;

	ParkLogTypeEnums(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
