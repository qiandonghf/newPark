package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.preferences.enums.LeaveTypeEnum;

/**
 * <br/>class-description 请假登记
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class LeaveRegister extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 申请人
	 */
	@FieldDescription("申请人")
	private String applicant;
	/**
	 * 申请时间
	 */
	@FieldDescription("申请时间")
	private Date applyTime;
	/**
	 * 开始时间
	 */
	@FieldDescription("开始时间")
	private Date startTime;
	/**
	 * 结束时间
	 */
	@FieldDescription("结束时间")
	private Date endTime;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 请假类型
	 */
	@FieldDescription("请假类型")
	private LeaveTypeEnum leaveType;
	/**
	 * 审批结果
	 */
	@FieldDescription("审批结果")
	private String approvals;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 申请人
	 */
	public String getApplicant(){
		return applicant;
	}
	public void setApplicant(String applicant){
		this.applicant = applicant;
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
	 * 开始时间
	 */
	public Date getStartTime(){
		return startTime;
	}
	public void setStartTime(Date startTime){
		this.startTime = startTime;
	}
	/**
	 * 结束时间
	 */
	public Date getEndTime(){
		return endTime;
	}
	public void setEndTime(Date endTime){
		this.endTime = endTime;
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
	 * 请假类型
	 */
	public LeaveTypeEnum getLeaveType(){
		return leaveType;
	}
	public void setLeaveType(LeaveTypeEnum leaveType){
		this.leaveType = leaveType;
	}
	/**
	 * 审批结果
	 */
	public String getApprovals(){
		return approvals;
	}
	public void setApprovals(String approvals){
		this.approvals = approvals;
	}
}