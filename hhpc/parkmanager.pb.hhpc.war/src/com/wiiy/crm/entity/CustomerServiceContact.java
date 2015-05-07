package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.core.entity.ContactEntity;
import com.wiiy.core.entity.DataDict;
import com.wiiy.core.entity.Org;
import com.wiiy.crm.entity.Customer;
import com.wiiy.crm.preferences.enums.CustomerServiceResultEnum;

/**
 * <br/>class-description 客服联系单
 * <br/>extends com.wiiy.core.entity.ContactEntity
 */
public class CustomerServiceContact extends ContactEntity implements Serializable {
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
	 * 受理部门
	 */
	@FieldDescription("受理部门")
	private Org org;
	/**
	 * 服务类型
	 */
	@FieldDescription("服务类型")
	private DataDict serviceType;
	/**
	 * 企业ID
	 */
	@FieldDescription("企业ID")
	private Long customerId;
	/**
	 * 受理部门ID
	 */
	@FieldDescription("受理部门ID")
	private Long orgId;
	/**
	 * 服务类型ID
	 */
	@FieldDescription("服务类型ID")
	private String typeId;
	/**
	 * 服务结果
	 */
	@FieldDescription("服务结果")
	private CustomerServiceResultEnum result;
	/**
	 * 客服意见及建议
	 */
	@FieldDescription("客服意见及建议")
	private String suggest;
	/**
	 * 处理人备注
	 */
	@FieldDescription("处理人备注")
	private String opinion1;
	/**
	 * 处理人ID
	 */
	@FieldDescription("处理人ID")
	private Long opinion1Id;

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
	 * 受理部门
	 */
	public Org getOrg(){
		return org;
	}
	public void setOrg(Org org){
		this.org = org;
	}
	/**
	 * 服务类型
	 */
	public DataDict getServiceType(){
		return serviceType;
	}
	public void setServiceType(DataDict serviceType){
		this.serviceType = serviceType;
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
	 * 受理部门ID
	 */
	public Long getOrgId(){
		return orgId;
	}
	public void setOrgId(Long orgId){
		this.orgId = orgId;
	}
	/**
	 * 服务类型ID
	 */
	public String getTypeId(){
		return typeId;
	}
	public void setTypeId(String typeId){
		this.typeId = typeId;
	}
	/**
	 * 服务结果
	 */
	public CustomerServiceResultEnum getResult(){
		return result;
	}
	public void setResult(CustomerServiceResultEnum result){
		this.result = result;
	}
	/**
	 * 客服意见及建议
	 */
	public String getSuggest(){
		return suggest;
	}
	public void setSuggest(String suggest){
		this.suggest = suggest;
	}
	/**
	 * 处理人备注
	 */
	public String getOpinion1(){
		return opinion1;
	}
	public void setOpinion1(String opinion1){
		this.opinion1 = opinion1;
	}
	/**
	 * 处理人ID
	 */
	public Long getOpinion1Id(){
		return opinion1Id;
	}
	public void setOpinion1Id(Long opinion1Id){
		this.opinion1Id = opinion1Id;
	}
}