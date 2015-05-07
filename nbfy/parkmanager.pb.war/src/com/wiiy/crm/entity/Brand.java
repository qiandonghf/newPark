package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.Customer;

/**
 * <br/>class-description 商标
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Brand extends BaseEntity implements Serializable {
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
	 * 企业ID
	 */
	@FieldDescription("企业ID")
	private Long customerId;
	/**
	 * 商标名称
	 */
	@FieldDescription("商标名称")
	private String name;
	/**
	 * 商标编号
	 */
	@FieldDescription("商标编号")
	private String brandNo;
	/**
	 * 注册人
	 */
	@FieldDescription("注册人")
	private String register;
	/**
	 * 注册地址
	 */
	@FieldDescription("注册地址")
	private String registerAddress;
	/**
	 * 注册有效期开始日期
	 */
	@FieldDescription("注册有效期开始日期")
	private Date startDate;
	/**
	 * 注册有效期结束日期
	 */
	@FieldDescription("注册有效期结束日期")
	private Date endDate;
	/**
	 * 授权日期
	 */
	@FieldDescription("授权日期")
	private Date grantDate;
	/**
	 * 详细说明
	 */
	@FieldDescription("详细说明")
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
	 * 企业ID
	 */
	public Long getCustomerId(){
		return customerId;
	}
	public void setCustomerId(Long customerId){
		this.customerId = customerId;
	}
	/**
	 * 商标名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 商标编号
	 */
	public String getBrandNo(){
		return brandNo;
	}
	public void setBrandNo(String brandNo){
		this.brandNo = brandNo;
	}
	/**
	 * 注册人
	 */
	public String getRegister(){
		return register;
	}
	public void setRegister(String register){
		this.register = register;
	}
	/**
	 * 注册地址
	 */
	public String getRegisterAddress(){
		return registerAddress;
	}
	public void setRegisterAddress(String registerAddress){
		this.registerAddress = registerAddress;
	}
	/**
	 * 注册有效期开始日期
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 注册有效期结束日期
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 授权日期
	 */
	public Date getGrantDate(){
		return grantDate;
	}
	public void setGrantDate(Date grantDate){
		this.grantDate = grantDate;
	}
	/**
	 * 详细说明
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}