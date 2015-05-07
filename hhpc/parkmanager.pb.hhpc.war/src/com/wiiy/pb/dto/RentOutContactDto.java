package com.wiiy.pb.dto;

import com.wiiy.commons.annotation.FieldDescription;

public class RentOutContactDto {
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
	 * 原租赁房屋 房号/面积
	 */
	@FieldDescription("原租赁房屋 房号/面积")
	private String room;
	/**
	 * 企业名称
	 */
	@FieldDescription("企业名称")
	private String customer;
	/**
	 * 退房原因
	 */
	@FieldDescription("退房原因")
	private String reason;
	/**
	 * 管委会创业服务部初审意见
	 */
	@FieldDescription("管委会创业服务部初审意见")
	private String opinion1;
	/**
	 * 管委（公司）领导批复意见
	 */
	@FieldDescription("管委（公司）领导批复意见")
	private String opinion2;
	/**
	 * 管委会企业发展部注册变更审核意见
	 */
	@FieldDescription("管委会企业发展部注册变更审核意见")
	private String opinion3;
	/**
	 * 管委会财务部审核意见
	 */
	@FieldDescription("管委会财务部审核意见")
	private String opinion4;
	/**
	 * 南都物业服务中心验房审核意见
	 */
	@FieldDescription("南都物业服务中心验房审核意见")
	private String opinion5;
	/**
	 * 南都物业服务中心（财务）审核意见
	 */
	@FieldDescription("南都物业服务中心（财务）审核意见")
	private String opinion6;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String description;
	
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
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
	public String getOpinion3() {
		return opinion3;
	}
	public void setOpinion3(String opinion3) {
		this.opinion3 = opinion3;
	}
	public String getOpinion4() {
		return opinion4;
	}
	public void setOpinion4(String opinion4) {
		this.opinion4 = opinion4;
	}
	public String getOpinion5() {
		return opinion5;
	}
	public void setOpinion5(String opinion5) {
		this.opinion5 = opinion5;
	}
	public String getOpinion6() {
		return opinion6;
	}
	public void setOpinion6(String opinion6) {
		this.opinion6 = opinion6;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
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
}
