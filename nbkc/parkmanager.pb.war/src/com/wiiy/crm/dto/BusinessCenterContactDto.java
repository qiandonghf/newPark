package com.wiiy.crm.dto;

import com.wiiy.commons.annotation.FieldDescription;

public class BusinessCenterContactDto {
	/**
	 * 填表日期-年
	 */
	@FieldDescription("填表日期-年")
	private String year;
	/**
	 * 填表日期-月
	 */
	@FieldDescription("填表日期-月")
	private String month;
	/**
	 * 填表日期-日
	 */
	@FieldDescription("填表日期-日")
	private String day;
	/**
	 * 部门名称
	 */
	@FieldDescription("部门名称")
	private String org;
	/**
	 * 联系内容
	 */
	@FieldDescription("联系内容")
	private String content;
	/**
	 * 处理意见
	 */
	@FieldDescription("处理意见")
	private String opinion1;
	/**
	 * 被联系单位 或部门意见
	 */
	@FieldDescription("被联系单位 或部门意见")
	private String opinion2;
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getOrg() {
		return org;
	}
	public void setOrg(String org) {
		this.org = org;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getOpinion1() {
		return opinion1;
	}
	public void setOpinion1(String opinion1) {
		this.opinion1 = opinion1;
	}
	public String getOpinion2() {
		return opinion2;
	}
	public void setOpinion2(String opinion2) {
		this.opinion2 = opinion2;
	}
	
}
