package com.wiiy.oa.entity;

import java.io.Serializable;
import java.util.Date;

import com.wiiy.commons.annotation.FieldDescription;
import com.wiiy.commons.entity.BaseEntity;

/**
 * <br/>class-description 会议室租用
 * <br/>extends com.wiiy.commons.entity.BaseEntity
 */
public class MeetingRoomRent extends BaseEntity implements Serializable {
	/** 
	 * 
	 */ 
	private static final long serialVersionUID = 1L;
	private Long id;
	/**
	 * 借用单位
	 */
	@FieldDescription("借用单位")
	private String company;
	/**
	 * 借用时间
	 */
	@FieldDescription("借用时间")
	private Date rentTime;
	/**
	 * 联系电话
	 */
	@FieldDescription("联系电话")
	private String phone;
	/**
	 * 联系人
	 */
	@FieldDescription("联系人")
	private String linkman;
	/**
	 * 借用理由
	 */
	@FieldDescription("借用理由")
	private String reason;
	/**
	 * 参会人数
	 */
	@FieldDescription("参会人数")
	private String cnt;
	/**
	 * 借用场地
	 */
	@FieldDescription("借用场地")
	private String meetingRoom;
	/**
	 * 办公室意见
	 */
	@FieldDescription("办公室意见")
	private String approval;

	public Long getId(){
		return id;
	}
	public void setId(Long id){
		this.id = id;
	}
	/**
	 * 借用单位
	 */
	public String getCompany(){
		return company;
	}
	public void setCompany(String company){
		this.company = company;
	}
	/**
	 * 借用时间
	 */
	public Date getRentTime(){
		return rentTime;
	}
	public void setRentTime(Date rentTime){
		this.rentTime = rentTime;
	}
	/**
	 * 联系电话
	 */
	public String getPhone(){
		return phone;
	}
	public void setPhone(String phone){
		this.phone = phone;
	}
	/**
	 * 联系人
	 */
	public String getLinkman(){
		return linkman;
	}
	public void setLinkman(String linkman){
		this.linkman = linkman;
	}
	/**
	 * 借用理由
	 */
	public String getReason(){
		return reason;
	}
	public void setReason(String reason){
		this.reason = reason;
	}
	/**
	 * 参会人数
	 */
	public String getCnt(){
		return cnt;
	}
	public void setCnt(String cnt){
		this.cnt = cnt;
	}
	/**
	 * 借用场地
	 */
	public String getMeetingRoom(){
		return meetingRoom;
	}
	public void setMeetingRoom(String meetingRoom){
		this.meetingRoom = meetingRoom;
	}
	/**
	 * 办公室意见
	 */
	public String getApproval(){
		return approval;
	}
	public void setApproval(String approval){
		this.approval = approval;
	}
}