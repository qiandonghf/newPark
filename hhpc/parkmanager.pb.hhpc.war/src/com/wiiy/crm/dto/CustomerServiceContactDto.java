package com.wiiy.crm.dto;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.Org;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.preferences.enums.CustomerServiceResultEnum;

public class CustomerServiceContactDto {
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
	 * 企业
	 */
	@FieldDescription("企业")
	private String customer;
	/**
	 * 受理部门
	 */
	@FieldDescription("受理部门")
	private String org;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private String contectName;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 受理开始日期
	 */
	@FieldDescription("受理开始日期")
	private String startDate;
	/**
	 * 服务类型
	 */
	@FieldDescription("服务类型")
	private String type;
	/**
	 * 受理人
	 */
	@FieldDescription("受理人")
	private String userName;
	/**
	 * 服务结果
	 */
	@FieldDescription("服务结果")
	private String result;
	/**
	 * 客服意见及建议
	 */
	@FieldDescription("客服意见及建议")
	private String suggest;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private String status;
	/**
	 * 处理意见
	 */
	@FieldDescription("处理意见")
	private String opinion1;
	/**
	 * 情况说明
	 */
	@FieldDescription("情况说明")
	private String description;
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
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	public String getOrg() {
		return org;
	}
	public void setOrg(String org) {
		this.org = org;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getSuggest() {
		return suggest;
	}
	public void setSuggest(String suggest) {
		this.suggest = suggest;
	}
	public String getOpinion1() {
		return opinion1;
	}
	public void setOpinion1(String opinion1) {
		this.opinion1 = opinion1;
	}
	public String getContectName() {
		return contectName;
	}
	public void setContectName(String contectName) {
		this.contectName = contectName;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
}
