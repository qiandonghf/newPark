package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Customer;

/**
 * <br/>class-description 奖励管理
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Reward extends BaseEntity implements Serializable {
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
	 * 奖励类型
	 */
	@FieldDescription("奖励类型")
	private DataDict type;
	/**
	 * 企业ID
	 */
	@FieldDescription("企业ID")
	private Long customerId;
	/**
	 * 奖励类型外键
	 */
	@FieldDescription("奖励类型外键")
	private String typeId;
	/**
	 * 奖金
	 */
	@FieldDescription("奖金")
	private Double bonus;
	/**
	 * 奖励日期
	 */
	@FieldDescription("奖励日期")
	private Date rewardDate;
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
	 * 奖励类型
	 */
	public DataDict getType(){
		return type;
	}
	public void setType(DataDict type){
		this.type = type;
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
	 * 奖励类型外键
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 奖金
	 */
	public Double getBonus(){
		return bonus;
	}
	public void setBonus(Double bonus){
		this.bonus = bonus;
	}
	/**
	 * 奖励日期
	 */
	public Date getRewardDate(){
		return rewardDate;
	}
	public void setRewardDate(Date rewardDate){
		this.rewardDate = rewardDate;
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