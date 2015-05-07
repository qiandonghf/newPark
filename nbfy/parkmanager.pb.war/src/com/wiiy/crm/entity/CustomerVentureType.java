package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Customer;

/**
 * <br/>class-description 企业创业类型
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerVentureType extends BaseEntity implements Serializable {
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
	 * 创业类型
	 */
	@FieldDescription("创业类型")
	private DataDict ventureType;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 创业类型外键
	 */
	@FieldDescription("创业类型外键")
	private String ventureTypeId;

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
	 * 创业类型
	 */
	public DataDict getVentureType(){
		return ventureType;
	}
	public void setVentureType(DataDict ventureType){
		this.ventureType = ventureType;
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
	 * 创业类型外键
	 */
	public String getVentureTypeId(){
		return ventureTypeId;
	}
	public void setVentureTypeId(String ventureTypeId){
		this.ventureTypeId = ventureTypeId;
	}
}