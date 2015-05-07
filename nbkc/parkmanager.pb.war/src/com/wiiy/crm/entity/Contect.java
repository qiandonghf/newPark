package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.commons.preferences.enums.GenderEnum;

/**
 * <br/>class-description 联系人
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Contect extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 企业
	 */
	@FieldDescription("企业")
	private Customer customer;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 姓名
	 */
	@FieldDescription("姓名")
	private String name;
	/**
	 * 性别
	 */
	@FieldDescription("性别")
	private GenderEnum gender;
	/**
	 * 手机号码
	 */
	@FieldDescription("手机号码")
	private String mobile;
	/**
	 * 是否首要联系人
	 */
	@FieldDescription("是否首要联系人")
	private BooleanEnum main;
	/**
	 * 职位
	 */
	@FieldDescription("职位")
	private String position;
	/**
	 * Email
	 */
	@FieldDescription("Email")
	private String email;
	/**
	 * 电话
	 */
	@FieldDescription("电话")
	private String phone;
	/**
	 * MSN
	 */
	@FieldDescription("MSN")
	private String msn;
	/**
	 * QQ
	 */
	@FieldDescription("QQ")
	private String qq;
	/**
	 * 传真
	 */
	@FieldDescription("传真")
	private String fax;
	/**
	 * 邮编
	 */
	@FieldDescription("邮编")
	private String zipcode;
	/**
	 * 家庭地址
	 */
	@FieldDescription("家庭地址")
	private String homeAddr;
	/**
	 * 家庭电话
	 */
	@FieldDescription("家庭电话")
	private String homePhone;
	/**
	 * 爱好
	 */
	@FieldDescription("爱好")
	private String favorite;
	/**
	 * 生日
	 */
	@FieldDescription("生日")
	private Date birthDay;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 企业
	 */
	public Customer getCustomer(){
		return customer;
	}
	public void setCustomer(Customer customer){
		this.customer = customer;
	}
	/**
	 * 企业外键
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 姓名
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 性别
	 */
	public GenderEnum getGender(){
		return gender;
	}
	public void setGender(GenderEnum gender){
		this.gender = gender;
	}
	/**
	 * 手机号码
	 */
	public String getMobile(){
		return mobile;
	}
	public void setMobile(String mobile){
		this.mobile = mobile;
	}
	/**
	 * 是否首要联系人
	 */
	public BooleanEnum getMain(){
		return main;
	}
	public void setMain(BooleanEnum main){
		this.main = main;
	}
	/**
	 * 职位
	 */
	public String getPosition(){
		return position;
	}
	public void setPosition(String position){
		this.position = position;
	}
	/**
	 * Email
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * MSN
	 */
	public String getMsn(){
		return msn;
	}
	public void setMsn(String msn){
		this.msn = msn;
	}
	/**
	 * QQ
	 */
	public String getQq(){
		return qq;
	}
	public void setQq(String qq){
		this.qq = qq;
	}
	/**
	 * 传真
	 */
	public String getFax(){
		return fax;
	}
	public void setFax(String fax){
		this.fax = fax;
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
	 * 家庭地址
	 */
	public String getHomeAddr(){
		return homeAddr;
	}
	public void setHomeAddr(String homeAddr){
		this.homeAddr = homeAddr;
	}
	/**
	 * 家庭电话
	 */
	public String getHomePhone(){
		return homePhone;
	}
	public void setHomePhone(String homePhone){
		this.homePhone = homePhone;
	}
	/**
	 * 爱好
	 */
	public String getFavorite(){
		return favorite;
	}
	public void setFavorite(String favorite){
		this.favorite = favorite;
	}
	/**
	 * 生日
	 */
	public Date getBirthDay(){
		return birthDay;
	}
	public void setBirthDay(Date birthDay){
		this.birthDay = birthDay;
	}
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}