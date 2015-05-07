package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.LeaveRegister;
import com.wiiy.oa.preferences.enums.LeaveApprovalStatusEnum;

/**
 * <br/>class-description 请假审批
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class LeaveApproval extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 请假申请
	 */
	@FieldDescription("请假申请")
	private LeaveRegister apply;
	/**
	 * 请假申请外键
	 */
	@FieldDescription("请假申请外键")
	private Long applyId;
	/**
	 * 审批状态
	 */
	@FieldDescription("审批状态")
	private LeaveApprovalStatusEnum status;
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
	 * 请假申请
	 */
	public LeaveRegister getApply(){
		return apply;
	}
	public void setApply(LeaveRegister apply){
		this.apply = apply;
	}
	/**
	 * 请假申请外键
	 */
	public Long getApplyId(){
		return applyId;
	}
	public void setApplyId(Long applyId){
		this.applyId = applyId;
	}
	/**
	 * 审批状态
	 */
	public LeaveApprovalStatusEnum getStatus(){
		return status;
	}
	public void setStatus(LeaveApprovalStatusEnum status){
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