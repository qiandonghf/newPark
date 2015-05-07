package com.wiiy.oa.entity;

import java.io.Serializable;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;
import com.wiiy.oa.entity.Meeting;

/**
 * <br/>class-description 会议机要附件
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class MeetingAtt extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 会议机要
	 */
	@FieldDescription("会议机要")
	private Meeting meeting;
	/**
	 * 会议机要外键
	 */
	@FieldDescription("会议机要外键")
	private Long meetingId;
	/**
	 * 附件名称
	 */
	@FieldDescription("附件名称")
	private String name;
	/**
	 * 重命名名称
	 */
	@FieldDescription("重命名名称")
	private String newName;
	/**
	 * 附件大小
	 */
	@FieldDescription("附件大小")
	private Long size;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 会议机要
	 */
	public Meeting getMeeting(){
		return meeting;
	}
	public void setMeeting(Meeting meeting){
		this.meeting = meeting;
	}
	/**
	 * 会议机要外键
	 */
	public Long getMeetingId(){
		return meetingId;
	}
	public void setMeetingId(Long meetingId){
		this.meetingId = meetingId;
	}
	/**
	 * 附件名称
	 */
	public String getName(){
		return name;
	}
	public void setName(String name){
		this.name = name;
	}
	/**
	 * 重命名名称
	 */
	public String getNewName(){
		return newName;
	}
	public void setNewName(String newName){
		this.newName = newName;
	}
	/**
	 * 附件大小
	 */
	public Long getSize(){
		return size;
	}
	public void setSize(Long size){
		this.size = size;
	}
}