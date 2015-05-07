package com.wiiy.core.dto;

import java.io.Serializable;
import java.util.Date;


/**
 * @author qd
 */
public class BlackListDto implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long id;
	private String incubatorName;//孵化器名称
	private String content;//描述
	private String inTime;//加入黑名单日期
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIncubatorName() {
		return incubatorName;
	}
	public void setIncubatorName(String incubatorName) {
		this.incubatorName = incubatorName;
	}
	public String getInTime() {
		return inTime;
	}
	public void setInTime(String inTime) {
		this.inTime = inTime;
	}
	
	

}