package com.wiiy.oa.dto;

import java.util.Date;
import java.util.List;

public class FinishWorkDto {
	private Integer week;
	private List<Date> dateList;
	private Integer finishNum;//完成任务数量
	private Integer abortedNum;//中止任务数量
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
	public Integer getFinishNum() {
		return finishNum;
	}
	public void setFinishNum(Integer finishNum) {
		this.finishNum = finishNum;
	}
	public Integer getAbortedNum() {
		return abortedNum;
	}
	public void setAbortedNum(Integer abortedNum) {
		this.abortedNum = abortedNum;
	}
	
}
