package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 知识产权(著作权)
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Copyright extends BaseEntity implements Serializable {
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
	 * 著作权类型
	 */
	@FieldDescription("著作权类型")
	private DataDict type;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 著作权类型外键
	 */
	@FieldDescription("著作权类型外键")
	private String typeId;
	/**
	 * 著作权名称
	 */
	@FieldDescription("著作权名称")
	private String name;
	/**
	 * 著作权号
	 */
	@FieldDescription("著作权号")
	private String serialNo;
	/**
	 * 申请人
	 */
	@FieldDescription("申请人")
	private String appler;
	/**
	 * 申请时间
	 */
	@FieldDescription("申请时间")
	private Date applyTime;
	/**
	 * 生效时间
	 */
	@FieldDescription("生效时间")
	private Date effectivetime;
	/**
	 * 失效时间
	 */
	@FieldDescription("失效时间")
	private Date expireTime;
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
	 * 著作权类型
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
	 * 著作权类型外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 著作权名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 著作权号
	 */
	public String getSerialNo(){
		return serialNo;
	}
	public void setSerialNo(String serialNo){
		this.serialNo = serialNo;
	}
	/**
	 * 申请人
	 */
	public String getAppler(){
		return appler;
	}
	public void setAppler(String appler){
		this.appler = appler;
	}
	/**
	 * 申请时间
	 */
	public Date getApplyTime(){
		return applyTime;
	}
	public void setApplyTime(Date applyTime){
		this.applyTime = applyTime;
	}
	/**
	 * 生效时间
	 */
	public Date getEffectivetime(){
		return effectivetime;
	}
	public void setEffectivetime(Date effectivetime){
		this.effectivetime = effectivetime;
	}
	/**
	 * 失效时间
	 */
	public Date getExpireTime(){
		return expireTime;
	}
	public void setExpireTime(Date expireTime){
		this.expireTime = expireTime;
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