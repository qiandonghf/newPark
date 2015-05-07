package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 知识产权(认证)
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Certification extends BaseEntity implements Serializable {
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
	 * 认证类型
	 */
	@FieldDescription("认证类型")
	private DataDict type;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 认证类型外键
	 */
	@FieldDescription("认证类型外键")
	private String typeId;
	/**
	 * 认证名称
	 */
	@FieldDescription("认证名称")
	private String name;
	/**
	 * 认证编号
	 */
	@FieldDescription("认证编号")
	private String serialNo;
	/**
	 * 认证时间
	 */
	@FieldDescription("认证时间")
	private Date certTime;
	/**
	 * 认证机构
	 */
	@FieldDescription("认证机构")
	private String agency;
	/**
	 * 摘要
	 */
	@FieldDescription("摘要")
	private String summery;
	/**
	 * 是否发布到网站
	 */
	@FieldDescription("是否发布到网站")
	private BooleanEnum pub;

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
	 * 认证类型
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
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
	 * 认证类型外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 认证名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 认证编号
	 */
	public String getSerialNo(){
		return serialNo;
	}
	public void setSerialNo(String serialNo){
		this.serialNo = serialNo;
	}
	/**
	 * 认证时间
	 */
	public Date getCertTime(){
		return certTime;
	}
	public void setCertTime(Date certTime){
		this.certTime = certTime;
	}
	/**
	 * 认证机构
	 */
	public String getAgency(){
		return agency;
	}
	public void setAgency(String agency){
		this.agency = agency;
	}
	/**
	 * 摘要
	 */
	public String getSummery(){
		return summery;
	}
	public void setSummery(String summery){
		this.summery = summery;
	}
	/**
	 * 是否发布到网站
	 */
	public BooleanEnum getPub(){
		return pub;
	}
	public void setPub(BooleanEnum pub){
		this.pub = pub;
	}
}