package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.ContractAgreementAtt;

/**
 * <br/>class-description 合同协议
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContractAgreement extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 合同名称
	 */
	@FieldDescription("合同名称")
	private String contractName;
	/**
	 * 客户名称
	 */
	@FieldDescription("客户名称")
	private String customerName;
	/**
	 * 合同开始时间
	 */
	@FieldDescription("合同开始时间")
	private Date startDate;
	/**
	 * 合同结束时间
	 */
	@FieldDescription("合同结束时间")
	private Date endDate;
	/**
	 * 签约时间
	 */
	@FieldDescription("签约时间")
	private Date signingDate;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String comment;
	private Set<ContractAgreementAtt> atts;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 合同名称
	 */
	public String getContractName(){
		return contractName;
	}
	public void setContractName(String contractName){
		this.contractName = contractName;
	}
	/**
	 * 客户名称
	 */
	public String getCustomerName(){
		return customerName;
	}
	public void setCustomerName(String customerName){
		this.customerName = customerName;
	}
	/**
	 * 合同开始时间
	 */
	public Date getStartDate(){
		return startDate;
	}
	public void setStartDate(Date startDate){
		this.startDate = startDate;
	}
	/**
	 * 合同结束时间
	 */
	public Date getEndDate(){
		return endDate;
	}
	public void setEndDate(Date endDate){
		this.endDate = endDate;
	}
	/**
	 * 签约时间
	 */
	public Date getSigningDate(){
		return signingDate;
	}
	public void setSigningDate(Date signingDate){
		this.signingDate = signingDate;
	}
	/**
	 * 备注
	 */
	public String getComment(){
		return comment;
	}
	public void setComment(String comment){
		this.comment = comment;
	}
	public Set<ContractAgreementAtt> getAtts(){
		return atts;
	}
	public void setAtts(Set<ContractAgreementAtt> atts){
		this.atts = atts;
	}
}