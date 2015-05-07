package com.wiiy.oa.preferences.enums;
/**
 * 
 * @author Aswan
 *请假类型枚举
 */
public enum LeaveTypeEnum {
	//病假、事假、年休假、婚假、产护理假、丧假、其他
	//Sick leave, personal leave, annual leave, marriage leave, production care leave, bereavement leave, other
	SICK("病假"),PERSONAL("事假"),ANNUAL("年休假"),MARRIAGE("婚假"),PRODUCTIONCARE("产护理假"),BEREAVEMENT("丧假"),OTHER("其他");
	private String title;

	LeaveTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
