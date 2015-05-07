package com.wiiy.oa.preferences.enums;

public enum ContractCharacterEnum {
	PRIVATE("私有"),PUBLIC("公共");
	private String title;

	ContractCharacterEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
