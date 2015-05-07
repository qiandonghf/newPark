package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 企业标签关系
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerLabelRef extends BaseEntity implements Serializable {
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
	 * 企业标签
	 */
	@FieldDescription("企业标签")
	private CustomerLabel customerLabel;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 标签外键
	 */
	@FieldDescription("标签外键")
	private Long labelId;

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
	 * 企业标签
	 */
	public CustomerLabel getCustomerLabel(){
		return customerLabel;
	}
	public void setCustomerLabel(CustomerLabel customerLabel){
		this.customerLabel = customerLabel;
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
	 * 标签外键
	 */
	public Long getLabelId(){
		return labelId;
	}
	public void setLabelId(Long labelId){
		this.labelId = labelId;
	}
}