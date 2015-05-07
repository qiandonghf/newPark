package com.wiiy.pb.dto;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.pb.entity.Room;

public class TenementCenterContactDto {
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
	 * 房间
	 */
	@FieldDescription("房间")
	private String room;
	/**
	 * 企业名称
	 */
	@FieldDescription("企业名称")
	private String customer;
	/**
	 * 联系内容
	 */
	@FieldDescription("联系内容")
	private String content;
	/**
	 * 物业部门意见
	 */
	@FieldDescription("物业部门意见")
	private String opinion1;
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
	
}
