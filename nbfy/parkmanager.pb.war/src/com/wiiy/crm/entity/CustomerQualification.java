package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Customer;

/**
 * <br/>class-description 企业资质
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerQualification extends BaseEntity implements Serializable {
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
	 * 企业资质
	 */
	@FieldDescription("企业资质")
	private DataDict qualification;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 企业资质外键
	 */
	@FieldDescription("企业资质外键")
	private String qualificationId;
	/**
	 * 对应时间
	 */
	@FieldDescription("对应时间")
	private Date time;

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
	 * 企业资质
	 */
	public DataDict getQualification(){
		return qualification;
	}
	public void setQualification(DataDict qualification){
		this.qualification = qualification;
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
	 * 企业资质外键
	 */
	public String getQualificationId(){
		return qualificationId;
	}
	public void setQualificationId(String qualificationId){
		this.qualificationId = qualificationId;
	}
	/**
	 * 对应时间
	 */
	public Date getTime(){
		return time;
	}
	public void setTime(Date time){
		this.time = time;
	}
}