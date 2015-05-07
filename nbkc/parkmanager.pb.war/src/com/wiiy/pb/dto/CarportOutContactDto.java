package com.wiiy.pb.dto;

import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.User;

public class CarportOutContactDto {
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
	 * 经办人
	 */
	@FieldDescription("经办人")
	private String responsible;
	/**
	 * 经办人手机
	 */
	@FieldDescription("经办人手机")
	private String phone;
	/**
	 * 退租单位
	 */
	@FieldDescription("退租单位")
	private String customer;
	/**
	 * 退租原因
	 */
	@FieldDescription("退租原因")
	private String reason;
	/**
	 * 原租赁车 位号
	 */
	@FieldDescription("原租赁车 位号")
	private String carport;
	/**
	 * 车 位个数
	 */
	@FieldDescription("车 位个数")
	private String number;
	/**
	 * 租赁开始时间
	 */
	@FieldDescription("租赁开始时间")
	private Date rentStart;
	/**
	 * 租赁结束时间
	 */
	@FieldDescription("租赁结束时间")
	private Date rentEnd;
	/**
	 * 退赁开始时间
	 */
	@FieldDescription("退赁开始时间")
	private Date rentOutStart;
	/**
	 * 退赁结束时间
	 */
	@FieldDescription("退赁结束时间")
	private Date rentOutEnd;
	/**
	 * 退赁金额
	 */
	@FieldDescription("退赁金额")
	private String money;
	/**
	 * 创业服务中心核实意见
	 */
	@FieldDescription("创业服务中心核实意见")
	private String opinion1;
	/**
	 * 科技园发展有限公财务部审核
	 */
	@FieldDescription("科技园发展有限公财务部审核")
	private String opinion2;
	/**
	 * 南都物业物管中心财务审核
	 */
	@FieldDescription("南都物业物管中心财务审核")
	private String opinion3;
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
	public String getResponsible() {
		return responsible;
	}
	public void setResponsible(String responsible) {
		this.responsible = responsible;
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
	public String getCarport() {
		return carport;
	}
	public void setCarport(String carport) {
		this.carport = carport;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public Date getRentStart() {
		return rentStart;
	}
	public void setRentStart(Date rentStart) {
		this.rentStart = rentStart;
	}
	public Date getRentEnd() {
		return rentEnd;
	}
	public void setRentEnd(Date rentEnd) {
		this.rentEnd = rentEnd;
	}
	public Date getRentOutStart() {
		return rentOutStart;
	}
	public void setRentOutStart(Date rentOutStart) {
		this.rentOutStart = rentOutStart;
	}
	public Date getRentOutEnd() {
		return rentOutEnd;
	}
	public void setRentOutEnd(Date rentOutEnd) {
		this.rentOutEnd = rentOutEnd;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
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
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
}
