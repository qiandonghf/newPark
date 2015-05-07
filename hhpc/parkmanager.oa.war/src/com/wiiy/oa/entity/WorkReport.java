package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;
import com.wiiy.oa.preferences.enums.WorkReportEnum;
import com.wiiy.oa.preferences.enums.WorkReportOffsetEnum;
import com.wiiy.oa.preferences.enums.WorkReportStatusEnum;

/**
 * <br/>class-description 工作汇报
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class WorkReport extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 汇报人
	 */
	@FieldDescription("汇报人")
	private User reporter;
	/**
	 * 接收人
	 */
	@FieldDescription("接收人")
	private String receiver;
	/**
	 * 已完成工作
	 */
	@FieldDescription("已完成工作")
	private String finishWork;
	/**
	 * 未完成工作
	 */
	@FieldDescription("未完成工作")
	private String unfinishWork;
	/**
	 * 原因对策
	 */
	@FieldDescription("原因对策")
	private String reason;
	/**
	 * 下周/月计划
	 */
	@FieldDescription("下周/月计划")
	private String nextContect;
	/**
	 * 资源需求
	 */
	@FieldDescription("资源需求")
	private String resourceNeeds;
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
	 * 年份
	 */
	@FieldDescription("年份")
	private Integer yearNo;
	/**
	 * 月份
	 */
	@FieldDescription("月份")
	private Integer monthNo;
	/**
	 * 周
	 */
	@FieldDescription("周")
	private Integer weekNo;
	/**
	 * 类型
	 */
	@FieldDescription("类型")
	private WorkReportEnum type;
	/**
	 * 状态
	 */
	@FieldDescription("状态")
	private WorkReportStatusEnum status;
	/**
	 * 计划偏差
	 */
	@FieldDescription("计划偏差")
	private WorkReportOffsetEnum offset;
	/**
	 * 汇报人Id
	 */
	@FieldDescription("汇报人Id")
	private Long reporterId;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 汇报人
	 */
	public User getReporter(){
		return reporter;
	}
	public void setReporter(User reporter){
		this.reporter = reporter;
	}
	/**
	 * 接收人
	 */
	public String getReceiver(){
		return receiver;
	}
	public void setReceiver(String receiver){
		this.receiver = receiver;
	}
	/**
	 * 已完成工作
	 */
	public String getFinishWork(){
		return finishWork;
	}
	public void setFinishWork(String finishWork){
		this.finishWork = finishWork;
	}
	/**
	 * 未完成工作
	 */
	public String getUnfinishWork(){
		return unfinishWork;
	}
	public void setUnfinishWork(String unfinishWork){
		this.unfinishWork = unfinishWork;
	}
	/**
	 * 原因对策
	 */
	public String getReason(){
		return reason;
	}
	public void setReason(String reason){
		this.reason = reason;
	}
	/**
	 * 下周/月计划
	 */
	public String getNextContect(){
		return nextContect;
	}
	public void setNextContect(String nextContect){
		this.nextContect = nextContect;
	}
	/**
	 * 资源需求
	 */
	public String getResourceNeeds(){
		return resourceNeeds;
	}
	public void setResourceNeeds(String resourceNeeds){
		this.resourceNeeds = resourceNeeds;
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
	 * 年份
	 */
	public Integer getYearNo(){
		return yearNo;
	}
	public void setYearNo(Integer yearNo){
		this.yearNo = yearNo;
	}
	/**
	 * 月份
	 */
	public Integer getMonthNo(){
		return monthNo;
	}
	public void setMonthNo(Integer monthNo){
		this.monthNo = monthNo;
	}
	/**
	 * 周
	 */
	public Integer getWeekNo(){
		return weekNo;
	}
	public void setWeekNo(Integer weekNo){
		this.weekNo = weekNo;
	}
	/**
	 * 类型
	 */
	public WorkReportEnum getType(){
		return type;
	}
	public void setType(WorkReportEnum type){
		this.type = type;
	}
	/**
	 * 状态
	 */
	public WorkReportStatusEnum getStatus(){
		return status;
	}
	public void setStatus(WorkReportStatusEnum status){
		this.status = status;
	}
	/**
	 * 计划偏差
	 */
	public WorkReportOffsetEnum getOffset(){
		return offset;
	}
	public void setOffset(WorkReportOffsetEnum offset){
		this.offset = offset;
	}
	/**
	 * 汇报人Id
	 */
	public Long getReporterId(){
		return reporterId;
	}
	public void setReporterId(Long reporterId){
		this.reporterId = reporterId;
	}
}