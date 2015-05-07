package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.commons.preferences.enums.BooleanEnum;
import com.wiiy.core.entity.User;
import com.wiiy.oa.entity.Task;
import com.wiiy.oa.entity.TaskAtt;
import com.wiiy.oa.entity.TaskDepartConfig;
import com.wiiy.oa.entity.TaskProject;
import com.wiiy.oa.preferences.enums.PriorityEnum;
import com.wiiy.oa.preferences.enums.PromotEnum;
import com.wiiy.oa.preferences.enums.RepeatEnum;
import com.wiiy.oa.preferences.enums.SubTaskStatusEnum;
import com.wiiy.oa.preferences.enums.TaskStatusEnum;

/**
 * <br/>class-description 任务
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Task extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 父任务
	 */
	@FieldDescription("父任务")
	private Task parent;
	/**
	 * 接收人
	 */
	@FieldDescription("接收人")
	private User receiver;
	/**
	 * 任务项目
	 */
	@FieldDescription("任务项目")
	private TaskProject project;
	/**
	 * 父任务外键
	 */
	@FieldDescription("父任务外键")
	private Long parentId;
	/**
	 * 父链
	 */
	@FieldDescription("父链")
	private String parentIds;
	/**
	 * 接收人Ids
	 */
	@FieldDescription("接收人Ids")
	private String receiverIds;
	/**
	 * 接收人外键
	 */
	@FieldDescription("接收人外键")
	private Long receiverId;
	/**
	 * 子任务状态
	 */
	@FieldDescription("子任务状态")
	private SubTaskStatusEnum childStatus;
	/**
	 * 主题
	 */
	@FieldDescription("主题")
	private String title;
	/**
	 * 开始时间
	 */
	@FieldDescription("开始时间")
	private Date startTime;
	/**
	 * 截止时间
	 */
	@FieldDescription("截止时间")
	private Date endTime;
	/**
	 * 提醒时间
	 */
	@FieldDescription("提醒时间")
	private Date promotTime;
	/**
	 * 完成时间
	 */
	@FieldDescription("完成时间")
	private Date finishTime;
	/**
	 * 进度
	 */
	@FieldDescription("进度")
	private Integer progress;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private TaskStatusEnum status;
	/**
	 * 提醒方式
	 */
	@FieldDescription("提醒方式")
	private PromotEnum promot;
	/**
	 * 提醒详情
	 */
	@FieldDescription("提醒详情")
	private String promotDetail;
	/**
	 * 重复
	 */
	@FieldDescription("重复")
	private RepeatEnum repeatType;
	/**
	 * 是否仅删除当天
	 */
	@FieldDescription("是否仅删除当天")
	private BooleanEnum deleted;
	private Long defaultEmailId;
	/**
	 * 默认邮件(内部)
	 */
	@FieldDescription("默认邮件(内部)")
	private BooleanEnum defaultEmail;
	private Long emailId;
	/**
	 * 外部邮件
	 */
	@FieldDescription("外部邮件")
	private BooleanEnum email;
	private Long smsId;
	/**
	 * 短信
	 */
	@FieldDescription("短信")
	private BooleanEnum sms;
	/**
	 * 优先级
	 */
	@FieldDescription("优先级")
	private PriorityEnum priority;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String memo;
	/**
	 * 任务项目外键
	 */
	@FieldDescription("任务项目外键")
	private Long projectId;
	private Set<TaskDepartConfig> departConfigs;
	private Set<TaskAtt> atts;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 父任务
	 */
	public Task getParent(){
		return parent;
	}
	public void setParent(Task parent){
		this.parent = parent;
	}
	/**
	 * 接收人
	 */
	public User getReceiver(){
		return receiver;
	}
	public void setReceiver(User receiver){
		this.receiver = receiver;
	}
	/**
	 * 任务项目
	 */
	public TaskProject getProject(){
		return project;
	}
	public void setProject(TaskProject project){
		this.project = project;
	}
	/**
	 * 父任务外键
	 */
	public Long getParentId(){
		return parentId;
	}
	public void setParentId(Long parentId){
		this.parentId = parentId;
	}
	/**
	 * 父链
	 */
	public String getParentIds(){
		return parentIds;
	}
	public void setParentIds(String parentIds){
		this.parentIds = parentIds;
	}
	/**
	 * 接收人Ids
	 */
	public String getReceiverIds(){
		return receiverIds;
	}
	public void setReceiverIds(String receiverIds){
		this.receiverIds = receiverIds;
	}
	/**
	 * 接收人外键
	 */
	public Long getReceiverId(){
		return receiverId;
	}
	public void setReceiverId(Long receiverId){
		this.receiverId = receiverId;
	}
	/**
	 * 子任务状态
	 */
	public SubTaskStatusEnum getChildStatus(){
		return childStatus;
	}
	public void setChildStatus(SubTaskStatusEnum childStatus){
		this.childStatus = childStatus;
	}
	/**
	 * 主题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
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
	 * 截止时间
	 */
	public Date getEndTime(){
		return endTime;
	}
	public void setEndTime(Date endTime){
		this.endTime = endTime;
	}
	/**
	 * 提醒时间
	 */
	public Date getPromotTime(){
		return promotTime;
	}
	public void setPromotTime(Date promotTime){
		this.promotTime = promotTime;
	}
	/**
	 * 完成时间
	 */
	public Date getFinishTime(){
		return finishTime;
	}
	public void setFinishTime(Date finishTime){
		this.finishTime = finishTime;
	}
	/**
	 * 进度
	 */
	public Integer getProgress(){
		return progress;
	}
	public void setProgress(Integer progress){
		this.progress = progress;
	}
	/**
	 * 状态
	 */
	public TaskStatusEnum getStatus(){
		return status;
	}
	public void setStatus(TaskStatusEnum status){
		this.status = status;
	}
	/**
	 * 提醒方式
	 */
	public PromotEnum getPromot(){
		return promot;
	}
	public void setPromot(PromotEnum promot){
		this.promot = promot;
	}
	/**
	 * 提醒详情
	 */
	public String getPromotDetail(){
		return promotDetail;
	}
	public void setPromotDetail(String promotDetail){
		this.promotDetail = promotDetail;
	}
	/**
	 * 重复
	 */
	public RepeatEnum getRepeatType(){
		return repeatType;
	}
	public void setRepeatType(RepeatEnum repeatType){
		this.repeatType = repeatType;
	}
	/**
	 * 是否仅删除当天
	 */
	public BooleanEnum getDeleted(){
		return deleted;
	}
	public void setDeleted(BooleanEnum deleted){
		this.deleted = deleted;
	}
	public Long getDefaultEmailId(){
		return defaultEmailId;
	}
	public void setDefaultEmailId(Long defaultEmailId){
		this.defaultEmailId = defaultEmailId;
	}
	/**
	 * 默认邮件(内部)
	 */
	public BooleanEnum getDefaultEmail(){
		return defaultEmail;
	}
	public void setDefaultEmail(BooleanEnum defaultEmail){
		this.defaultEmail = defaultEmail;
	}
	public Long getEmailId(){
		return emailId;
	}
	public void setEmailId(Long emailId){
		this.emailId = emailId;
	}
	/**
	 * 外部邮件
	 */
	public BooleanEnum getEmail(){
		return email;
	}
	public void setEmail(BooleanEnum email){
		this.email = email;
	}
	public Long getSmsId(){
		return smsId;
	}
	public void setSmsId(Long smsId){
		this.smsId = smsId;
	}
	/**
	 * 短信
	 */
	public BooleanEnum getSms(){
		return sms;
	}
	public void setSms(BooleanEnum sms){
		this.sms = sms;
	}
	/**
	 * 优先级
	 */
	public PriorityEnum getPriority(){
		return priority;
	}
	public void setPriority(PriorityEnum priority){
		this.priority = priority;
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
	 * 任务项目外键
	 */
	public Long getProjectId(){
		return projectId;
	}
	public void setProjectId(Long projectId){
		this.projectId = projectId;
	}
	public Set<TaskDepartConfig> getDepartConfigs(){
		return departConfigs;
	}
	public void setDepartConfigs(Set<TaskDepartConfig> departConfigs){
		this.departConfigs = departConfigs;
	}
	public Set<TaskAtt> getAtts(){
		return atts;
	}
	public void setAtts(Set<TaskAtt> atts){
		this.atts = atts;
	}
}