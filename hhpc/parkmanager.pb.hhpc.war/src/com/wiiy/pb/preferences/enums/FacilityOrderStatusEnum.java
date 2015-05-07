package com.wiiy.pb.preferences.enums;

/**
 * 设施使用状态
 */
public enum FacilityOrderStatusEnum {

    APPLY("申请"),AFREE("同意使用"),END("结束"),DISAFREE("不同意使用");
    //APPLY=申请
    //USING=使用
    //END=结束
    private String title;

    FacilityOrderStatusEnum(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}	
}
