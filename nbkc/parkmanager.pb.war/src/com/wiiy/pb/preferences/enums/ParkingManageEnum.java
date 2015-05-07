package com.wiiy.pb.preferences.enums;

public enum ParkingManageEnum {
	USING("已用"),VACANT("空置");
	 private String title;

	 ParkingManageEnum (String title) {
			this.title = title;
		}

		public String getTitle() {
			return title;
		}	
}
