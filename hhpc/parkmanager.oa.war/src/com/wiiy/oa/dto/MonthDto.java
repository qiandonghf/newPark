package com.wiiy.oa.dto;

import java.util.ArrayList;
import java.util.List;

public class MonthDto {
	Integer year;
	Integer month;
	List<WeekDto> weekList;
	Integer num = 0;
	List<DayDto> dayDtoList;
	Integer normalSignInNumPerMonth;//每月签到情况正常数
	Integer lateSignInNumPerMonth;//每月签到情况迟到数
	Integer normalSignOutNumPerMonth;//每月签退情况正常数
	Integer leaveEarlyNumPerMonth;//每月签退情况早退数
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public MonthDto() {
		weekList = new ArrayList<WeekDto>();
	}
	public Integer getMonth() {
		return month;
	}
	public void setMonth(Integer month) {
		this.month = month;
	}
	public List<WeekDto> getWeekList() {
		return weekList;
	}
	public void setWeekList(List<WeekDto> weekList) {
		this.weekList = weekList;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public List<DayDto> getDayDtoList() {
		return dayDtoList;
	}
	public void setDayDtoList(List<DayDto> dayDtoList) {
		this.dayDtoList = dayDtoList;
	}
	public Integer getNormalSignInNumPerMonth() {
		return normalSignInNumPerMonth;
	}
	public void setNormalSignInNumPerMonth(Integer normalSignInNumPerMonth) {
		this.normalSignInNumPerMonth = normalSignInNumPerMonth;
	}
	public Integer getLateSignInNumPerMonth() {
		return lateSignInNumPerMonth;
	}
	public void setLateSignInNumPerMonth(Integer lateSignInNumPerMonth) {
		this.lateSignInNumPerMonth = lateSignInNumPerMonth;
	}
	public Integer getNormalSignOutNumPerMonth() {
		return normalSignOutNumPerMonth;
	}
	public void setNormalSignOutNumPerMonth(Integer normalSignOutNumPerMonth) {
		this.normalSignOutNumPerMonth = normalSignOutNumPerMonth;
	}
	public Integer getLeaveEarlyNumPerMonth() {
		return leaveEarlyNumPerMonth;
	}
	public void setLeaveEarlyNumPerMonth(Integer leaveEarlyNumPerMonth) {
		this.leaveEarlyNumPerMonth = leaveEarlyNumPerMonth;
	}
}
