package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.Approval;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.ContractExpireApprovalAtt;
import com.wiiy.core.preferences.enums.CountersignOpenEnum;

/**
 * <br/>class-description 合同到期审批单
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContractExpireApproval extends BaseEntity implements Serializable {
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
	 * 工程部审核
	 */
	@FieldDescription("工程部审核")
	private Approval gcb;
	/**
	 * 财务总监审核
	 */
	@FieldDescription("财务总监审核")
	private Approval cwzjApproval;
	/**
	 * 总经理审批
	 */
	@FieldDescription("总经理审批")
	private Approval zjlApproval;
	/**
	 * 财务部结算
	 */
	@FieldDescription("财务部结算")
	private Approval cwbApproval;
	/**
	 * 客户确认
	 */
	@FieldDescription("客户确认")
	private Approval kh;
	/**
	 * 合同外键
	 */
	@FieldDescription("合同外键")
	private Long contractId;
	/**
	 * 招商人员意见
	 */
	@FieldDescription("招商人员意见")
	private String businessmanSuggestion;
	/**
	 * 工程部审核ID
	 */
	@FieldDescription("工程部审核ID")
	private Long gcbApprovalId;
	/**
	 * 财务总监审核ID
	 */
	@FieldDescription("财务总监审核ID")
	private Long cwzjApprovalId;
	/**
	 * 总经理审批ID
	 */
	@FieldDescription("总经理审批ID")
	private Long zjlApprovalId;
	/**
	 * 财务部结算ID
	 */
	@FieldDescription("财务部结算ID")
	private Long cwbApprovalId;
	/**
	 * 客户确认ID
	 */
	@FieldDescription("客户确认ID")
	private Long khApprovalId;
	/**
	 * 会签状态
	 */
	@FieldDescription("会签状态")
	private CountersignOpenEnum countersignStatus;
	private Set<ContractExpireApprovalAtt> atts;

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
	 * 工程部审核
	 */
	public Approval getGcb(){
		return gcb;
	}
	public void setGcb(Approval gcb){
		this.gcb = gcb;
	}
	/**
	 * 财务总监审核
	 */
	public Approval getCwzjApproval(){
		return cwzjApproval;
	}
	public void setCwzjApproval(Approval cwzjApproval){
		this.cwzjApproval = cwzjApproval;
	}
	/**
	 * 总经理审批
	 */
	public Approval getZjlApproval(){
		return zjlApproval;
	}
	public void setZjlApproval(Approval zjlApproval){
		this.zjlApproval = zjlApproval;
	}
	/**
	 * 财务部结算
	 */
	public Approval getCwbApproval(){
		return cwbApproval;
	}
	public void setCwbApproval(Approval cwbApproval){
		this.cwbApproval = cwbApproval;
	}
	/**
	 * 客户确认
	 */
	public Approval getKh(){
		return kh;
	}
	public void setKh(Approval kh){
		this.kh = kh;
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
	 * 招商人员意见
	 */
	public String getBusinessmanSuggestion(){
		return businessmanSuggestion;
	}
	public void setBusinessmanSuggestion(String businessmanSuggestion){
		this.businessmanSuggestion = businessmanSuggestion;
	}
	/**
	 * 工程部审核ID
	 */
	public Long getGcbApprovalId(){
		return gcbApprovalId;
	}
	public void setGcbApprovalId(Long gcbApprovalId){
		this.gcbApprovalId = gcbApprovalId;
	}
	/**
	 * 财务总监审核ID
	 */
	public Long getCwzjApprovalId(){
		return cwzjApprovalId;
	}
	public void setCwzjApprovalId(Long cwzjApprovalId){
		this.cwzjApprovalId = cwzjApprovalId;
	}
	/**
	 * 总经理审批ID
	 */
	public Long getZjlApprovalId(){
		return zjlApprovalId;
	}
	public void setZjlApprovalId(Long zjlApprovalId){
		this.zjlApprovalId = zjlApprovalId;
	}
	/**
	 * 财务部结算ID
	 */
	public Long getCwbApprovalId(){
		return cwbApprovalId;
	}
	public void setCwbApprovalId(Long cwbApprovalId){
		this.cwbApprovalId = cwbApprovalId;
	}
	/**
	 * 客户确认ID
	 */
	public Long getKhApprovalId(){
		return khApprovalId;
	}
	public void setKhApprovalId(Long khApprovalId){
		this.khApprovalId = khApprovalId;
	}
	/**
	 * 会签状态
	 */
	public CountersignOpenEnum getCountersignStatus(){
		return countersignStatus;
	}
	public void setCountersignStatus(CountersignOpenEnum countersignStatus){
		this.countersignStatus = countersignStatus;
	}
	public Set<ContractExpireApprovalAtt> getAtts(){
		return atts;
	}
	public void setAtts(Set<ContractExpireApprovalAtt> atts){
		this.atts = atts;
	}
}