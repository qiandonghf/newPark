package com.wiiy.oa.dto;

import java.util.Date;
import java.util.List;

import com.wiiy.oa.entity.WorkReport;

public class WeekDto {
	Integer week;
	List<Date> dateList;
	Integer num = 0;
	WorkReport workReport;
	List<WorkDayDto> workDayDtoList;
	String finishedTask;
    String unfinishedTask;
	public WorkReport getWorkReport() {
		return workReport;
	}
	public void setWorkReport(WorkReport workReport) {
		this.workReport = workReport;
	}
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public Integer getWeek() {
		return week;
	}
	public void setWeek(Integer week) {
		this.week = week;
	}
	public List<Date> getDateList() {
		return dateList;
	}
	public void setDateList(List<Date> dateList) {
		this.dateList = dateList;
	}
	public List<WorkDayDto> getWorkDayDtoList() {
		return workDayDtoList;
	}
	public void setWorkDayDtoList(List<WorkDayDto> workDayDtoList) {
		this.workDayDtoList = workDayDtoList;
	}
	public String getFinishedTask() {
		return finishedTask;
	}
	public void setFinishedTask(String finishedTask) {
		this.finishedTask = finishedTask;
	}
	public String getUnfinishedTask() {
		return unfinishedTask;
	}
	public void setUnfinishedTask(String unfinishedTask) {
		this.unfinishedTask = unfinishedTask;
	}
	
}
