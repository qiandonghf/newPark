package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.SealApply;
import com.wiiy.oa.preferences.enums.SealApprovalStatusEnum;
import com.wiiy.oa.preferences.enums.SealTypeEnum;

/**
 * <br/>class-description 用印审批
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SealApproval extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 用印申请
	 */
	@FieldDescription("用印申请")
	private SealApply apply;
	/**
	 * 用印申请外键
	 */
	@FieldDescription("用印申请外键")
	private Long applyId;
	/**
	 * 用印类型
	 */
	@FieldDescription("用印类型")
	private SealTypeEnum sealType;
	/**
	 * 审批状态
	 */
	@FieldDescription("审批状态")
	private SealApprovalStatusEnum status;
	/**
	 * 审批意见
	 */
	@FieldDescription("审批意见")
	private String memo;
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
	 * 用印申请
	 */
	public SealApply getApply(){
		return apply;
	}
	public void setApply(SealApply apply){
		this.apply = apply;
	}
	/**
	 * 用印申请外键
	 */
	public Long getApplyId(){
		return applyId;
	}
	public void setApplyId(Long applyId){
		this.applyId = applyId;
	}
	/**
	 * 用印类型
	 */
	public SealTypeEnum getSealType(){
		return sealType;
	}
	public void setSealType(SealTypeEnum sealType){
		this.sealType = sealType;
	}
	/**
	 * 审批状态
	 */
	public SealApprovalStatusEnum getStatus(){
		return status;
	}
	public void setStatus(SealApprovalStatusEnum status){
		this.status = status;
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