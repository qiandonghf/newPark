package com.wiiy.crm.dto;

import java.util.Date;

public class ParkLogDto {
	
	private long id;
	private String logType;//日志类型
	private String logData;//日至类容
	private Date logTime;//日至时间
	private String logCustormer;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getLogCustormer() {
		return logCustormer;
	}
	public void setLogCustormer(String logCustormer) {
		this.logCustormer = logCustormer;
	}
	public String getLogType() {
		return logType;
	}
	public void setLogType(String logType) {
		this.logType = logType;
	}
	public String getLogData() {
		return logData;
	}
	public void setLogData(String logData) {
		this.logData = logData;
	}
	public Date getLogTime() {
		return logTime;
	}
	public void setLogTime(Date logTime) {
		this.logTime = logTime;
	}
	
}
