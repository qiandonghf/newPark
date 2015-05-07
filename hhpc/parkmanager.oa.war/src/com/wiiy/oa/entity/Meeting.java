package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.core.entity.DataDict;

/**
 * <br/>class-description 会议纪要
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class Meeting extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 会议类型
	 */
	@FieldDescription("会议类型")
	private DataDict meetingType;
	/**
	 * 会议主题
	 */
	@FieldDescription("会议主题")
	private String title;
	/**
	 * 会议时间
	 */
	@FieldDescription("会议时间")
	private Date meetingTime;
	/**
	 * 会议类型外键
	 */
	@FieldDescription("会议类型外键")
	private String meetingTypeId;
	/**
	 * 备注
	 */
	@FieldDescription("备注")
	private String content;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 会议类型
	 */
	public DataDict getMeetingType(){
		return meetingType;
	}
	public void setMeetingType(DataDict meetingType){
		this.meetingType = meetingType;
	}
	/**
	 * 会议主题
	 */
	public String getTitle(){
		return title;
	}
	public void setTitle(String title){
		this.title = title;
	}
	/**
	 * 会议时间
	 */
	public Date getMeetingTime(){
		return meetingTime;
	}
	public void setMeetingTime(Date meetingTime){
		this.meetingTime = meetingTime;
	}
	/**
	 * 会议类型外键
	 */
	public String getMeetingTypeId(){
		return meetingTypeId;
	}
	public void setMeetingTypeId(String meetingTypeId){
		this.meetingTypeId = meetingTypeId;
	}
	/**
	 * 备注
	 */
	public String getContent(){
		return content;
	}
	public void setContent(String content){
		this.content = content;
	}
}