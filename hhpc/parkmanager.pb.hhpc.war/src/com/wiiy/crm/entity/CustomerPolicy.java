package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;

/**
 * <br/>class-description 企业招商政策
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerPolicy extends BaseEntity implements Serializable {
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
	 * 政策
	 */
	@FieldDescription("政策")
	private Policy policy;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 政策外键
	 */
	@FieldDescription("政策外键")
	private Long policyId;
	/**
	 * 过期
	 */
	@FieldDescription("过期")
	private BooleanEnum overdue;

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
	 * 政策
	 */
	public Policy getPolicy(){
		return policy;
	}
	public void setPolicy(Policy policy){
		this.policy = policy;
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
	 * 政策外键
	 */
	public Long getPolicyId(){
		return policyId;
	}
	public void setPolicyId(Long policyId){
		this.policyId = policyId;
	}
	/**
	 * 过期
	 */
	public BooleanEnum getOverdue(){
		return overdue;
	}
	public void setOverdue(BooleanEnum overdue){
		this.overdue = overdue;
	}
}