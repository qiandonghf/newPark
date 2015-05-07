package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.crm.preferences.enums.AgencyEnum;

/**
 * <br/>class-description 机构
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Agency extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 编号
	 */
	@FieldDescription("编号")
	private Long orderId;
	/**
	 * 账号ID
	 */
	@FieldDescription("账号ID")
	private Long userId;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 是否发布到网
	 */
	@FieldDescription("是否发布到网站")
	private BooleanEnum pub;
	/**
	 * 负责人
	 */
	@FieldDescription("负责人")
	private String charger;
	/**
	 * 负责人职务
	 */
	@FieldDescription("负责人职务")
	private String position;
	/**
	 * 负责人手机
	 */
	@FieldDescription("负责人手机")
	private String mobile;
	/**
	 * 负责人电话
	 */
	@FieldDescription("负责人电话")
	private String phone;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private String contact;
	/**
	 * 联系人职务
	 */
	@FieldDescription("联系人职务")
	private String cposition;
	/**
	 * 联系人手机
	 */
	@FieldDescription("联系人手机")
	private String contractMobile;
	/**
	 * 联系人电话
	 */
	@FieldDescription("联系人电话")
	private String contractPhone;
	/**
	 * 邮编
	 */
	@FieldDescription("邮编")
	private String zipcode;
	/**
	 * Email地址
	 */
	@FieldDescription("Email地址")
	private String email;
	/**
	 * 网址
	 */
	@FieldDescription("网址")
	private String homePage;
	/**
	 * 通讯地址
	 */
	@FieldDescription("通讯地址")
	private String address;
	/**
	 * Logo
	 */
	@FieldDescription("Logo")
	private String logo;
	/**
	 * 简介
	 */
	@FieldDescription("简介")
	private String memo;
	/**
	 * 机构类型
	 */
	private AgencyEnum agencyType;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 编号
	 */
	public Long getOrderId(){
		return orderId;
	}
	public void setOrderId(Long orderId){
		this.orderId = orderId;
	}
	/**
	 * 名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 是否发布到网
	 */
	public BooleanEnum getPub() {
		return pub;
	}
	public void setPub(BooleanEnum pub) {
		this.pub = pub;
	}
	/**
	 * 负责人
	 */
	public String getCharger(){
		return charger;
	}
	public void setCharger(String charger){
		this.charger = charger;
	}
	/**
	 * 负责人职务
	 */
	public String getPosition(){
		return position;
	}
	public void setPosition(String position){
		this.position = position;
	}
	/**
	 * 负责人手机
	 */
	public String getMobile(){
		return mobile;
	}
	public void setMobile(String mobile){
		this.mobile = mobile;
	}
	/**
	 * 负责人电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 联系人
	 */
	public String getContact(){
		return contact;
	}
	public void setContact(String contact){
		this.contact = contact;
	}
	/**
	 * 联系人职务
	 */
	public String getCposition(){
		return cposition;
	}
	public void setCposition(String cposition){
		this.cposition = cposition;
	}
	/**
	 * 联系人手机
	 */
	public String getContractMobile(){
		return contractMobile;
	}
	public void setContractMobile(String contractMobile){
		this.contractMobile = contractMobile;
	}
	/**
	 * 联系人电话
	 */
	public String getContractPhone(){
		return contractPhone;
	}
	public void setContractPhone(String contractPhone){
		this.contractPhone = contractPhone;
	}
	/**
	 * 邮编
	 */
	public String getZipcode(){
		return zipcode;
	}
	public void setZipcode(String zipcode){
		this.zipcode = zipcode;
	}
	/**
	 * Email地址
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 网址
	 */
	public String getHomePage(){
		return homePage;
	}
	public void setHomePage(String homePage){
		this.homePage = homePage;
	}
	/**
	 * 通讯地址
	 */
	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
	/**
	 * Logo
	 */
	public String getLogo(){
		return logo;
	}
	public void setLogo(String logo){
		this.logo = logo;
	}
	/**
	 * 简介
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
	public AgencyEnum getAgencyType() {
		return agencyType;
	}
	public void setAgencyType(AgencyEnum agencyType) {
		this.agencyType = agencyType;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
}