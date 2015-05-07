package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 企业变更
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerModifyLog extends BaseEntity implements Serializable {
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
	 * 变更时间
	 */
	@FieldDescription("变更时间")
	private Date modifyLogTime;
	/**
	 * 记录
	 */
	@FieldDescription("记录")
	private String content;

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
	 * 变更时间
	 */
	public Date getModifyLogTime(){
		return modifyLogTime;
	}
	public void setModifyLogTime(Date modifyLogTime){
		this.modifyLogTime = modifyLogTime;
	}
	/**
	 * 记录
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}