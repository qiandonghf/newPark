package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.Supply;
import com.wiiy.oa.preferences.enums.CarApplyStatusEnum;

/**
 * <br/>class-description 办公用品申请
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SupplyApply extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 办公用品实体
	 */
	@FieldDescription("办公用品实体")
	private Supply supply;
	/**
	 * 办公用品外键
	 */
	@FieldDescription("办公用品外键")
	private Long supplyId;
	/**
	 * 申请数量
	 */
	@FieldDescription("申请数量")
	private Double amount;
	/**
	 * 申请时间
	 */
	@FieldDescription("申请时间")
	private Date applyTime;
	/**
	 * 申请人
	 */
	@FieldDescription("申请人")
	private String applyer;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 审批状态
	 */
	@FieldDescription("审批状态")
	private CarApplyStatusEnum status;
	/**
	 * 审批人姓名
	 */
	@FieldDescription("审批人姓名")
	private String approver;
	/**
	 * 审批人ID
	 */
	@FieldDescription("审批人ID")
	private Long approverId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 办公用品实体
	 */
	public Supply getSupply(){
		return supply;
	}
	public void setSupply(Supply supply){
		this.supply = supply;
	}
	/**
	 * 办公用品外键
	 */
	public Long getSupplyId(){
		return supplyId;
	}
	public void setSupplyId(Long supplyId){
		this.supplyId = supplyId;
	}
	/**
	 * 申请数量
	 */
	public Double getAmount(){
		return amount;
	}
	public void setAmount(Double amount){
		this.amount = amount;
	}
	/**
	 * 申请时间
	 */
	public Date getApplyTime(){
		return applyTime;
	}
	public void setApplyTime(Date applyTime){
		this.applyTime = applyTime;
	}
	/**
	 * 申请人
	 */
	public String getApplyer(){
		return applyer;
	}
	public void setApplyer(String applyer){
		this.applyer = applyer;
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
	/**
	 * 审批状态
	 */
	public CarApplyStatusEnum getStatus(){
		return status;
	}
	public void setStatus(CarApplyStatusEnum status){
		this.status = status;
	}
	/**
	 * 审批人姓名
	 */
	public String getApprover(){
		return approver;
	}
	public void setApprover(String approver){
		this.approver = approver;
	}
	/**
	 * 审批人ID
	 */
	public Long getApproverId(){
		return approverId;
	}
	public void setApproverId(Long approverId){
		this.approverId = approverId;
	}
}