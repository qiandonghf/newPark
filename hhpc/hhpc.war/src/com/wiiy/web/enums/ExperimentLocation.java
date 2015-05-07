package com.wiiy.web.enums;

public enum ExperimentLocation {
	
	F1("1楼"),F2("2楼"),F3("3楼"),F4("4楼"),F5("5楼"),R461("461室"),R456("456室"),D248("248室"),D523_525("523-525室"),D545("545室"),D547("547室"),D549("549室"),D551("551室"),D553("553室"),D555_557("555-557室"),D563("563室"),
	F249_251("249-251室"),F361_363("361-363室"),F320_324("320-324室");
	
	private String title;
	
	ExperimentLocation(String title){
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
	
}
