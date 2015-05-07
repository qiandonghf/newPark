package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 用印申请
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class SealApply extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 用印名称
	 */
	@FieldDescription("用印名称")
	private String name;
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
	 * 申请项目
	 */
	@FieldDescription("申请项目")
	private String project;
	/**
	 * 申请内容
	 */
	@FieldDescription("申请内容")
	private String content;
	/**
	 * 用印数量
	 */
	@FieldDescription("用印数量")
	private String cnt;
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
	 * 用印名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
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
	 * 申请项目
	 */
	public String getProject(){
		return project;
	}
	public void setProject(String project){
		this.project = project;
	}
	/**
	 * 申请内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 用印数量
	 */
	public String getCnt(){
		return cnt;
	}
	public void setCnt(String cnt){
		this.cnt = cnt;
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