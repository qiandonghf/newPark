package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.Approval;
import com.wiiy.crm.entity.Contract;
import com.wiiy.crm.entity.ContractReviewAtt;
import com.wiiy.core.preferences.enums.CountersignOpenEnum;

/**
 * <br/>class-description 合同会签审核单
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class ContractReview extends BaseEntity implements Serializable {
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
	 * 审批
	 */
	@FieldDescription("审批")
	private Approval sp;
	/**
	 * 审核
	 */
	@FieldDescription("审核")
	private Approval sh;
	/**
	 * 会签
	 */
	@FieldDescription("会签")
	private Approval hq;
	/**
	 * 经办
	 */
	@FieldDescription("经办")
	private Approval jb;
	/**
	 * 合同外键
	 */
	@FieldDescription("合同外键")
	private Long contractId;
	/**
	 * 合同编号
	 */
	@FieldDescription("合同编号")
	private String contractNo;
	/**
	 * 日期
	 */
	@FieldDescription("日期")
	private Date date;
	/**
	 * 部门
	 */
	@FieldDescription("部门")
	private String department;
	/**
	 * 审批ID
	 */
	@FieldDescription("审批ID")
	private Long spId;
	/**
	 * 审核ID
	 */
	@FieldDescription("审核ID")
	private Long shId;
	/**
	 * 会签ID
	 */
	@FieldDescription("会签ID")
	private Long hqId;
	/**
	 * 经办ID
	 */
	@FieldDescription("经办ID")
	private Long jbId;
	/**
	 * 会签状态
	 */
	@FieldDescription("会签状态")
	private CountersignOpenEnum countersignStatus;
	private Set<ContractReviewAtt> atts;

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
	 * 审批
	 */
	public Approval getSp(){
		return sp;
	}
	public void setSp(Approval sp){
		this.sp = sp;
	}
	/**
	 * 审核
	 */
	public Approval getSh(){
		return sh;
	}
	public void setSh(Approval sh){
		this.sh = sh;
	}
	/**
	 * 会签
	 */
	public Approval getHq(){
		return hq;
	}
	public void setHq(Approval hq){
		this.hq = hq;
	}
	/**
	 * 经办
	 */
	public Approval getJb(){
		return jb;
	}
	public void setJb(Approval jb){
		this.jb = jb;
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
	 * 合同编号
	 */
	public String getContractNo(){
		return contractNo;
	}
	public void setContractNo(String contractNo){
		this.contractNo = contractNo;
	}
	/**
	 * 日期
	 */
	public Date getDate(){
		return date;
	}
	public void setDate(Date date){
		this.date = date;
	}
	/**
	 * 部门
	 */
	public String getDepartment(){
		return department;
	}
	public void setDepartment(String department){
		this.department = department;
	}
	/**
	 * 审批ID
	 */
	public Long getSpId(){
		return spId;
	}
	public void setSpId(Long spId){
		this.spId = spId;
	}
	/**
	 * 审核ID
	 */
	public Long getShId(){
		return shId;
	}
	public void setShId(Long shId){
		this.shId = shId;
	}
	/**
	 * 会签ID
	 */
	public Long getHqId(){
		return hqId;
	}
	public void setHqId(Long hqId){
		this.hqId = hqId;
	}
	/**
	 * 经办ID
	 */
	public Long getJbId(){
		return jbId;
	}
	public void setJbId(Long jbId){
		this.jbId = jbId;
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
	public Set<ContractReviewAtt> getAtts(){
		return atts;
	}
	public void setAtts(Set<ContractReviewAtt> atts){
		this.atts = atts;
	}
}