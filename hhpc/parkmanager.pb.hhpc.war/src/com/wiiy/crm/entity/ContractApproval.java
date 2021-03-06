package com.wiiy.crm.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.preferences.enums.ContractApprovalStateEnum;

/**
 * <br/>class-description 合同审批
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContractApproval extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 合同
	 */
	@FieldDescription("合同")
	private Contract contract;
	/**
	 * 合同外键
	 */
	@FieldDescription("合同外键")
	private Long contractId;
	/**
	 * 审批结果
	 */
	@FieldDescription("审批结果")
	private ContractApprovalStateEnum state;
	/**
	 * 审批意见
	 */
	@FieldDescription("审批意见")
	private String memo;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 合同
	 */
	public Contract getContract(){
		return contract;
	}
	public void setContract(Contract contract){
		this.contract = contract;
	}
	/**
	 * 合同外键
	 */
	public Long getContractId(){
		return contractId;
	}
	public void setContractId(Long contractId){
		this.contractId = contractId;
	}
	/**
	 * 审批结果
	 */
	public ContractApprovalStateEnum getState(){
		return state;
	}
	public void setState(ContractApprovalStateEnum state){
		this.state = state;
	}
	/**
	 * 审批意见
	 */
	public String getMemo(){
		return memo;
	}
	public void setMemo(String memo){
		this.memo = memo;
	}
}