package com.wiiy.core.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;

/**
 * <br/>class-description 集团公司
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Corporation extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 账号实体
	 */
	@FieldDescription("账号实体")
	private User user;
	/**
	 * 名称
	 */
	@FieldDescription("名称")
	private String name;
	/**
	 * 编码
	 */
	@FieldDescription("编码")
	private String code;
	/**
	 * 简称
	 */
	@FieldDescription("简称")
	private String shortName;
	/**
	 * 账号外键ID
	 */
	@FieldDescription("账号外键ID")
	private Long userId;
	/**
	 * 联系地址
	 */
	@FieldDescription("联系地址")
	private String address;
	/**
	 * 邮编
	 */
	@FieldDescription("邮编")
	private String zipCode;
	/**
	 * 网址
	 */
	@FieldDescription("网址")
	private String webSite;
	/**
	 * 办公电话
	 */
	@FieldDescription("办公电话")
	private String officePhone;
	/**
	 * 传真
	 */
	@FieldDescription("传真")
	private String fax;
	/**
	 * Email地址
	 */
	@FieldDescription("Email地址")
	private String email;
	/**
	 * 法定代表人
	 */
	@FieldDescription("法定代表人")
	private String legalPerson;
	/**
	 * 股东
	 */
	@FieldDescription("股东")
	private String shareholder;
	/**
	 * 公司描述
	 */
	@FieldDescription("公司描述")
	private String description;
	/**
	 * 开户行
	 */
	@FieldDescription("开户行")
	private String bankName;
	/**
	 * 开户人
	 */
	@FieldDescription("开户人")
	private String owner;
	/**
	 * 账号
	 */
	@FieldDescription("账号")
	private String bankAccount;
	/**
	 * 扩展1
	 */
	@FieldDescription("扩展1")
	private String ext1;
	/**
	 * 扩展2
	 */
	@FieldDescription("扩展2")
	private String ext2;
	/**
	 * 扩展3
	 */
	@FieldDescription("扩展3")
	private String ext3;
	/**
	 * 扩展4
	 */
	@FieldDescription("扩展4")
	private String ext4;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 账号实体
	 */
	public User getUser(){
		return user;
	}
	public void setUser(User user){
		this.user = user;
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
	 * 编码
	 */
	public String getCode(){
		return code;
	}
	public void setCode(String code){
		this.code = code;
	}
	/**
	 * 简称
	 */
	public String getShortName(){
		return shortName;
	}
	public void setShortName(String shortName){
		this.shortName = shortName;
	}
	/**
	 * 账号外键ID
	 */
	public Long getUserId(){
		return userId;
	}
	public void setUserId(Long userId){
		this.userId = userId;
	}
	/**
	 * 联系地址
	 */
	public String getAddress(){
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
	/**
	 * 邮编
	 */
	public String getZipCode(){
		return zipCode;
	}
	public void setZipCode(String zipCode){
		this.zipCode = zipCode;
	}
	/**
	 * 网址
	 */
	public String getWebSite(){
		return webSite;
	}
	public void setWebSite(String webSite){
		this.webSite = webSite;
	}
	/**
	 * 办公电话
	 */
	public String getOfficePhone(){
		return officePhone;
	}
	public void setOfficePhone(String officePhone){
		this.officePhone = officePhone;
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
	 * Email地址
	 */
	public String getEmail(){
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	/**
	 * 法定代表人
	 */
	public String getLegalPerson(){
		return legalPerson;
	}
	public void setLegalPerson(String legalPerson){
		this.legalPerson = legalPerson;
	}
	/**
	 * 股东
	 */
	public String getShareholder(){
		return shareholder;
	}
	public void setShareholder(String shareholder){
		this.shareholder = shareholder;
	}
	/**
	 * 公司描述
	 */
	public String getDescription(){
		return description;
	}
	public void setDescription(String description){
		this.description = description;
	}
	/**
	 * 开户行
	 */
	public String getBankName(){
		return bankName;
	}
	public void setBankName(String bankName){
		this.bankName = bankName;
	}
	/**
	 * 开户人
	 */
	public String getOwner(){
		return owner;
	}
	public void setOwner(String owner){
		this.owner = owner;
	}
	/**
	 * 账号
	 */
	public String getBankAccount(){
		return bankAccount;
	}
	public void setBankAccount(String bankAccount){
		this.bankAccount = bankAccount;
	}
	/**
	 * 扩展1
	 */
	public String getExt1(){
		return ext1;
	}
	public void setExt1(String ext1){
		this.ext1 = ext1;
	}
	/**
	 * 扩展2
	 */
	public String getExt2(){
		return ext2;
	}
	public void setExt2(String ext2){
		this.ext2 = ext2;
	}
	/**
	 * 扩展3
	 */
	public String getExt3(){
		return ext3;
	}
	public void setExt3(String ext3){
		this.ext3 = ext3;
	}
	/**
	 * 扩展4
	 */
	public String getExt4(){
		return ext4;
	}
	public void setExt4(String ext4){
		this.ext4 = ext4;
	}
}