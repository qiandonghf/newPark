package com.wiiy.cms.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 联系方式
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContactInfo extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 网站外键Id
	 */
	@FieldDescription("网站外键Id")
	private Long paramId;
	/**
	 * 公司名称
	 */
	@FieldDescription("公司名称")
	private String name;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private String contact;
	/**
	 * 电话
	 */
	@FieldDescription("电话")
	private String phone;
	/**
	 * 手机
	 */
	@FieldDescription("手机")
	private String telephone;
	/**
	 * 传真
	 */
	@FieldDescription("传真")
	private String fax;
	/**
	 * E-mail
	 */
	@FieldDescription("E-mail")
	private String email;
	/**
	 * 邮政编码
	 */
	@FieldDescription("邮政编码")
	private String postCode;
	/**
	 * 地址
	 */
	@FieldDescription("地址")
	private String address;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 网站外键Id
	 */
	public Long getParamId(){
		return paramId;
	}
	public void setParamId(Long paramId){
		this.paramId = paramId;
	}
	/**
	 * 公司名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
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
	 * 电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 手机
	 */
	public String getTelephone(){
		return telephone;
	}
	public void setTelephone(String telephone){
		this.telephone = telephone;
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
	 * E-mail
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 邮政编码
	 */
	public String getPostCode(){
		return postCode;
	}
	public void setPostCode(String postCode){
		this.postCode = postCode;
	}
	/**
	 * 地址
	 */
	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
}