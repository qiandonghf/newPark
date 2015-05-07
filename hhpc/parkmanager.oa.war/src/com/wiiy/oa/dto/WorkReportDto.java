package com.wiiy.oa.dto;

import com.wiiy.oa.entity.WorkReport;


public class WorkReportDto extends WeekDto {
	

	private Integer num = 0;// 0:未编辑       1:暂存      2:提交
	private WorkReport workReport;
	private String name;
	private Integer weekNo;
	private Integer monthNo;
	private Integer yearNo;
	private String reporterName;//汇报人名称
	private Integer dayCount;//日报数量
	private Integer weekCount;//周报数量
	private Integer monthCount;//月报数量
	
	private Boolean reportedWeek = false;//判断是否已经提交周报
	private Boolean reportedMonth = false;//判断是否已经提交过月报
	
	
	public Boolean getReportedWeek() {
		return reportedWeek;
	}
	public void setReportedWeek(Boolean reportedWeek) {
		this.reportedWeek = reportedWeek;
	}
	public Boolean getReportedMonth() {
		return reportedMonth;
	}
	public void setReportedMonth(Boolean reportedMonth) {
		this.reportedMonth = reportedMonth;
	}
	public Integer getWeekCount() {
		return weekCount;
	}
	public void setWeekCount(Integer weekCount) {
		this.weekCount = weekCount;
	}
	public Integer getMonthCount() {
		return monthCount;
	}
	public void setMonthCount(Integer monthCount) {
		this.monthCount = monthCount;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public WorkReport getWorkReport() {
		return workReport;
	}
	public void setWorkReport(WorkReport workReport) {
		this.workReport = workReport;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getWeekNo() {
		return weekNo;
	}
	public void setWeekNo(Integer weekNo) {
		this.weekNo = weekNo;
	}
	public Integer getMonthNo() {
		return monthNo;
	}
	public void setMonthNo(Integer monthNo) {
		this.monthNo = monthNo;
	}
	public Integer getYearNo() {
		return yearNo;
	}
	public void setYearNo(Integer yearNo) {
		this.yearNo = yearNo;
	}
	public Integer getDayCount() {
		return dayCount;
	}
	public void setDayCount(Integer dayCount) {
		this.dayCount = dayCount;
	}
	public String getReporterName() {
		return reporterName;
	}
	public void setReporterName(String reporterName) {
		this.reporterName = reporterName;
	}
	
	
	
	

}
