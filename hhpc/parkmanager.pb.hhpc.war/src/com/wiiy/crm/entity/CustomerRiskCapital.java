package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.crm.entity.Customer;

/**
 * <br/>class-description 风险投资
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class CustomerRiskCapital extends BaseEntity implements Serializable {
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
	 * 币种实体
	 */
	@FieldDescription("币种实体")
	private DataDict currencyType;
	/**
	 * 企业外键
	 */
	@FieldDescription("企业外键")
	private Long customerId;
	/**
	 * 机构名称
	 */
	@FieldDescription("机构名称")
	private String orgName;
	/**
	 * 金额
	 */
	@FieldDescription("金额")
	private Double money;
	/**
	 * 币种外键
	 */
	@FieldDescription("币种外键")
	private String currencyTypeId;
	/**
	 * 时间
	 */
	@FieldDescription("时间")
	private Date time;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
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
	 * 币种实体
	 */
	public DataDict getCurrencyType(){
		return currencyType;
	}
	public void setCurrencyType(DataDict currencyType){
		this.currencyType = currencyType;
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
	 * 机构名称
	 */
	public String getOrgName(){
		return orgName;
	}
	public void setOrgName(String orgName){
		this.orgName = orgName;
	}
	/**
	 * 金额
	 */
	public Double getMoney(){
		return money;
	}
	public void setMoney(Double money){
		this.money = money;
	}
	/**
	 * 币种外键
	 */
	public String getCurrencyTypeId(){
		return currencyTypeId;
	}
	public void setCurrencyTypeId(String currencyTypeId){
		this.currencyTypeId = currencyTypeId;
	}
	/**
	 * 时间
	 */
	public Date getTime(){
		return time;
	}
	public void setTime(Date time){
		this.time = time;
	}
	/**
	 * 备注
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}