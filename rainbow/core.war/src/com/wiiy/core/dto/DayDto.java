package com.wiiy.core.dto;

import java.util.Date;
import java.util.List;

//import com.wiiy.synthesis.entity.Schedule;

public class DayDto {
	private String day;
	private Integer daySign;
	private Date date;
	private boolean nowDate;
	private boolean thisMonth = true;
	private boolean thisWeek;
	private boolean checkedDay;
	private List schedules;
	private Integer normalSignInNum;//签到情况正常数
	private Integer lateSignInNum;//签到情况迟到数
	private Integer normalSignOutNum;//签退情况正常数
	private Integer leaveEarlyNum;//签退情况早退数
	
	public boolean isNowDate() {
		return nowDate;
	}
	public void setNowDate(boolean nowDate) {
		this.nowDate = nowDate;
	}
	public boolean isThisMonth() {
		return thisMonth;
	}
	public void setThisMonth(boolean thisMonth) {
		this.thisMonth = thisMonth;
	}
	public boolean isCheckedDay() {
		return checkedDay;
	}
	public void setCheckedDay(boolean checkedDay) {
		this.checkedDay = checkedDay;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public List getSchedules() {
		return schedules;
	}
	public void setSchedules(List schedules) {
		this.schedules = schedules;
	}
	public boolean isThisWeek() {
		return thisWeek;
	}
	public void setThisWeek(boolean thisWeek) {
		this.thisWeek = thisWeek;
	}
	public Integer getDaySign() {
		return daySign;
	}
	public void setDaySign(Integer daySign) {
		this.daySign = daySign;
	}
	public Integer getNormalSignInNum() {
		return normalSignInNum;
	}
	public void setNormalSignInNum(Integer normalSignInNum) {
		this.normalSignInNum = normalSignInNum;
	}
	public Integer getLateSignInNum() {
		return lateSignInNum;
	}
	public void setLateSignInNum(Integer lateSignInNum) {
		this.lateSignInNum = lateSignInNum;
	}
	public Integer getNormalSignOutNum() {
		return normalSignOutNum;
	}
	public void setNormalSignOutNum(Integer normalSignOutNum) {
		this.normalSignOutNum = normalSignOutNum;
	}
	public Integer getLeaveEarlyNum() {
		return leaveEarlyNum;
	}
	public void setLeaveEarlyNum(Integer leaveEarlyNum) {
		this.leaveEarlyNum = leaveEarlyNum;
	}
}
