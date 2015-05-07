package com.wiiy.crm.preferences.enums;

public enum InvestmentArchiveTypeEnum {
	
	REPORT("申请报告"),ABOUT("杭州高新区科技创业服务中心孵化企业概况表"),LEGAL("法定代表人简介"),LIST("杭州高新区科技创业服务中心孵化企业人员名单")
	,CONSTITUTION("企业章程（工商局注册文件）复印件"),IDENTITY("法定代表人身份证、学历证复印件"),LICENSE("营业执照复印件和税务登记证复印件")
	,SHAREHOLDER("法人股东的营业执照复印件"),PROJECT("研发项目简介打印稿"),OTHER("其它材料");
	
	private String title;

	InvestmentArchiveTypeEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}
}
