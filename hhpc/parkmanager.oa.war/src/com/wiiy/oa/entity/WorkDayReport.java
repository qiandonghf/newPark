package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.User;
import com.wiiy.oa.preferences.enums.ReportStatusEnum;
import com.wiiy.oa.preferences.enums.WorkReportStatusEnum;

/**
 * <br/>class-description 工作日报
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class WorkDayReport extends BaseEntity implements Serializable {
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
	 * 内容
	 */
	@FieldDescription("内容")
	private String content;
	/**
	 * 计划
	 */
	@FieldDescription("计划")
	private String playContent;
	/**
	 * 当天时间
	 */
	@FieldDescription("当天时间")
	private Date curDate;
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
	 * 周数
	 */
	@FieldDescription("周数")
	private Integer weekNo;
	/**
	 * 天数
	 */
	@FieldDescription("天数")
	private Integer dayNo;
	/**
	 * 工作状态
	 */
	@FieldDescription("工作状态")
	private ReportStatusEnum process;
	/**
	 * 工作状态汇总
	 */
	@FieldDescription("工作状态汇总")
	private String processStr;
	/**
	 * 汇报状态
	 */
	@FieldDescription("汇报状态")
	private WorkReportStatusEnum status;
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
	 * 内容
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
	/**
	 * 计划
	 */
	public String getPlayContent(){
		return playContent;
	}
	public void setPlayContent(String playContent){
		this.playContent = playContent;
	}
	/**
	 * 当天时间
	 */
	public Date getCurDate(){
		return curDate;
	}
	public void setCurDate(Date curDate){
		this.curDate = curDate;
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
	 * 周数
	 */
	public Integer getWeekNo(){
		return weekNo;
	}
	public void setWeekNo(Integer weekNo){
		this.weekNo = weekNo;
	}
	/**
	 * 天数
	 */
	public Integer getDayNo(){
		return dayNo;
	}
	public void setDayNo(Integer dayNo){
		this.dayNo = dayNo;
	}
	/**
	 * 工作状态
	 */
	public ReportStatusEnum getProcess(){
		return process;
	}
	public void setProcess(ReportStatusEnum process){
		this.process = process;
	}
	/**
	 * 工作状态汇总
	 */
	public String getProcessStr(){
		return processStr;
	}
	public void setProcessStr(String processStr){
		this.processStr = processStr;
	}
	/**
	 * 汇报状态
	 */
	public WorkReportStatusEnum getStatus(){
		return status;
	}
	public void setStatus(WorkReportStatusEnum status){
		this.status = status;
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
	@Override
	public String toString() {
		return "WorkDayReport [curDate=" + curDate + ", yearNo=" + yearNo
				+ ", monthNo=" + monthNo + ", weekNo=" + weekNo + ", dayNo="
				+ dayNo + "]";
	}
	
}