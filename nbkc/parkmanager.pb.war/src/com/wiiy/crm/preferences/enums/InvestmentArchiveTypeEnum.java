package com.wiiy.crm.preferences.enums;

public enum InvestmentArchiveTypeEnum {
	
	YYZZ("营业执照"),ZZJG("组织机构代码证"),GSDJ("国税登记证"),GSZC("公司章程复印件"),FRGD("法人股东的营业执照"),YZBG("验资报告"),FRDB("法定代表人任职文件"),OTHER("其它");
	
	private String title;

	InvestmentArchiveTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
