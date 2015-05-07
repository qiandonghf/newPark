package com.wiiy.crm.entity;

import java.io.Serializable;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.Approval;
import com.wiiy.crm.entity.InvestmentProcessAtt;
import com.wiiy.core.preferences.enums.CountersignOpenEnum;

/**
 * <br/>class-description 流程联系单
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class InvestmentProcess extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 财务部审批
	 */
	@FieldDescription("财务部审批")
	private Approval cwbApproval;
	/**
	 * 工程部审批
	 */
	@FieldDescription("工程部审批")
	private Approval gcb;
	/**
	 * 入住企业代表确认
	 */
	@FieldDescription("入住企业代表确认")
	private Approval rzqy;
	/**
	 * 入住企业
	 */
	@FieldDescription("入住企业")
	private String name;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private String contect;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 项目
	 */
	@FieldDescription("项目")
	private String projectMemo;
	/**
	 * 项目ID
	 */
	@FieldDescription("项目ID")
	private Long investmentId;
	/**
	 * 招商部意见
	 */
	@FieldDescription("招商部意见")
	private String businessmanSuggestion;
	/**
	 * 财务部审批ID
	 */
	@FieldDescription("财务部审批ID")
	private Long cwbApprovalId;
	/**
	 * 工程部审批ID
	 */
	@FieldDescription("工程部审批ID")
	private Long gcbApprovalId;
	/**
	 * 入住企业代表确认ID
	 */
	@FieldDescription("入住企业代表确认ID")
	private Long rzqyApprovalId;
	/**
	 * 会签状态
	 */
	@FieldDescription("会签状态")
	private CountersignOpenEnum countersignStatus;
	/**
	 * 其他说明
	 */
	@FieldDescription("其他说明")
	private String other;
	

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 财务部审批
	 */
	public Approval getCwbApproval(){
		return cwbApproval;
	}
	public void setCwbApproval(Approval cwbApproval){
		this.cwbApproval = cwbApproval;
	}
	/**
	 * 工程部审批
	 */
	public Approval getGcb(){
		return gcb;
	}
	public void setGcb(Approval gcb){
		this.gcb = gcb;
	}
	/**
	 * 入住企业代表确认
	 */
	public Approval getRzqy(){
		return rzqy;
	}
	public void setRzqy(Approval rzqy){
		this.rzqy = rzqy;
	}
	/**
	 * 入住企业
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 联系人
	 */
	public String getContect(){
		return contect;
	}
	public void setContect(String contect){
		this.contect = contect;
	}
	/**
	 * 联系电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 项目
	 */
	public String getProjectMemo(){
		return projectMemo;
	}
	public void setProjectMemo(String projectMemo){
		this.projectMemo = projectMemo;
	}
	/**
	 * 项目ID
	 */
	public Long getInvestmentId(){
		return investmentId;
	}
	public void setInvestmentId(Long investmentId){
		this.investmentId = investmentId;
	}
	/**
	 * 招商部意见
	 */
	public String getBusinessmanSuggestion(){
		return businessmanSuggestion;
	}
	public void setBusinessmanSuggestion(String businessmanSuggestion){
		this.businessmanSuggestion = businessmanSuggestion;
	}
	/**
	 * 财务部审批ID
	 */
	public Long getCwbApprovalId(){
		return cwbApprovalId;
	}
	public void setCwbApprovalId(Long cwbApprovalId){
		this.cwbApprovalId = cwbApprovalId;
	}
	/**
	 * 工程部审批ID
	 */
	public Long getGcbApprovalId(){
		return gcbApprovalId;
	}
	public void setGcbApprovalId(Long gcbApprovalId){
		this.gcbApprovalId = gcbApprovalId;
	}
	/**
	 * 入住企业代表确认ID
	 */
	public Long getRzqyApprovalId(){
		return rzqyApprovalId;
	}
	public void setRzqyApprovalId(Long rzqyApprovalId){
		this.rzqyApprovalId = rzqyApprovalId;
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
	/**
	 * 其他说明
	 */
	public String getOther(){
		return other;
	}
	public void setOther(String other){
		this.other = other;
	}
}